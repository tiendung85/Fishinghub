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
    MaxWeightKg FLOAT,
    Habitat NVARCHAR(MAX),
    Behavior NVARCHAR(MAX),
    Tips NVARCHAR(MAX)
);

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
