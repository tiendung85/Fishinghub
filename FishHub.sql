
USE master;
GO


ALTER DATABASE FishingHub1
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO


DROP DATABASE FishingHub1;
GO

CREATE DATABASE FishingHub1;
GO
USE FishingHub;
GO

-- Roles
CREATE TABLE Role (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL
);

INSERT INTO Role (RoleName) VALUES  ('User'),('FishingOwner'),('Admin');


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

ALTER TABLE Users ADD LastLoginTime datetime NULL;
ALTER TABLE Users ADD Status nvarchar(20) NULL;

INSERT INTO Users (FullName, Email, Phone, Password, GoogleId, RoleId, Gender, DateOfBirth, Location)
VALUES 
(N'Nguyễn Tiến Dũng', 'tien.dungg2011@gmail.com', '0933444555', '12345', 'google12345', 1, N'Nam', '1985-12-01', N'Hưng Yên'),
(N'Chu Việt Hải', 'haicv@gmail.com', '0933444555', '12345', 'google12345', 1, N'Nam', '1985-12-01', N'Ba Vì'),
(N'Chu Ngọc Dũng', 'ngocdung@gmail.com', '0933444555', '12345', 'google12345', 2, N'Nam', '1985-12-01', N'Ba Vì'),
(N'Admin', 'admin@gmail.com', '0933444555', '12345', 'google12345', 3, N'Nam', '1985-12-01', N'Ba Vì');
INSERT INTO Users (FullName, Email, Phone, Password, GoogleId, RoleId, Gender, DateOfBirth, Location)
VALUES 
(N'Nguyễn Văn A', 'a1@example.com', '0901234567', 'password123', NULL, 1, N'Nam', '1995-01-01', N'Hà Nội'),
(N'Trần Thị B', 'b2@example.com', '0912345678', 'password123', NULL, 1, N'Nữ', '1994-02-02', N'Hồ Chí Minh'),
(N'Lê Văn C', 'c3@example.com', '0923456789', 'password123', NULL, 1, N'Nam', '1993-03-03', N'Đà Nẵng'),
(N'Phạm Thị D', 'd4@example.com', '0934567890', 'password123', NULL, 1, N'Nữ', '1992-04-04', N'Cần Thơ'),
(N'Hoàng Văn E', 'e5@example.com', '0945678901', 'password123', NULL, 1, N'Nam', '1991-05-05', N'Hải Phòng'),
(N'Đặng Thị F', 'f6@example.com', '0956789012', 'password123', NULL, 1, N'Nữ', '1990-06-06', N'Huế'),
(N'Vũ Văn G', 'g7@example.com', '0967890123', 'password123', NULL, 1, N'Nam', '1989-07-07', N'Nha Trang'),
(N'Ngô Thị H', 'h8@example.com', '0978901234', 'password123', NULL, 1, N'Nữ', '1988-08-08', N'Buôn Ma Thuột'),
(N'Hồ Văn I', 'i9@example.com', '0989012345', 'password123', NULL, 1, N'Nam', '1987-09-09', N'Lâm Đồng'),
(N'Bùi Thị J', 'j10@example.com', '0990123456', 'password123', NULL, 1, N'Nữ', '1986-10-10', N'Bình Dương');

CREATE TABLE Permission (
    permissionId INT PRIMARY KEY IDENTITY(1,1),
    permissionName NVARCHAR(100) NOT NULL
);

-- Dữ liệu mẫu, chỉ tạo 1 lần
INSERT INTO Permission (permissionName) VALUES
    (N'Đăng bài'),
    (N'Bình luận'),
    (N'Tạo sự kiện'),
    (N'Nhắn tin'),
    (N'Thanh toán'),
    (N'Đổi ảnh đại diện');
INSERT INTO Permission (permissionName) VALUES (N'Mua hàng');

CREATE TABLE RolePermission (
    roleId INT,
    permissionId INT,
    PRIMARY KEY (roleId, permissionId),
    FOREIGN KEY (roleId) REFERENCES Role(roleId),
    FOREIGN KEY (permissionId) REFERENCES Permission(permissionId)
);
-- Ví dụ: User chỉ có đăng bài và bình luận, FishOwner có thêm tạo sự kiện, Quản trị viên có mọi quyền
INSERT INTO RolePermission (roleId, permissionId) VALUES
    (1, 1), (1, 2),         -- User: Đăng bài, Bình luận
    (2, 1), (2, 2), (2, 3), -- FishOwner: Đăng bài, Bình luận, Tạo sự kiện
    (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6); -- Admin: Tất cả

CREATE TABLE UserDeniedPermission (
    userId INT,
    permissionId INT,
    PRIMARY KEY (userId, permissionId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (permissionId) REFERENCES Permission(permissionId)
);

-- Bảng này chỉ lưu những quyền bị cấm
-- Nếu userId=6 bị cấm quyềnId=2,4: INSERT INTO UserDeniedPermission VALUES (6,2), (6,4)

-- User/FishOwner/Admin đều có quyền mua hàng mặc định
INSERT INTO RolePermission (roleId, permissionId) VALUES
    (1, 7), (2, 7), (3, 7);



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

CREATE TABLE [dbo].[Review](
    [Id] INT IDENTITY(1,1) PRIMARY KEY,
    [ProductId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [Rating] INT NOT NULL,           -- Số sao: 1-5
    [ReviewText] NVARCHAR(MAX) NULL, -- Nội dung đánh giá
    [Image] VARCHAR(255) NULL,       -- Đường dẫn ảnh
    [Video] VARCHAR(255) NULL,       -- Đường dẫn video
    [CreatedAt] DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Review_Product FOREIGN KEY (ProductId) REFERENCES Product(ProductId),
    CONSTRAINT FK_Review_User FOREIGN KEY (UserId) REFERENCES Users(UserId)
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
ALTER TABLE Orders ADD DeliveryTime DATETIME NULL;

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


CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY,
    OrderID INT,
    ProductID INT,
    Rating INT,
    ReviewText TEXT,
    FOREIGN KEY (OrderID) REFERENCES Orders(ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
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
    Title NVARCHAR(255) NOT NULL,
    LakeName NVARCHAR(255), 
    Description NVARCHAR(MAX),
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
	Checkin BIT DEFAULT 0,
    FOREIGN KEY (HostId) REFERENCES Users(UserId)
);

-- EventParticipants
CREATE TABLE EventParticipant (
    EventId INT NOT NULL,
    UserId INT NOT NULL,
	NumberPhone VARCHAR(11) NOT NULL,
	Email VARCHAR (255) NOT Null,
	CCCD VARCHAR(20),
    Checkin BIT DEFAULT 0,
	CheckinTime DATETIME, 
    PRIMARY KEY (EventId, UserId),
    FOREIGN KEY (EventId) REFERENCES Event(EventId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE EventNotification (
    NotificationId INT IDENTITY PRIMARY KEY,
    EventId INT NOT NULL,
    SenderId INT NOT NULL, 
	Title NVARCHAR(255),
    Message NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EventId) REFERENCES Event(EventId),
    FOREIGN KEY (SenderId) REFERENCES Users(UserId)
);
CREATE TABLE EventRejections (
    EventId INT PRIMARY KEY,
    RejectReason NVARCHAR(MAX) NOT NULL,
    RejectedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EventId) REFERENCES Event(EventId)
);

-- Posts
CREATE TABLE Post (
    PostId INT PRIMARY KEY IDENTITY,
    UserId INT,
    Topic NVARCHAR(50),
    Title NVARCHAR(255),
    Content NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
	Status NVARCHAR(20) DEFAULT N'chờ duyệt',
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);

CREATE TABLE PostRejections (
    RejectionId INT PRIMARY KEY IDENTITY,
    PostId INT NOT NULL,

    Reason NVARCHAR(MAX) NOT NULL,
    RejectedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostId) REFERENCES Post(PostId) ON DELETE CASCADE,
    
);

CREATE TABLE PostNotification (
    NotificationId INT PRIMARY KEY IDENTITY,
    PostId INT NOT NULL,
    ReceiverId INT NOT NULL,      -- Người nhận (chủ bài viết)
    Message NVARCHAR(MAX) NOT NULL,
    IsRead BIT DEFAULT 0,         -- Đã đọc hay chưa
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostId) REFERENCES Post(PostId) ON DELETE CASCADE,
    FOREIGN KEY (ReceiverId) REFERENCES Users(UserId)
);
SELECT * FROM PostNotification WHERE ReceiverId = 1;

select * from Post





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
    ReplyId int ,
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
	--ParentReplyId INT NULL,
    FOREIGN KEY (CommentId) REFERENCES PostComment(CommentId) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) 
);

CREATE TABLE ReplyLike (
    ReplyId INT,
    UserId INT,
    LikedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (ReplyId, UserId),
    FOREIGN KEY (ReplyId) REFERENCES CommentReply(ReplyId) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

CREATE TABLE SavedPost (
    UserId INT,                           
    PostId INT,                             
    SavedAt DATETIME DEFAULT GETDATE(),     
    PRIMARY KEY (UserId, PostId),           
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (PostId) REFERENCES Post(PostId)
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


-- Fish
CREATE TABLE Fish (
    FishId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(255),
    Point INT NOT NULL,
    FishSpeciesId INT,
    FOREIGN KEY (FishSpeciesId) REFERENCES FishSpecies(Id)
);

-- Fish
CREATE TABLE DifficultyPoint (
    DifficultyLevel INT PRIMARY KEY,  -- 1, 2, 3
    Point INT NOT NULL                -- Ví dụ: 20, 50, 100
);

INSERT INTO DifficultyPoint (DifficultyLevel, Point)
VALUES 
(1, 20),
(2, 40),
(3, 70),
(4,100);



CREATE TABLE FishingLake (
    LakeId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    Location NVARCHAR(255),
    OwnerId INT, -- FK đến Users(UserId)
    FOREIGN KEY (OwnerId) REFERENCES Users(UserId)
);

CREATE TABLE LakeFish (
    LakeId INT,
    FishSpeciesId INT,
	Price FLOAT NOT NULL, --giá loài cá
    PRIMARY KEY (LakeId, FishSpeciesId),
    FOREIGN KEY (LakeId) REFERENCES FishingLake(LakeId),
    FOREIGN KEY (FishSpeciesId) REFERENCES FishSpecies(Id)
);

select * from LakeFish

SELECT fs.CommonName, lf.Price FROM FishSpecies fs 
                JOIN LakeFish lf ON fs.Id = lf.FishSpeciesId
                WHERE lf.LakeId = 1

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




-- Các sự kiện đã kết thúc (5 sự kiện đầu)
INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES
(N'Giải câu cá đầu năm', N'Hồ Gươm', 
N'Sự kiện mở màn cho mùa giải mới với nhiều hoạt động hấp dẫn như thi câu, trình diễn thiết bị hiện đại, giao lưu với các vận động viên kỳ cựu trong ngành câu cá.', 
N'Hà Nội', 3, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -9, GETDATE()), 'approved', GETDATE(), 'images (1).jpg', 60, 10),

(N'Thử thách đêm trăng', N'Hồ Trị An', 
N'Một đêm thi câu đầy kịch tính và thú vị dưới ánh trăng, nơi người tham gia được thử sức với các loài cá hoạt động về đêm và tận hưởng không khí thiên nhiên hoang sơ.', 
N'Đồng Nai', 3, DATEADD(DAY, -7, GETDATE()), DATEADD(DAY, -6, GETDATE()), 'approved', GETDATE(), 'di cau.jpg', 40, 10),

(N'Câu cá giao lưu các tỉnh miền Trung', N'Hồ Khe Sanh', 
N'Sự kiện nhằm tăng cường tình đoàn kết giữa các hội câu cá khu vực miền Trung với các hoạt động chính như thi đấu kỹ năng, chia sẻ kinh nghiệm và trình diễn mồi câu độc đáo.', 
N'Quảng Trị', 3, DATEADD(DAY, -14, GETDATE()), DATEADD(DAY, -13, GETDATE()), 'approved', GETDATE(), 'images (4).jpg', 55, 10),

(N'Hội thi câu cá sinh viên 2025', N'Hồ Thủ Đức', 
N'Cuộc thi đầy hào hứng dành cho sinh viên các trường đại học trong khu vực nhằm rèn luyện kỹ năng thực hành, tạo cơ hội kết nối và xây dựng tinh thần đồng đội qua hoạt động thể thao ngoài trời.', 
N'TP.HCM', 3, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE()), 'approved', GETDATE(), 'images.jpg', 90, 10),

(N'Ngày hội câu cá cuối năm', N'Hồ Tuyền Lâm', 
N'Sự kiện tổng kết mùa giải câu cá với lễ trao giải, tiệc nhẹ và không khí ấm cúng bên hồ trong khung cảnh cao nguyên lãng mạn, tạo kỷ niệm khó quên cho người tham gia.', 
N'Đà Lạt', 3, DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, -19, GETDATE()), 'approved', GETDATE(), 'images (3).jpg', 70, 10);

-- Các sự kiện đang diễn ra hoặc sắp diễn ra (5 sự kiện sau)
INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES
(N'Câu cá Marathon', N'Hồ Tràm', 
N'Sự kiện kéo dài liên tục nhiều giờ, thử thách sức bền và kỹ thuật của các cần thủ. Người tham gia sẽ thi đấu theo lượt và ghi điểm dựa trên số lượng và trọng lượng cá bắt được.', 
N'Vũng Tàu', 3, DATEADD(HOUR, -3, GETDATE()), DATEADD(HOUR, 3, GETDATE()), 'approved', GETDATE(), 'a8b79dea354d260c1153164e32900a82.jpg', 45, 10),

(N'Sự kiện giao lưu Bắc - Nam', N'Hồ Hàm Thuận', 
N'Sự kiện nhằm kết nối cộng đồng cần thủ từ khắp ba miền, với hoạt động thi đấu kết hợp giao lưu, chia sẻ kỹ thuật, trải nghiệm mồi câu độc đáo và trình diễn thiết bị câu mới nhất.', 
N'Bình Thuận', 3, DATEADD(HOUR, -2, GETDATE()), DATEADD(HOUR, 5, GETDATE()), 'approved', GETDATE(), 'di cau.jpg', 70, 10),

(N'Thử thách tốc độ câu cá', N'Hồ An Dương', 
N'Ai sẽ là người bắt được cá đầu tiên trong thời gian ngắn nhất? Cuộc thi chú trọng vào phản xạ nhanh và chọn vị trí tốt, phù hợp cho cả người mới và chuyên nghiệp.', 
N'Hải Phòng', 3, DATEADD(HOUR, -1, GETDATE()), DATEADD(HOUR, 4, GETDATE()), 'approved', GETDATE(), 'download (1).jpg', 60, 10),

(N'Chinh phục hồ sâu', N'Hồ Tân Hiệp', 
N'Hồ sâu có độ khó cao, đòi hỏi kỹ thuật và sự kiên nhẫn của người câu. Thử thách lần này tập trung vào khả năng cảm nhận và xử lý khi cá lớn cắn câu ở độ sâu lớn.', 
N'Long An', 3, DATEADD(HOUR, -5, GETDATE()), DATEADD(HOUR, 1, GETDATE()), 'approved', GETDATE(), 'download (2).jpg', 50, 10),

(N'Kỳ thi tuyển chọn đội tuyển', N'Hồ Vĩnh Long', 
N'Sự kiện chọn ra các cần thủ xuất sắc nhất đại diện cho quốc gia tham gia giải đấu quốc tế. Thí sinh phải vượt qua nhiều vòng kiểm tra kỹ năng, độ chính xác và tốc độ.', 
N'Vĩnh Long', 3, DATEADD(HOUR, -6, GETDATE()), DATEADD(HOUR, 2, GETDATE()), 'approved', GETDATE(), 'download.jpg', 100, 0);

INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, ApprovedAt, PosterUrl, MaxParticipants, CurrentParticipants)
VALUES
(N'Lễ hội câu cá mùa thu', N'Hồ Tây', 
N'Lễ hội được tổ chức nhằm tạo sân chơi lành mạnh cho người yêu thích bộ môn câu cá, đồng thời quảng bá vẻ đẹp Hồ Tây và nâng cao ý thức bảo vệ môi trường sinh thái xung quanh khu vực hồ.', 
N'Hà Nội', 3, DATEADD(DAY, 2, GETDATE()), DATEADD(DAY, 3, GETDATE()), 'approved', GETDATE(), 'a8b79dea354d260c1153164e32900a82.jpg', 60, 0),

(N'Giải đấu câu cá toàn miền Bắc', N'Hồ Đại Lải', 
N'Sự kiện quy tụ các tay câu đến từ khắp các tỉnh phía Bắc với cơ hội giao lưu, học hỏi kỹ năng cũng như tranh tài qua nhiều vòng thi đấu cam go và hấp dẫn.', 
N'Vĩnh Phúc', 3, DATEADD(DAY, 4, GETDATE()), DATEADD(DAY, 5, GETDATE()), 'approved', GETDATE(), 'images.jpg', 80, 0),

(N'Thử thách câu cá cuối tuần', N'Hồ Đồng Đò', 
N'Chương trình dành cho người mới bắt đầu và các gia đình muốn trải nghiệm câu cá trong không khí cuối tuần thư giãn. Có hỗ trợ thiết bị và hướng dẫn cơ bản từ ban tổ chức.', 
N'Hà Nội', 3, DATEADD(DAY, 1, GETDATE()), DATEADD(DAY, 2, GETDATE()), 'approved', GETDATE(), 'images (1).jpg', 40, 0),

(N'Cúp vô địch miền Trung', N'Hồ Phú Ninh', 
N'Sự kiện được tổ chức chuyên nghiệp với hệ thống chấm điểm tự động, quy tụ các vận động viên câu cá bán chuyên từ khu vực miền Trung với giải thưởng giá trị và vinh danh toàn quốc.', 
N'Quảng Nam', 3, DATEADD(DAY, 6, GETDATE()), DATEADD(DAY, 7, GETDATE()), 'approved', GETDATE(), 'images (2).jpg', 70, 0),

(N'Ngày hội câu cá xanh', N'Hồ Xuân Hương', 
N'Sự kiện mang thông điệp sống xanh, khuyến khích người tham gia thực hiện nguyên tắc câu cá bắt - thả để bảo tồn hệ sinh thái và nâng cao nhận thức cộng đồng về bảo vệ nguồn nước.', 
N'Đà Lạt', 3, DATEADD(DAY, 3, GETDATE()), DATEADD(DAY, 4, GETDATE()), 'approved', GETDATE(), 'download.jpg', 50, 10),

(N'Thi tài cần thủ trẻ', N'Hồ Bán Nguyệt', 
N'Cuộc thi dành riêng cho những bạn trẻ yêu thích môn thể thao câu cá, tạo môi trường thi đấu vui vẻ, công bằng và truyền cảm hứng sống lành mạnh cho thế hệ mới.', 
N'TP.HCM', 3, DATEADD(DAY, 5, GETDATE()), DATEADD(DAY, 6, GETDATE()), 'approved', GETDATE(), 'download (1).jpg', 45, 10),

(N'Chinh phục cá khủng', N'Hồ Trị An', 
N'Một sự kiện dành cho các cần thủ yêu thích thử thách, với các khu vực được phân loại theo độ khó và cơ hội bắt được những loài cá lớn có trọng lượng lên đến hàng chục kg.', 
N'Đồng Nai', 3, DATEADD(DAY, 7, GETDATE()), DATEADD(DAY, 8, GETDATE()), 'approved', GETDATE(), 'di cau.jpg', 55, 10),

(N'Giao lưu cần thủ ba miền', N'Hồ Tân Hiệp', 
N'Sự kiện mang tính kết nối cộng đồng, nơi các cần thủ đến từ Bắc – Trung – Nam có dịp gặp gỡ, giao lưu, thi đấu và chia sẻ kinh nghiệm với nhau trong không khí thân thiện.', 
N'Long An', 3, DATEADD(DAY, 8, GETDATE()), DATEADD(DAY, 9, GETDATE()), 'approved', GETDATE(), 'download (2).jpg', 60, 10),

(N'Hội thi câu cá doanh nghiệp', N'Hồ Hàm Thuận', 
N'Sự kiện dành riêng cho các tổ chức và doanh nghiệp muốn tổ chức hoạt động team building, nâng cao tinh thần đoàn kết trong môi trường gần gũi thiên nhiên.', 
N'Bình Thuận', 3, DATEADD(DAY, 9, GETDATE()), DATEADD(DAY, 10, GETDATE()), 'approved', GETDATE(), 'images (3).jpg', 100, 10),

(N'Lễ hội cần thủ toàn quốc', N'Hồ Suối Lạnh', 
N'Sự kiện lớn nhất trong năm với sự tham gia của các tuyển thủ hàng đầu và đại diện từ các CLB trên cả nước, bao gồm nhiều hoạt động hấp dẫn: thi đấu, hội chợ thiết bị, giao lưu chuyên gia.', 
N'Phan Thiết', 3, DATEADD(DAY, 10, GETDATE()), DATEADD(DAY, 11, GETDATE()), 'approved', GETDATE(), 'images (4).jpg', 120, 10);

INSERT INTO EventParticipant (EventId, UserId, NumberPhone, Email, CCCD)
VALUES 
-- Event 1
(1, 5, '0901000001', 'user5_event1@example.com', '001122334501'),
(1, 6, '0901000002', 'user6_event1@example.com', '001122334502'),
(1, 7, '0901000003', 'user7_event1@example.com', '001122334503'),
(1, 8, '0901000004', 'user8_event1@example.com', '001122334504'),
(1, 9, '0901000005', 'user9_event1@example.com', '001122334505'),
(1, 10, '0901000006', 'user10_event1@example.com', '001122334506'),
(1, 11, '0901000007', 'user11_event1@example.com', '001122334507'),
(1, 12, '0901000008', 'user12_event1@example.com', '001122334508'),
(1, 13, '0901000009', 'user13_event1@example.com', '001122334509'),
(1, 14, '0901000010', 'user14_event1@example.com', '001122334510'),

-- Event 2
(2, 5, '0902000001', 'user5_event2@example.com', '001122334511'),
(2, 6, '0902000002', 'user6_event2@example.com', '001122334512'),
(2, 7, '0902000003', 'user7_event2@example.com', '001122334513'),
(2, 8, '0902000004', 'user8_event2@example.com', '001122334514'),
(2, 9, '0902000005', 'user9_event2@example.com', '001122334515'),
(2, 10, '0902000006', 'user10_event2@example.com', '001122334516'),
(2, 11, '0902000007', 'user11_event2@example.com', '001122334517'),
(2, 12, '0902000008', 'user12_event2@example.com', '001122334518'),
(2, 13, '0902000009', 'user13_event2@example.com', '001122334519'),
(2, 14, '0902000010', 'user14_event2@example.com', '001122334520'),

-- Event 3
(3, 5, '0903000001', 'user5_event3@example.com', '001122334521'),
(3, 6, '0903000002', 'user6_event3@example.com', '001122334522'),
(3, 7, '0903000003', 'user7_event3@example.com', '001122334523'),
(3, 8, '0903000004', 'user8_event3@example.com', '001122334524'),
(3, 9, '0903000005', 'user9_event3@example.com', '001122334525'),
(3, 10, '0903000006', 'user10_event3@example.com', '001122334526'),
(3, 11, '0903000007', 'user11_event3@example.com', '001122334527'),
(3, 12, '0903000008', 'user12_event3@example.com', '001122334528'),
(3, 13, '0903000009', 'user13_event3@example.com', '001122334529'),
(3, 14, '0903000010', 'user14_event3@example.com', '001122334530'),

-- Event 4
(4, 5, '0904000001', 'user5_event4@example.com', '001122334531'),
(4, 6, '0904000002', 'user6_event4@example.com', '001122334532'),
(4, 7, '0904000003', 'user7_event4@example.com', '001122334533'),
(4, 8, '0904000004', 'user8_event4@example.com', '001122334534'),
(4, 9, '0904000005', 'user9_event4@example.com', '001122334535'),
(4, 10, '0904000006', 'user10_event4@example.com', '001122334536'),
(4, 11, '0904000007', 'user11_event4@example.com', '001122334537'),
(4, 12, '0904000008', 'user12_event4@example.com', '001122334538'),
(4, 13, '0904000009', 'user13_event4@example.com', '001122334539'),
(4, 14, '0904000010', 'user14_event4@example.com', '001122334540'),

-- Event 5
(5, 5, '0905000001', 'user5_event5@example.com', '001122334541'),
(5, 6, '0905000002', 'user6_event5@example.com', '001122334542'),
(5, 7, '0905000003', 'user7_event5@example.com', '001122334543'),
(5, 8, '0905000004', 'user8_event5@example.com', '001122334544'),
(5, 9, '0905000005', 'user9_event5@example.com', '001122334545'),
(5, 10, '0905000006', 'user10_event5@example.com', '001122334546'),
(5, 11, '0905000007', 'user11_event5@example.com', '001122334547'),
(5, 12, '0905000008', 'user12_event5@example.com', '001122334548'),
(5, 13, '0905000009', 'user13_event5@example.com', '001122334549'),
(5, 14, '0905000010', 'user14_event5@example.com', '001122334550'),

-- Event 6
(6, 5, '0906000001', 'user5_event6@example.com', '001122334551'),
(6, 6, '0906000002', 'user6_event6@example.com', '001122334552'),
(6, 7, '0906000003', 'user7_event6@example.com', '001122334553'),
(6, 8, '0906000004', 'user8_event6@example.com', '001122334554'),
(6, 9, '0906000005', 'user9_event6@example.com', '001122334555'),
(6, 10, '0906000006', 'user10_event6@example.com', '001122334556'),
(6, 11, '0906000007', 'user11_event6@example.com', '001122334557'),
(6, 12, '0906000008', 'user12_event6@example.com', '001122334558'),
(6, 13, '0906000009', 'user13_event6@example.com', '001122334559'),
(6, 14, '0906000010', 'user14_event6@example.com', '001122334560'),

-- Event 7
(7, 5, '0907000001', 'user5_event7@example.com', '001122334561'),
(7, 6, '0907000002', 'user6_event7@example.com', '001122334562'),
(7, 7, '0907000003', 'user7_event7@example.com', '001122334563'),
(7, 8, '0907000004', 'user8_event7@example.com', '001122334564'),
(7, 9, '0907000005', 'user9_event7@example.com', '001122334565'),
(7, 10, '0907000006', 'user10_event7@example.com', '001122334566'),
(7, 11, '0907000007', 'user11_event7@example.com', '001122334567'),
(7, 12, '0907000008', 'user12_event7@example.com', '001122334568'),
(7, 13, '0907000009', 'user13_event7@example.com', '001122334569'),
(7, 14, '0907000010', 'user14_event7@example.com', '001122334570'),

-- Event 8
(8, 5, '0908000001', 'user5_event8@example.com', '001122334571'),
(8, 6, '0908000002', 'user6_event8@example.com', '001122334572'),
(8, 7, '0908000003', 'user7_event8@example.com', '001122334573'),
(8, 8, '0908000004', 'user8_event8@example.com', '001122334574'),
(8, 9, '0908000005', 'user9_event8@example.com', '001122334575'),
(8, 10, '0908000006', 'user10_event8@example.com', '001122334576'),
(8, 11, '0908000007', 'user11_event8@example.com', '001122334577'),
(8, 12, '0908000008', 'user12_event8@example.com', '001122334578'),
(8, 13, '0908000009', 'user13_event8@example.com', '001122334579'),
(8, 14, '0908000010', 'user14_event8@example.com', '001122334580'),

-- Event 9
(9, 5, '0909000001', 'user5_event9@example.com', '001122334581'),
(9, 6, '0909000002', 'user6_event9@example.com', '001122334582'),
(9, 7, '0909000003', 'user7_event9@example.com', '001122334583'),
(9, 8, '0909000004', 'user8_event9@example.com', '001122334584'),
(9, 9, '0909000005', 'user9_event9@example.com', '001122334585'),
(9, 10, '0909000006', 'user10_event9@example.com', '001122334586'),
(9, 11, '0909000007', 'user11_event9@example.com', '001122334587'),
(9, 12, '0909000008', 'user12_event9@example.com', '001122334588'),
(9, 13, '0909000009', 'user13_event9@example.com', '001122334589'),
(9, 14, '0909000010', 'user14_event9@example.com', '001122334590'),

-- Event 10
(10, 5, '0910000001', 'user5_event10@example.com', '001122334591'),
(10, 6, '0910000002', 'user6_event10@example.com', '001122334592'),
(10, 7, '0910000003', 'user7_event10@example.com', '001122334593'),
(10, 8, '0910000004', 'user8_event10@example.com', '001122334594'),
(10, 9, '0910000005', 'user9_event10@example.com', '001122334595'),
(10, 10, '0910000006', 'user10_event10@example.com', '001122334596'),
(10, 11, '0910000007', 'user11_event10@example.com', '001122334597'),
(10, 12, '0910000008', 'user12_event10@example.com', '001122334598'),
(10, 13, '0910000009', 'user13_event10@example.com', '001122334599'),
(10, 14, '0910000010', 'user14_event10@example.com', '001122334600');

-- Sự kiện 11
INSERT INTO EventParticipant (EventId, UserId, NumberPhone, Email, CCCD)
VALUES
(11, 5, '0901234567', 'a1@example.com', '001122334455'),
(11, 6, '0912345678', 'b2@example.com', '001122334456'),
(11, 7, '0923456789', 'c3@example.com', '001122334457'),
(11, 8, '0934567890', 'd4@example.com', '001122334458'),
(11, 9, '0945678901', 'e5@example.com', '001122334459'),
(11, 10, '0956789012', 'f6@example.com', '001122334460'),
(11, 11, '0967890123', 'g7@example.com', '001122334461'),
(11, 12, '0978901234', 'h8@example.com', '001122334462'),
(11, 13, '0989012345', 'i9@example.com', '001122334463'),
(11, 14, '0990123456', 'j10@example.com', '001122334464');

-- Sự kiện 12
INSERT INTO EventParticipant (EventId, UserId, NumberPhone, Email, CCCD)
VALUES
(12, 5, '0901234567', 'a1@example.com', '001122334455'),
(12, 6, '0912345678', 'b2@example.com', '001122334456'),
(12, 7, '0923456789', 'c3@example.com', '001122334457'),
(12, 8, '0934567890', 'd4@example.com', '001122334458'),
(12, 9, '0945678901', 'e5@example.com', '001122334459'),
(12, 10, '0956789012', 'f6@example.com', '001122334460'),
(12, 11, '0967890123', 'g7@example.com', '001122334461'),
(12, 12, '0978901234', 'h8@example.com', '001122334462'),
(12, 13, '0989012345', 'i9@example.com', '001122334463'),
(12, 14, '0990123456', 'j10@example.com', '001122334464');

-- Sự kiện 13
INSERT INTO EventParticipant (EventId, UserId, NumberPhone, Email, CCCD)
VALUES
(13, 5, '0901234567', 'a1@example.com', '001122334455'),
(13, 6, '0912345678', 'b2@example.com', '001122334456'),
(13, 7, '0923456789', 'c3@example.com', '001122334457'),
(13, 8, '0934567890', 'd4@example.com', '001122334458'),
(13, 9, '0945678901', 'e5@example.com', '001122334459'),
(13, 10, '0956789012', 'f6@example.com', '001122334460'),
(13, 11, '0967890123', 'g7@example.com', '001122334461'),
(13, 12, '0978901234', 'h8@example.com', '001122334462'),
(13, 13, '0989012345', 'i9@example.com', '001122334463'),
(13, 14, '0990123456', 'j10@example.com', '001122334464');

-- Sự kiện 14
INSERT INTO EventParticipant (EventId, UserId, NumberPhone, Email, CCCD)
VALUES
(14, 5, '0901234567', 'a1@example.com', '001122334455'),
(14, 6, '0912345678', 'b2@example.com', '001122334456'),
(14, 7, '0923456789', 'c3@example.com', '001122334457'),
(14, 8, '0934567890', 'd4@example.com', '001122334458'),
(14, 9, '0945678901', 'e5@example.com', '001122334459'),
(14, 10, '0956789012', 'f6@example.com', '001122334460'),
(14, 11, '0967890123', 'g7@example.com', '001122334461'),
(14, 12, '0978901234', 'h8@example.com', '001122334462'),
(14, 13, '0989012345', 'i9@example.com', '001122334463'),
(14, 14, '0990123456', 'j10@example.com', '001122334464');

-- Sự kiện 15
INSERT INTO EventParticipant (EventId, UserId, NumberPhone, Email, CCCD)
VALUES
(15, 5, '0901234567', 'a1@example.com', '001122334455'),
(15, 6, '0912345678', 'b2@example.com', '001122334456'),
(15, 7, '0923456789', 'c3@example.com', '001122334457'),
(15, 8, '0934567890', 'd4@example.com', '001122334458'),
(15, 9, '0945678901', 'e5@example.com', '001122334459'),
(15, 10, '0956789012', 'f6@example.com', '001122334460'),
(15, 11, '0967890123', 'g7@example.com', '001122334461'),
(15, 12, '0978901234', 'h8@example.com', '001122334462'),
(15, 13, '0989012345', 'i9@example.com', '001122334463'),
(15, 14, '0990123456', 'j10@example.com', '001122334464');

INSERT INTO EventNotification (EventId, SenderId, Title, Message, CreatedAt)
VALUES 
(11, 3, N'Thông báo sự kiện', N'Xin chào! Sự kiện Hồ Tây sẽ bắt đầu trong vài ngày tới. Hãy chuẩn bị cần câu của bạn!', GETDATE()),
(12, 3, N'Thông báo sự kiện', N'Chào mừng bạn đến với sự kiện tại Hồ Trị An. Đừng quên mang theo giấy tờ tùy thân!', GETDATE()),
(13, 3, N'Thông báo sự kiện', N'Sự kiện tại Hồ Suối Hai sẽ diễn ra vào cuối tuần này. Vui lòng đến đúng giờ.', GETDATE()),
(14, 3, N'Thông báo quan trọng', N'Có một số thay đổi về địa điểm tập trung cho sự kiện tại Hồ Đồng Mô. Vui lòng kiểm tra lại chi tiết.', GETDATE()),
(15, 3, N'Cập nhật từ ban tổ chức', N'Sự kiện Hồ Đại Lải sẽ có thêm phần thi kỹ thuật câu. Tham gia để nhận phần thưởng hấp dẫn!', GETDATE());

SELECT * FROM PostNotification WHERE ReceiverId = 1 ORDER BY CreatedAt DESC;
