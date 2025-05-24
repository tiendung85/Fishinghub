-- Bước 1: Chuyển sang database khác (như master)
USE master;
GO

-- Bước 2: Ngắt kết nối tất cả các phiên đang dùng database FishingHub
ALTER DATABASE FishingHub
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Bước 3: Xóa database
DROP DATABASE FishingHub;
GO

CREATE DATABASE FishingHub;
GO
USE FishingHub;
GO
DROP DATABASE FishingHub
-- Roles
CREATE TABLE Role (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName VARCHAR(50) NOT NULL
);

select * from Role 

-- Users
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
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
    Description TEXT,
    Location VARCHAR(255),
    HostId INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Status NVARCHAR(20) DEFAULT 'pending' CHECK (Status IN ('pending', 'approved', 'rejected')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    ApprovedAt DATETIME,
    PosterUrl VARCHAR(255), 
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
    Title VARCHAR(255),
    Content TEXT,
    Image VARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- PostComments
CREATE TABLE PostComment (
    CommentId INT PRIMARY KEY IDENTITY,
    PostId INT,
    UserId INT,
    Content TEXT,
    Likes INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PostId) REFERENCES Post(PostId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- FishSpecies
CREATE TABLE FishSpecies (
    Id INT PRIMARY KEY IDENTITY,
    CommonName NVARCHAR(100) NOT NULL,
    ScientificName NVARCHAR(150),
    Description TEXT,
    ImageUrl NVARCHAR(MAX),
    Bait NVARCHAR(MAX),
    BestSeason NVARCHAR(50),
    BestTimeOfDay NVARCHAR(50),
    FishingSpots NVARCHAR(MAX),
    FishingTechniques NVARCHAR(MAX),
    DifficultyLevel INT CHECK (DifficultyLevel BETWEEN 1 AND 5),
    AverageWeightKg FLOAT,
    Length FLOAT,
    Habitat NVARCHAR(MAX),
    Behavior NVARCHAR(MAX),
    Tips NVARCHAR(MAX)
);
DELETE FROM FishSpecies;

DBCC CHECKIDENT ('FishSpecies', RESEED, 0);
INSERT INTO FishSpecies (CommonName, ScientificName, Description, ImageUrl, Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques, DifficultyLevel, AverageWeightKg, Length, Habitat, Behavior, Tips)
VALUES
(N'Cá Lóc (Snakehead)', N'Channa striata', N'Common predatory fish found in Vietnamese waters.', N'assets/img/FishKnowledge-images/CaLoc.png', N'Small fish, frogs, insects', N'Summer - Autumn', N'Early morning', N'Rivers, ponds, rice fields', N'Lure casting, live bait', 3, 2.0, 0.6, N'Freshwater', N'Aggressive predator', N'Fish near vegetation and use surface lures.'),
(N'Cá Rô Phi (Tilapia)', N'Oreochromis niloticus', N'Popular food fish in Vietnam.', N'assets/img/FishKnowledge-images/CaRoPhi.png', N'Worms, bread, corn', N'Summer', N'Morning', N'Ponds, lakes', N'Float fishing', 1, 1.0, 0.4, N'Freshwater', N'Omnivorous, schooling', N'Use simple bait and fish in shallow waters.'),
(N'Cá Trê (Catfish)', N'Clarias batrachus', N'Common bottom-dwelling fish in Vietnam.', N'assets/img/FishKnowledge-images/CaTre.png', N'Worms, shrimp, smelly bait', N'Summer', N'Night', N'Rivers, ponds', N'Bottom fishing', 2, 2.0, 0.4, N'Freshwater', N'Nocturnal, bottom feeder', N'Use smelly bait and fish at night.'),
(N'Cá Lăng (Mystus Catfish)', N'Mystus wyckii', N'Medium-sized catfish found in Vietnamese rivers.', N'assets/img/FishKnowledge-images/CaLang.png', N'Worms, shrimp', N'Summer', N'Evening', N'Rivers', N'Bottom fishing', 2, 1.5, 0.5, N'Freshwater', N'Nocturnal, bottom dweller', N'Fish in deep river sections.'),
(N'Cá Bống (Goby)', N'Glossogobius giuris', N'Small fish common in Vietnamese waters.', N'assets/img/FishKnowledge-images/CaBong.png', N'Worms, small insects', N'All year', N'Morning', N'Rivers, estuaries', N'Small hook fishing', 1, 0.1, 0.15, N'Freshwater, brackish', N'Bottom dweller', N'Use small hooks and natural bait.'),
(N'Cá Mè (Silver Carp)', N'Hypophthalmichthys molitrix', N'Large filter-feeding fish.', N'assets/img/FishKnowledge-images/CaMe.png', N'Bread, corn', N'Summer', N'Morning', N'Lakes, rivers', N'Float fishing', 2, 0.8, 0.4, N'Freshwater', N'Filter feeder', N'Use floating bait near surface.'),
(N'Cá Chép (Common Carp)', N'Cyprinus carpio', N'Popular sport fish in Vietnam.', N'assets/img/FishKnowledge-images/CaChep.png', N'Corn, bread, worms', N'Spring - Summer', N'Morning', N'Lakes, rivers', N'Bottom fishing', 2, 2.0, 0.6, N'Freshwater', N'Bottom feeder', N'Use slightly fermented bait.'),
(N'Cá Rô Đồng (Climbing Perch)', N'Anabas testudineus', N'Hardy fish that can breathe air.', N'assets/img/FishKnowledge-images/CaRoDong.png', N'Worms, insects', N'Rainy season', N'Morning', N'Rice fields, ditches', N'Float fishing', 1, 0.2, 0.18, N'Freshwater', N'Air breather', N'Fish in shallow, muddy water.'),
(N'Cá Lóc Bông (Giant Snakehead)', N'Channa micropeltes', N'Large predatory fish.', N'assets/img/FishKnowledge-images/CaLocBong.png', N'Live fish, frogs', N'Summer', N'Dawn', N'Rivers, lakes', N'Lure casting', 4, 3.0, 0.5, N'Freshwater', N'Aggressive predator', N'Use strong gear and live bait.'),
(N'Cá Tra (Pangasius)', N'Pangasius hypophthalmus', N'Large catfish species.', N'assets/img/FishKnowledge-images/CaTra.png', N'Fish chunks, shrimp', N'Summer', N'Night', N'Rivers', N'Bottom fishing', 3, 8.0, 0.7, N'Freshwater', N'Nocturnal', N'Fish in deep water at night.'),
(N'Cá Bớp (Grouper)', N'Epinephelus coioides', N'Marine fish found in coastal waters.', N'assets/img/FishKnowledge-images/CaBopGrouper.png', N'Small fish, shrimp', N'Summer', N'Dawn', N'Coastal waters', N'Bottom fishing', 3, 10, 0.8, N'Saltwater', N'Predatory', N'Fish near coral reefs.'),
(N'Cá Mú (Grouper)', N'Epinephelus malabaricus', N'Large marine predator.', N'assets/img/FishKnowledge-images/CaMu.png', N'Live fish, squid', N'Summer', N'Dawn', N'Coastal reefs', N'Bottom fishing', 4, 5.0, 0.6, N'Saltwater', N'Ambush predator', N'Use live bait near reefs.'),
(N'Cá Đối (Mullet)', N'Mugil cephalus', N'Common coastal fish.', N'assets/img/FishKnowledge-images/CaDoi.png', N'Bread, worms', N'Summer', N'Morning', N'Estuaries', N'Float fishing', 2, 1.5, 0.4, N'Brackish water', N'Surface feeder', N'Use floating bait.'),
(N'Cá Bớp (Cobia)', N'Rachycentron canadum', N'Large marine fish.', N'assets/img/FishKnowledge-images/CaBopCobia.png', N'Live fish, squid', N'Summer', N'Dawn', N'Offshore waters', N'Trolling', 4, 10.0, 0.9, N'Saltwater', N'Predatory', N'Use strong gear offshore.'),
(N'Cá Trắm (Grass Carp)', N'Ctenopharyngodon idella', N'Large herbivorous fish.', N'assets/img/FishKnowledge-images/CaTram.png', N'Vegetables, grass', N'Summer', N'Morning', N'Lakes, rivers', N'Float fishing', 2, 5.0, 0.6, N'Freshwater', N'Herbivorous', N'Use plant-based bait.'),
(N'Cá Mè Vinh (Bighead Carp)', N'Hypophthalmichthys nobilis', N'Large filter-feeding fish.', N'assets/img/FishKnowledge-images/CaMeVinh.png', N'Bread, corn', N'Summer', N'Morning', N'Lakes, rivers', N'Float fishing', 2, 1.3, 0.4, N'Freshwater', N'Filter feeder', N'Use floating bait.'),
(N'Cá Rô Đầu Vuông (Squarehead Catfish)', N'Pangasius larnaudii', N'Medium-sized catfish.', N'assets/img/FishKnowledge-images/CaRoDauVuong.png', N'Worms, shrimp', N'Summer', N'Night', N'Rivers', N'Bottom fishing', 2, 0.7, 0.3, N'Freshwater', N'Nocturnal', N'Fish in deep water.'),
(N'Cá Bống Tượng (Giant Goby)', N'Oxyeleotris marmorata', N'Large bottom-dwelling fish.', N'assets/img/FishKnowledge-images/CaBongTruong.png', N'Worms, small fish', N'Summer', N'Night', N'Rivers, ponds', N'Bottom fishing', 3, 0.3, 0.2, N'Freshwater', N'Nocturnal', N'Use live bait.'),
(N'Cá Lăng Chấm (Spotted Catfish)', N'Hemibagrus guttatus', N'Medium-sized catfish with spots.', N'assets/img/FishKnowledge-images/CaLangCham.png', N'Worms, shrimp', N'Summer', N'Night', N'Rivers', N'Bottom fishing', 2, 3.0, 0.4, N'Freshwater', N'Nocturnal', N'Fish near river banks.'),
(N'Cá Mè Hoa (Mottled Carp)', N'Aristichthys nobilis', N'Large filter-feeding fish.', N'assets/img/FishKnowledge-images/CaMeHoa.png', N'Bread, corn', N'Summer', N'Morning', N'Lakes, rivers', N'Float fishing', 2, 0.9, 0.3, N'Freshwater', N'Filter feeder', N'Use floating bait.'),
(N'Cá Rô Phi Đỏ (Red Tilapia)', N'Oreochromis mossambicus', N'Colorful tilapia species.', N'assets/img/FishKnowledge-images/CaRoPhiDo.png', N'Worms, bread', N'Summer', N'Morning', N'Ponds, lakes', N'Float fishing', 1, 0.9, 0.3, N'Freshwater', N'Omnivorous', N'Use simple bait.'),
(N'Cá Lóc Đen (Black Snakehead)', N'Channa melasoma', N'Dark-colored snakehead.', N'assets/img/FishKnowledge-images/CaLocDen.png', N'Small fish, frogs', N'Summer', N'Dawn', N'Rivers, ponds', N'Lure casting', 3, 1.5, 0.8, N'Freshwater', N'Predatory', N'Use surface lures.'),
(N'Cá Mú Đỏ (Red Grouper)', N'Epinephelus morio', N'Colorful marine fish.', N'assets/img/FishKnowledge-images/CaMuDo.png', N'Live fish, shrimp', N'Summer', N'Dawn', N'Coral reefs', N'Bottom fishing', 3, 3.0, 0.5, N'Saltwater', N'Predatory', N'Fish near reefs.'),
(N'Cá Đối Mục (Mullet)', N'Mugil cephalus', N'Common coastal fish.', N'assets/img/FishKnowledge-images/CaDoiMuc.png', N'Bread, worms', N'Summer', N'Morning', N'Estuaries', N'Float fishing', 2, 2.0, 0.5, N'Brackish water', N'Surface feeder', N'Use floating bait.'),
(N'Cá Bớp Sọc (Striped Cobia)', N'Rachycentron canadum', N'Large marine fish.', N'assets/img/FishKnowledge-images/CaBopSoc.png', N'Live fish, squid', N'Summer', N'Dawn', N'Offshore waters', N'Trolling', 4, 4.0, 0.5, N'Saltwater', N'Predatory', N'Use strong gear.'),
(N'Cá Mú Đen (Black Grouper)', N'Mycteroperca bonaci', N'Large marine predator.', N'assets/img/FishKnowledge-images/CaMuDen.png', N'Live fish, squid', N'Summer', N'Dawn', N'Deep reefs', N'Bottom fishing', 4, 7.0, 1.0, N'Saltwater', N'Ambush predator', N'Use live bait.'),
(N'Cá Đối Bạc (Silver Mullet)', N'Mugil curema', N'Silver-colored mullet.', N'assets/img/FishKnowledge-images/CaDoiBac.png', N'Bread, worms', N'Summer', N'Morning', N'Coastal waters', N'Float fishing', 2, 0.2, 0.4, N'Saltwater', N'Surface feeder', N'Use floating bait.'),
(N'Cá Bớp Vàng (Yellow Cobia)', N'Rachycentron canadum', N'Large marine fish.', N'assets/img/FishKnowledge-images/CaBopVang.png', N'Live fish, squid', N'Summer', N'Dawn', N'Offshore waters', N'Trolling', 4, 11.0, 0.8, N'Saltwater', N'Predatory', N'Use strong gear.');


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
