
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
    RoleName VARCHAR(50) NOT NULL
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

-- Orders
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT,
    Subtotal DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(50) COLLATE Vietnamese_CI_AS DEFAULT N'Đang chờ duyệt',
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

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
    Title VARCHAR(255) NOT NULL,
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



select * from FishSpecies
-- Fish
CREATE TABLE Fish (
    FishId INT PRIMARY KEY IDENTITY,
    Name VARCHAR(255),
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


INSERT INTO Role (RoleName) VALUES  ('User'),('FishingOwner'),('Admin');

INSERT INTO Users (FullName, Email, Phone, Password, GoogleId, RoleId, Gender, DateOfBirth, Location)
VALUES ('Charlie Le', 'charlie@eample.com', '0933444555', 'hashedpassword3', 'google12345', 1, 'Other', '1985-12-01', 'Da ang'),
(N'Nguyễn Tiến Dũng', 'tien.dungg2011@gmail.com', '0933444555', '12345', 'google12345', 1, N'Nam', '1985-12-01', N'Hưng Yên'),
(N'Chu Việt Hải', 'haicv@gmail.com', '0933444555', '12345', 'google12345', 1, N'Nam', '1985-12-01', N'Ba Vì');
  
select * from users

select * from image

select * from PostComment


