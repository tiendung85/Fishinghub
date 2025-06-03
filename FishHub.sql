
USE master;
GO


ALTER DATABASE FishingHub
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO


DROP DATABASE FishingHub;
GO

CREATE DATABASE FishingHub;
GO
USE FishingHub;
GO

-- Roles
CREATE TABLE Role (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL
);



-- Users
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(11), 
    Password NVARCHAR(255),
    GoogleId NVARCHAR(255), 
    RoleId INT,
    Gender NVARCHAR(10),
    DateOfBirth DATE,
    Location NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (RoleId) REFERENCES Role(RoleId)
);

-- Categories
CREATE TABLE Category (
    CategoryId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL
);

-- Products
CREATE TABLE Product (
    ProductId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(255) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Image NVARCHAR(255),
    StockQuantity INT NOT NULL,
    SoldQuantity INT DEFAULT 0,
    CategoryId INT,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- ShoppingCart
CREATE TABLE ShoppingCart (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT,
    ProductId INT,
    CartQuantity INT NOT NULL CHECK (CartQuantity >= 0),
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
);

CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY,
    StatusName NVARCHAR(50) COLLATE Vietnamese_CI_AS NOT NULL
);

-- Dữ liệu mẫu
INSERT INTO OrderStatus (StatusID, StatusName) VALUES
(1, N'Đang xử lý'),
(2, N'Đang giao hàng'),
(3, N'Hoàn thành'),
(4, N'Đã thanh toán'),
(5, N'Đã hủy');

-- Orders
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
      UserId INT NOT NULL,
    Subtotal DECIMAL(18,2) NOT NULL,
    Total DECIMAL(18,2) NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    StatusID INT NOT NULL DEFAULT 1,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
    FOREIGN KEY (StatusID) REFERENCES OrderStatus(StatusID)
);

-- Đơn hàng 1: Trạng thái Đang xử lý (StatusID = 1)
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (1, 500000, 550000, '2025-05-30 10:30:00', 1);

-- Đơn hàng 2: Dùng mặc định (StatusID = 1, OrderDate = GETDATE())
INSERT INTO Orders (UserId, Subtotal, Total)
VALUES (2, 1200000, 1250000);

-- Đơn hàng 3: Trạng thái Hoàn thành (StatusID = 3)
INSERT INTO Orders (UserId, Subtotal, Total, StatusID)
VALUES (3, 250000, 270000, 3);

-- Đơn hàng 4: Đang xử lý (StatusID = 1)
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (2, 300000, 330000, '2025-05-29 09:15:00', 1);

-- Đơn hàng 5: Mặc định (StatusID = 1, OrderDate = GETDATE())
INSERT INTO Orders (UserId, Subtotal, Total)
VALUES (3, 750000, 800000);

-- Đơn hàng 6: Đã hủy (StatusID = 4)
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (2, 400000, 420000, '2025-05-28 14:20:00', 4);

-- Đơn hàng 7: Hoàn thành (StatusID = 3)
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (1, 180000, 200000, '2025-05-27 11:00:00', 3);

-- Đơn hàng 8: Mặc định
INSERT INTO Orders (UserId, Subtotal, Total)
VALUES (1, 950000, 1000000);

-- Đơn hàng 9: Đang xử lý
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (3, 220000, 250000, '2025-05-30 08:45:00', 1);

-- Đơn hàng 10: Đã hủy
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (3, 500000, 550000, '2025-05-26 16:10:00', 4);

-- Đơn hàng 11: Hoàn thành
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (1, 620000, 670000, '2025-05-25 13:30:00', 3);

-- Đơn hàng 12: Mặc định
INSERT INTO Orders (UserId, Subtotal, Total)
VALUES (2, 320000, 350000);

-- Đơn hàng 13: Đang xử lý
INSERT INTO Orders (UserId, Subtotal, Total, OrderDate, StatusID)
VALUES (3, 150000, 180000, '2025-05-30 17:55:00', 1);

-- OrderDetails
CREATE TABLE OrderDetail (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    ProductId INT,
    CartQuantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Subtotal AS (CartQuantity * Price) PERSISTED,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
);

-- Events
CREATE TABLE Event (
    EventId INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255) NOT NULL,
	LakeName NVARCHAR(255), 
    Description TEXT,
    Location NVARCHAR(255),
    HostId INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Status NVARCHAR(20) DEFAULT 'pending' CHECK (Status IN ('pending', 'approved', 'rejected')),
    CreatedAt DATETIME DEFAULT GETDATE(),

    ApprovedAt DATETIME,
    PosterUrl NVARCHAR(255), 
    MaxParticipants INT,
	CurrentParticipants INT,
    FOREIGN KEY (HostId) REFERENCES Users(UserId)
);

-- EventParticipants
CREATE TABLE EventParticipant (
    EventId INT NOT NULL,
    UserId INT NOT NULL,
    PRIMARY KEY (EventId, UserId),
    FOREIGN KEY (EventId) REFERENCES Event(EventId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Posts
CREATE TABLE Post (
    PostId INT PRIMARY KEY IDENTITY,
    UserId INT,
    Topic NVARCHAR(50),
    Title NVARCHAR(255),
    Content NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);


CREATE TABLE Image (
    ImageId INT PRIMARY KEY IDENTITY,
    PostId INT,
    ImagePath VARCHAR(255),
    FOREIGN KEY (PostId) REFERENCES Post(PostId)
);
CREATE TABLE Video (
    VideoId INT PRIMARY KEY IDENTITY,
    PostId INT,
    VideoPath VARCHAR(255),
    FOREIGN KEY (PostId) REFERENCES Post(PostId)
);


-- PostComments
CREATE TABLE PostComment (
    CommentId INT PRIMARY KEY IDENTITY,
    PostId INT,
    UserId INT,
    Content NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostId) REFERENCES Post(PostId) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);

CREATE TABLE PostLike (
    PostId INT,
    UserId INT,
    LikedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (PostId, UserId),
    FOREIGN KEY (PostId) REFERENCES Post(PostId) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);

CREATE TABLE CommentLike (
    CommentId INT,
    UserId INT,
    LikedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (CommentId, UserId),
    FOREIGN KEY (CommentId) REFERENCES PostComment(CommentId) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);

CREATE TABLE CommentReply (
    ReplyId INT PRIMARY KEY IDENTITY,
    CommentId INT,
    UserId INT,
    Content NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CommentId) REFERENCES PostComment(CommentId) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);

-- FishSpecies
CREATE TABLE FishSpecies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CommonName NVARCHAR(100) NOT NULL,
    ScientificName NVARCHAR(150),
    Description NVARCHAR(MAX),
    MainImageUrl NVARCHAR(500),

    Bait NVARCHAR(MAX),
    BestSeason NVARCHAR(50),
    BestTimeOfDay NVARCHAR(50),
    FishingSpots NVARCHAR(MAX),
    FishingTechniques NVARCHAR(MAX),

    DifficultyLevel TINYINT CHECK (DifficultyLevel BETWEEN 1 AND 4),
    AverageWeightKg FLOAT,
    AverageLengthCm FLOAT,

    Habitat NVARCHAR(MAX),
    Behavior NVARCHAR(MAX),
    Tips NVARCHAR(MAX)
);


CREATE TABLE FishSpeciesImages (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FishSpeciesId INT NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL,
    IsMain BIT DEFAULT 0,
    

    FOREIGN KEY (FishSpeciesId) REFERENCES FishSpecies(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Cá chép
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá chép', N'Cyprinus carpio', N'Cá nước ngọt phổ biến, có giá trị cao.', N'assets/img/FishKnowledge-images/cachep_0.png',
N'Giun, ngô, khoai', N'Mùa thu', N'Sáng sớm, chiều tối', N'Ao, hồ, sông tĩnh', N'Câu đáy, câu lục',
2, 2.5, 35,
N'Nước ngọt tĩnh', N'Hiền, ăn tầng đáy', N'Sử dụng mồi thơm, tránh gây tiếng động');

-- Ảnh chính cá chép
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(1, N'assets/img/FishKnowledge-images/cachep_0.png', 1);

-- Ảnh phụ cá chép
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(1, N'assets/img/FishKnowledge-images/cachep_1.png', 0),
(1, N'assets/img/FishKnowledge-images/cachep_2.png', 0);


-- Cá lóc
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá lóc', N'Channa striata', N'Cá săn mồi mạnh mẽ, rất phổ biến.', N'assets/img/FishKnowledge-images/caloc_0.png',
N'Ếch, nhái, cá nhỏ', N'Mùa mưa', N'Sáng sớm', N'Ruộng ngập, ao cạn, mương', N'Câu lure, rê mồi sống',
3, 1.2, 30,
N'Nước ngọt, nông', N'Áp sát bờ, săn mồi nhanh', N'Dùng mồi giả nhái, rê sát cỏ');

-- Ảnh chính cá lóc
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(2, N'assets/img/FishKnowledge-images/caloc_0.png', 1);

-- Ảnh phụ cá lóc
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(2, N'assets/img/FishKnowledge-images/caloc_1.png', 0),
(2, N'assets/img/FishKnowledge-images/caloc_2.png', 0);


-- Cá rô đồng
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá rô đồng', N'Anabas testudineus', N'Loài cá nhỏ nhưng khoẻ, ngon.', N'assets/img/FishKnowledge-images/carodong_0.png',
N'Giun, trùn, cám', N'Mùa hè', N'Chiều tối', N'Đồng ruộng, ao nhỏ', N'Câu đơn, lưỡi nhỏ',
1, 0.2, 15,
N'Nước tù, ruộng ngập', N'Lẩn trốn tốt, phản xạ nhanh', N'Dùng lưỡi nhỏ, cước mảnh');

-- Ảnh chính cá rô đồng
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(3, N'assets/img/FishKnowledge-images/carodong_0.png', 1);

-- Ảnh phụ cá rô đồng
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(3, N'assets/img/FishKnowledge-images/carodong_1.png', 0),
(3, N'assets/img/FishKnowledge-images/carodong_2.png', 0);


-- Cá trắm
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá trắm', N'Ctenopharyngodon idella', N'Cá ăn cỏ, kích thước lớn.', N'assets/img/FishKnowledge-images/catram_0.png',
N'Lá mía, rau muống, cám', N'Mùa hè', N'Trưa', N'Hồ lớn, ao nuôi', N'Câu nổi, câu bèo',
3, 4.0, 60,
N'Hồ lớn, sông chậm', N'Ăn thực vật, hiền', N'Dùng rau tươi làm mồi');

-- Ảnh chính cá trắm
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(4, N'assets/img/FishKnowledge-images/catram_0.png', 1);

-- Ảnh phụ cá trắm
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(4, N'assets/img/FishKnowledge-images/catram_1.png', 0),
(4, N'assets/img/FishKnowledge-images/catram_2.png', 0);


-- Cá trê
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá trê', N'Clarias batrachus', N'Cá da trơn, hoạt động về đêm.', N'assets/img/FishKnowledge-images/catre_0.png',
N'Giun, lòng gà, mồi tanh', N'Mùa mưa', N'Tối', N'Ao tù, kênh mương', N'Câu đáy, câu đơn',
2, 1.0, 30,
N'Nước tù, đáy bùn', N'Đi săn đêm, thích mùi tanh', N'Dùng mồi ủ tanh, tránh ánh sáng');

-- Ảnh chính cá trê
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(5, N'assets/img/FishKnowledge-images/catre_0.png', 1);

-- Ảnh phụ cá trê
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(5, N'assets/img/FishKnowledge-images/catre_1.png', 0),
(5, N'assets/img/FishKnowledge-images/catre_2.png', 0);

-- Cá ngạnh
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá ngạnh', N'Mystus spp.', N'Cá da trơn có râu dài.', N'assets/img/FishKnowledge-images/canghanh_0.png',
N'Giun, cá nhỏ, mồi trộn', N'Mùa mưa', N'Ban đêm', N'Sông suối sâu', N'Câu đáy',
3, 0.8, 25,
N'Sông sâu, đáy bùn', N'Hoạt động mạnh ban đêm', N'Mồi ủ kỹ, dùng chì nặng');

-- Ảnh chính cá ngạnh
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(6, N'assets/img/FishKnowledge-images/canghanh_0.png', 1);

-- Ảnh phụ cá ngạnh
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(6, N'assets/img/FishKnowledge-images/canghanh_1.png', 0),
(6, N'assets/img/FishKnowledge-images/canghanh_2.png', 0);

-- Cá tra
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá tra', N'Pangasius hypophthalmus', N'Cá nuôi phổ biến, thịt trắng ngon.', N'assets/img/FishKnowledge-images/catra_0.png',
N'Cám viên, cá nhỏ', N'Quanh năm', N'Sáng sớm', N'Ao nuôi, hồ lớn', N'Câu lục, câu đáy',
2, 2.0, 45,
N'Nước tĩnh, ao hồ', N'Ăn tầng giữa và đáy', N'Mồi cám thơm, dùng lưỡi to');

-- Ảnh chính cá tra
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(7, N'assets/img/FishKnowledge-images/catra_0.png', 1);

-- Ảnh phụ cá tra
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(7, N'assets/img/FishKnowledge-images/catra_1.png', 0),
(7, N'assets/img/FishKnowledge-images/catra_2.png', 0);

-- Cá chim trắng nước ngọt
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá chim trắng nước ngọt', N'Piaractus brachypomus', N'Cá nước ngọt lai nuôi, phàm ăn.', N'assets/img/FishKnowledge-images/cachim_0.png',
N'Cám viên, chuối, ngô', N'Mùa hè', N'Sáng và chiều', N'Hồ dịch vụ', N'Câu lục, câu đơn',
2, 3.0, 40,
N'Ao hồ, nước tĩnh', N'Ăn tạp, bơi nhanh', N'Mồi mềm, móc chắc lưỡi');

-- Ảnh chính cá chim trắng nước ngọt
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(8, N'assets/img/FishKnowledge-images/cachim_0.png', 1);

-- Ảnh phụ cá chim trắng nước ngọt
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(8, N'assets/img/FishKnowledge-images/cachim_1.png', 0),
(8, N'assets/img/FishKnowledge-images/cachim_2.png', 0);

-- Cá lăng
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá lăng', N'Bagarius yarrelli', N'Cá lớn sống vùng nước chảy mạnh.', N'assets/img/FishKnowledge-images/calang_0.png',
N'Cá nhỏ, mồi tanh', N'Mùa mưa', N'Tối', N'Sông sâu, thác ghềnh', N'Câu đáy',
4, 5.0, 70,
N'Sông lớn, nước xiết', N'Săn mồi mạnh về đêm', N'Sử dụng dây chắc, cần khỏe');

-- Ảnh chính cá lăng
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(9, N'assets/img/FishKnowledge-images/calang_0.png', 1);

-- Ảnh phụ cá lăng
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(9, N'assets/img/FishKnowledge-images/calang_1.png', 0),
(9, N'assets/img/FishKnowledge-images/calang_2.png', 0);

-- Cá chày
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá chày', N'Hemibagrus spp.', N'Cá hoang dã, ít gặp.', N'assets/img/FishKnowledge-images/cachay_0.png',
N'Giun, cám thơm', N'Mùa xuân', N'Sáng sớm', N'Suối nhỏ, khe đá', N'Câu rê, câu đáy',
2, 1.0, 30,
N'Suối sạch, đáy cát', N'Đi theo bầy nhỏ', N'Mồi nhẹ, không ồn ào');

-- Ảnh chính cá chày
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(10, N'assets/img/FishKnowledge-images/cachay_0.png', 1);

-- Ảnh phụ cá chày
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(10, N'assets/img/FishKnowledge-images/cachay_1.png', 0),
(10, N'assets/img/FishKnowledge-images/cachay_2.png', 0);

-- Cá sặc
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá sặc', N'Trichogaster spp.', N'Cá nhỏ, phổ biến ở miền Tây.', N'assets/img/FishKnowledge-images/casac_0.png',
N'Cám, trùn', N'Mùa hè', N'Chiều', N'Ruộng, ao nhỏ', N'Câu đơn',
1, 0.3, 12,
N'Nước cạn, ao tù', N'Bơi tầng giữa', N'Mồi nhỏ, cần nhẹ');

-- Ảnh chính cá sặc
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(11, N'assets/img/FishKnowledge-images/casac_0.png', 1);

-- Ảnh phụ cá sặc
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(11, N'assets/img/FishKnowledge-images/casac_1.png', 0),
(11, N'assets/img/FishKnowledge-images/casac_2.png', 0);

-- Cá bống
INSERT INTO FishSpecies (
    CommonName, ScientificName, Description, MainImageUrl,
    Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques,
    DifficultyLevel, AverageWeightKg, AverageLengthCm,
    Habitat, Behavior, Tips
) VALUES
(N'Cá bống', N'Oxyeleotris marmorata', N'Cá đáy, thịt chắc, phổ biến ở sông ngòi.', N'assets/img/FishKnowledge-images/cabong_0.png',
N'Tép, giun, mồi bốc mùi', N'Mùa mưa', N'Tối', N'Sông, kênh, đáy bùn', N'Câu đáy, câu đơn',
2, 0.5, 20,
N'Đáy sông, cát bùn', N'Ẩn nấp tốt', N'Dùng chì chìm, rê sát đáy');

-- Ảnh chính cá bống
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES 
(12, N'assets/img/FishKnowledge-images/cabong_0.png', 1);

-- Ảnh phụ cá bống
INSERT INTO FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain)
VALUES
(12, N'assets/img/FishKnowledge-images/cabong_1.png', 0),
(12, N'assets/img/FishKnowledge-images/cabong_2.png', 0);

DELETE FROM FishSpecies;

DBCC CHECKIDENT ('FishSpecies', RESEED, 0);




-- Fish
CREATE TABLE Fish (
    FishId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(255),
    Point INT NOT NULL,
    FishSpeciesId INT,
    FOREIGN KEY (FishSpeciesId) REFERENCES FishSpecies(Id)
);

-- Achievements
CREATE TABLE Achievement (
    AchievementId INT PRIMARY KEY IDENTITY,
    UserId INT,
    FishId INT,
    Image VARCHAR(255),
    Description TEXT,
    DateAchieved DATE DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (FishId) REFERENCES Fish(FishId)
);

-- Notifications
CREATE TABLE Notification (
    NotificationId INT PRIMARY KEY IDENTITY,
    UserId INT,
    Message TEXT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE password_reset (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    code VARCHAR(20) NOT NULL,
    expires_at DATETIME NOT NULL,
    used BIT DEFAULT 0
);



INSERT INTO Role (RoleName) VALUES  ('User'),('FishingOwner'),('Admin');

INSERT INTO Users (FullName, Email, Phone, Password, GoogleId, RoleId, Gender, DateOfBirth, Location)
VALUES ('Charlie Le', 'charlie@eample.com', '0933444555', 'hashedpassword3', 'google12345', 1, 'Other', '1985-12-01', 'Da ang'),
(N'Nguyễn Tiến Dũng', 'tien.dungg2011@gmail.com', '0933444555', '12345', 'google12345', 1, N'Nam', '1985-12-01', N'Hưng Yên'),
(N'Chu Việt Hải', 'haicv@gmail.com', '0933444555', '12345', 'google12345', 1, N'Nam', '1985-12-01', N'Ba Vì'),
(N'Chu Ngọc Dũng', 'ngocdung@gmail.com', '0933444555', '12345', 'google12345', 2, N'Nam', '1985-12-01', N'Ba Vì');
  
select * from users

select * from image

select * from PostComment

select * from PostLike

INSERT INTO Category (Name) VALUES
(N'Shimano'),     -- CategoryId = 1
(N'Daiwa'),       -- CategoryId = 2
(N'Rapala');     -- CategoryId = 3

INSERT INTO Product (Name, Price, Image, StockQuantity, SoldQuantity, CategoryId) VALUES
(N'Rapala Snow', 2800000.00, 'https://vuadocau.com/wp-content/uploads/2020/02/Rapala-snow-3.png', 50, 12, 3),
(N'Dây dù ( Dây PE) Sufix 832 chính hãng Rapala', 360000.00, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lpsbnugehb6aa2', 78, 43, 3),
(N'Rapala Shadow Baitcasting', 1700000.00, 'https://lh4.googleusercontent.com/proxy/Vub1k7AeGzHBTDraGCkY1oPobLU0RLd3sE9EvZPlnvgt5U2X4F2NmxhwBXYnNIbXHJbyoNGOg9QBueIHQSq1E6Dolsg6jZQbuBTkFhbbsfFX-AlIaQ', 55, 10, 3),
(N'Rapala Sideral 201', 1650000.00, 'https://www.eastackle.com/images/product/large/rapala-sideral-201-bait-casting-reel-8577_7_.jpg', 10, 5, 3),
(N'Hộp Đựng Phụ Kiện Câu Cá Đa Năng Daiwa', 85000.00, 'https://vuadocau.com/wp-content/uploads/magictoolbox_cache/6b9a437c5150b07b7797f5bf9befc233/4/0/40710/original/1187082081/hop-daiwa.jpg', 150, 30, 2),
(N'Thùng đựng dụng cụ đi câu Daiwa Tackle Box', 105000.00, 'https://daiwa.sg/wp-content/uploads/2023/05/TackleBoxTB_3000HS.jpg', 100, 25, 2),
(N'Cần máy đứng Daiwa Liberty Club Seabass 90ML/96M', 1990000.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbTaMhTlIyS_KCqPfB5J8NdHz1eCExx1oT4g&s', 99, 16, 2),
(N'Cần du lịch lồng dùng Daiwa Ardito-TR - 70MHF-SC', 2000000.00, 'https://vuadocau.com/wp-content/uploads/2020/11/Ardito-TR.jpg', 120, 10, 2),
(N'Cần lure Daiwa Tatula - bản JP', 2450000.00, 'https://vuadocau.com/wp-content/uploads/2020/04/Daiwa-Tatula-1.jpg', 87, 45, 2),
(N'Cần Câu Lure 4 Khúc Rapala Classic Countdown', 830000.00, 'https://vuadocau.com/wp-content/uploads/2021/06/classic-countdown.jpg', 96, 69, 3),
(N'Shimano Nexave Shore Cast – 2023', 1200000.00, 'https://fergostackleworld.com.au/cdn/shop/files/shimano-nexave-1203-6-10kg-surf-rod_600x.jpg?v=1686720217', 120, 50, 1),
(N'Cần Jig Shimano Grappler Type J 2025', 3900000.00, 'https://tunafishtackle.com/wp-content/uploads/2020/06/Grappler-Type-J-Spinning.jpg', 90, 45, 1),
(N'Bao đựng đồ câu Shimano Butterfly', 1900000.00, 'https://shopcancau.vn/uploads/source/Phu%20kien/bao%20hop/shimano/Bao-dung-do-cau-shimano-butterfly-1.jpg', 69, 41, 1),
(N'Cần câu lure Shimano Expride', 3550000.00, 'https://down-vn.img.susercontent.com/file/9d4da39c76846eaff9e59bcde535d953', 80, 65, 1);

INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES 
(N'Giải câu cá mùa hè', N'Hồ Tây', N'Sự kiện dành cho mọi lứa tuổi.', N'Hà Nội', 4, DATEADD(DAY, 5, GETDATE()), DATEADD(DAY, 6, GETDATE()), 'approved', GETDATE(), 'a8b79dea354d260c1153164e32900a82.jpg', 50, 10),
(N'Thử thách câu cá đêm', N'Hồ Trị An', N'Cuộc thi diễn ra trong đêm.', N'Đồng Nai', 4, DATEADD(DAY, 10, GETDATE()), DATEADD(DAY, 11, GETDATE()), 'approved', GETDATE(), 'di cau.jpg', 30, 5),
(N'Ngày hội câu cá thiếu nhi', N'Hồ Bán Nguyệt', N'Dành cho trẻ em và phụ huynh.', N'TP.HCM', 4, DATEADD(DAY, 7, GETDATE()), DATEADD(DAY, 8, GETDATE()), 'approved', GETDATE(), 'download (1).jpg', 40, 15),
(N'Giải đấu các CLB câu cá', N'Hồ Dầu Tiếng', N'Dành cho các CLB chuyên nghiệp.', N'Tây Ninh', 4, DATEADD(DAY, 15, GETDATE()), DATEADD(DAY, 16, GETDATE()), 'approved', GETDATE(), 'download (2).jpg', 100, 20),
(N'Câu cá gây quỹ từ thiện', N'Hồ Xuân Hương', N'Sự kiện thiện nguyện giúp đỡ trẻ em.', N'Đà Lạt', 4, DATEADD(DAY, 3, GETDATE()), DATEADD(DAY, 4, GETDATE()), 'approved', GETDATE(), 'download.jpg', 60, 18);

-- 5 sự kiện đã kết thúc
INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES 
(N'Cuộc thi câu cá đầu xuân', N'Hồ Gươm', N'Chào mừng năm mới.', N'Hà Nội', 4, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -9, GETDATE()), 'approved', GETDATE(), 'images (1).jpg', 70, 50),
(N'Thử thách 24h câu cá', N'Hồ Phú Ninh', N'Câu cá không nghỉ suốt 1 ngày.', N'Quảng Nam', 4, DATEADD(DAY, -7, GETDATE()), DATEADD(DAY, -6, GETDATE()), 'approved', GETDATE(), 'images (2).jpg', 35, 28),
(N'Giải đấu cuối năm', N'Hồ Tuyền Lâm', N'Tổng kết mùa giải.', N'Đà Lạt', 4, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, -19, GETDATE()), 'approved', GETDATE(), 'images (3).jpg', 80, 45),
(N'Sự kiện giao lưu miền Trung', N'Hồ Khe Sanh', N'Câu cá và trao đổi kinh nghiệm.', N'Quảng Trị', 4, DATEADD(DAY, -14, GETDATE()), DATEADD(DAY, -13, GETDATE()), 'approved', GETDATE(), N'images (4).jpg', 55, 37),
(N'Hội thi câu cá sinh viên', N'Hồ Thủ Đức', N'Dành cho các bạn sinh viên.', N'TP.HCM', 4, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE()), 'approved', GETDATE(), 'images.jpg', 90, 60);

-- 5 sự kiện đang diễn ra
INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES
(N'Câu cá Marathon', N'Hồ Tràm', N'Sự kiện kéo dài nhiều giờ liên tục.', N'Vũng Tàu', 4, DATEADD(HOUR, -3, GETDATE()), DATEADD(HOUR, 3, GETDATE()), 'approved', GETDATE(), 'a8b79dea354d260c1153164e32900a82.jpg', 45, 33),
(N'Sự kiện giao lưu Bắc - Nam', N'Hồ Hàm Thuận', N'Kết nối anh em cần thủ.', N'Bình Thuận', 4, DATEADD(HOUR, -2, GETDATE()), DATEADD(HOUR, 5, GETDATE()), 'approved', GETDATE(), 'di cau.jpg', 70, 25),
(N'Thử thách tốc độ câu cá', N'Hồ An Dương', N'Ai bắt được cá nhanh nhất?', N'Hải Phòng', 4, DATEADD(HOUR, -1, GETDATE()), DATEADD(HOUR, 4, GETDATE()), 'approved', GETDATE(), 'download (1).jpg', 60, 40),
(N'Chinh phục hồ sâu', N'Hồ Tân Hiệp', N'Địa điểm khó câu nhất năm.', N'Long An', 4, DATEADD(HOUR, -5, GETDATE()), DATEADD(HOUR, 1, GETDATE()), 'approved', GETDATE(), 'download (2).jpg', 50, 22),
(N'Kỳ thi tuyển chọn đội tuyển', N'Hồ Vĩnh Long', N'Tuyển chọn đội tuyển quốc gia.', N'Vĩnh Long', 4, DATEADD(HOUR, -6, GETDATE()), DATEADD(HOUR, 2, GETDATE()), 'approved', GETDATE(), 'download.jpg', 100, 80);
-- 5 sự kiện sắp diễn ra chỉ còn 1 chỗ trống
INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES 
(N'Thi đấu bán chuyên mùa hè', N'Hồ Suối Vàng', N'Sân chơi cho các cần thủ bán chuyên.', N'Lâm Đồng', 4, DATEADD(DAY, 2, GETDATE()), DATEADD(DAY, 3, GETDATE()), 'approved', GETDATE(), N'images (1).jpg', 30, 29),
(N'Cúp câu cá miền Tây', N'Hồ Tràm Chim', N'Sự kiện khu vực đồng bằng sông Cửu Long.', N'Đồng Tháp', 4, DATEADD(DAY, 6, GETDATE()), DATEADD(DAY, 7, GETDATE()), 'approved', GETDATE(), N'images (2).jpg', 50, 50),
(N'Tham quan và thi câu cá', N'Hồ Suối Lạnh', N'Vừa du lịch vừa thi đấu.', N'Phan Thiết', 4, DATEADD(DAY, 9, GETDATE()), DATEADD(DAY, 10, GETDATE()), 'approved', GETDATE(), N'images (3).jpg', 25, 25),
(N'Câu cá giao lưu doanh nhân', N'Hồ Thiên Nga', N'Sự kiện kết nối giới doanh nhân.', N'Hà Nội', 4, DATEADD(DAY, 11, GETDATE()), DATEADD(DAY, 12, GETDATE()), 'approved', GETDATE(), N'images (4).jpg', 40, 39),
(N'Thi câu cá thể thao mở rộng', N'Hồ Đại Lải', N'Mở rộng toàn quốc với giải thưởng hấp dẫn.', N'Vĩnh Phúc', 4, DATEADD(DAY, 8, GETDATE()), DATEADD(DAY, 9, GETDATE()), 'approved', GETDATE(), N'images.jpg', 60, 59);