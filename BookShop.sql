USE [master]
GO
/****** Object:  Database [BookShop]    Script Date: 3/22/2025 6:55:28 PM ******/
CREATE DATABASE [BookShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookShop', FILENAME = N'E:\SQL\DBI202\MSSQL15.MSSQLSERVER\MSSQL\DATA\BookShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookShop_log', FILENAME = N'E:\SQL\DBI202\MSSQL15.MSSQLSERVER\MSSQL\DATA\BookShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BookShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookShop] SET RECOVERY FULL 
GO
ALTER DATABASE [BookShop] SET  MULTI_USER 
GO
ALTER DATABASE [BookShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookShop', N'ON'
GO
ALTER DATABASE [BookShop] SET QUERY_STORE = OFF
GO
USE [BookShop]
GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 3/22/2025 6:55:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK](
	[bookID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[author] [nvarchar](100) NOT NULL,
	[translator] [nvarchar](100) NULL,
	[supplier] [nvarchar](255) NULL,
	[publisher] [nvarchar](255) NULL,
	[publishYear] [int] NOT NULL,
	[language] [nvarchar](50) NULL,
	[weight] [int] NULL,
	[dimensions] [nvarchar](100) NULL,
	[pageCount] [int] NULL,
	[format] [nvarchar](50) NULL,
	[sku] [nvarchar](50) NULL,
	[categoryID] [int] NOT NULL,
	[description] [nvarchar](2000) NULL,
	[image] [nvarchar](255) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[viewCount] [int] NOT NULL,
	[purchaseCount] [int] NOT NULL,
	[rating] [float] NULL,
	[reviewCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[bookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CART]    Script Date: 3/22/2025 6:55:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CART](
	[cartID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[bookID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 3/22/2025 6:55:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[categoryID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDER_DETAILS]    Script Date: 3/22/2025 6:55:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_DETAILS](
	[orderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[bookID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[totalPrice]  AS ([quantity]*[price]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERS]    Script Date: 3/22/2025 6:55:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[orderDate] [datetime] NOT NULL,
	[totalPrice] [decimal](10, 2) NOT NULL,
	[status] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 3/22/2025 6:55:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[address] [nvarchar](255) NULL,
	[role] [tinyint] NOT NULL,
	[purchasedBook] [varchar](255) NULL,
	[quantity] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BOOK] ON 

INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (1, N'Dune', N'Frank Herbert', NULL, N'NXB Trẻ', N'NXB Trẻ', 1965, N'Anh', 800, N'20x14 cm', 688, N'Bìa mềm', N'B001', 1, N'Tiểu thuyết khoa học viễn tưởng nổi tiếng !!!', N'https://th.bing.com/th/id/R.91ce7d845af61203c6daa49e9bf66741?rik=CbAR6Z3wyqkFZQ&pid=ImgRaw&r=0', CAST(250000.00 AS Decimal(10, 2)), 10, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (2, N'1984', N'George Orwell', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1949, N'Anh', 500, N'19x13 cm', 328, N'Bìa mềm', N'B002', 2, N'Tiểu thuyết dystopia kinh điển', N'1984.jpg', CAST(180000.00 AS Decimal(10, 2)), 15, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (3, N'Sapiens', N'Yuval Noah Harari', NULL, N'NXB Lao Động', N'NXB Lao Động', 2011, N'Anh', 600, N'23x15 cm', 512, N'Bìa cứng', N'B003', 3, N'Lịch sử loài người', N'sapiens.jpg', CAST(300000.00 AS Decimal(10, 2)), 8, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (4, N'Clean Code', N'Robert C. Martin', NULL, N'NXB FPT', N'NXB FPT', 2008, N'Anh', 700, N'24x16 cm', 464, N'Bìa mềm', N'B004', 4, N'Sách lập trình hướng dẫn viết code sạch', N'cleancode.jpg', CAST(350000.00 AS Decimal(10, 2)), 5, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (5, N'Thần thoại Bắc Âu', N'Neil Gaiman', NULL, N'NXB Văn Học', N'NXB Văn Học', 2017, N'Anh', 550, N'20x13 cm', 304, N'Bìa cứng', N'B005', 2, N'Cuốn sách kể lại những thần thoại Bắc Âu hấp dẫn', N'norse.jpg', CAST(220000.00 AS Decimal(10, 2)), 12, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (6, N'Tâm lý học tội phạm', N'David Canter', NULL, N'NXB Đại Học Quốc Gia', N'NXB Đại Học Quốc Gia', 2015, N'Anh', 580, N'22x15 cm', 400, N'Bìa mềm', N'B006', 7, N'Phân tích hành vi tội phạm từ góc nhìn tâm lý học', N'criminal.jpg', CAST(270000.00 AS Decimal(10, 2)), 7, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (7, N'Nhà Giả Kim', N'Paulo Coelho', N'Lê Chu Cầu', N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1988, N'Việt Nam', 450, N'18x12 cm', 208, N'Bìa mềm', N'B007', 2, N'Tác phẩm kinh điển về hành trình tìm kiếm ý nghĩa cuộc sống', N'alchemist.jpg', CAST(150000.00 AS Decimal(10, 2)), 20, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (8, N'Đắc Nhân Tâm', N'Dale Carnegie', N'Nguyễn Hiến Lê', N'NXB Trẻ', N'NXB Trẻ', 1936, N'Việt Nam', 400, N'20x14 cm', 320, N'Bìa mềm', N'B008', 6, N'Bí quyết giao tiếp và thành công trong cuộc sống', N'dactam.jpg', CAST(180000.00 AS Decimal(10, 2)), 18, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (9, N'Tuổi Trẻ Đáng Giá Bao Nhiêu', N'Rosie Nguyễn', NULL, N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 2017, N'Việt Nam', 500, N'21x14 cm', 280, N'Bìa mềm', N'B009', 8, N'Cuốn sách truyền cảm hứng cho người trẻ', N'tuoitre.jpg', CAST(160000.00 AS Decimal(10, 2)), 25, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (10, N'Người Trong Muôn Nghề', N'Nhiều Tác Giả', NULL, N'NXB Trẻ', N'NXB Trẻ', 2020, N'Việt Nam', 550, N'21x14 cm', 300, N'Bìa mềm', N'B010', 7, N'Tuyển tập chia sẻ của những người đi trước trong nhiều ngành nghề', N'nghe.jpg', CAST(170000.00 AS Decimal(10, 2)), 22, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (11, N'Lập Trình Viên Đường Tắt', N'John Sonmez', NULL, N'NXB FPT', N'NXB FPT', 2016, N'Anh', 650, N'23x16 cm', 400, N'Bìa mềm', N'B011', 4, N'Cuốn sách giúp lập trình viên phát triển kỹ năng chuyên môn', N'programmer.jpg', CAST(260000.00 AS Decimal(10, 2)), 15, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (12, N'Homo Deus', N'Yuval Noah Harari', NULL, N'NXB Thế Giới', N'NXB Thế Giới', 2015, N'Anh', 680, N'24x15 cm', 450, N'Bìa cứng', N'B012', 3, N'Tương lai của loài người khi trí tuệ nhân tạo phát triển', N'homodeus.jpg', CAST(290000.00 AS Decimal(10, 2)), 10, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (13, N'Triết Học Cho Người Trẻ', N'Nhiều Tác Giả', NULL, N'NXB Trẻ', N'NXB Trẻ', 2019, N'Việt Nam', 500, N'20x13 cm', 280, N'Bìa mềm', N'B013', 5, N'Giới thiệu những tư tưởng triết học nổi tiếng', N'philosophy.jpg', CAST(150000.00 AS Decimal(10, 2)), 17, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (14, N'Tiếng Anh Cơ Bản', N'Nhiều Tác Giả', NULL, N'NXB Giáo Dục', N'NXB Giáo Dục', 2021, N'Việt Nam', 600, N'25x18 cm', 320, N'Bìa mềm', N'B014', 2, N'Sách học tiếng Anh cho người mới bắt đầu', N'english.jpg', CAST(120000.00 AS Decimal(10, 2)), 30, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (15, N'Truyện Kiều', N'Nguyễn Du', NULL, N'NXB Văn Học', N'NXB Văn Học', 1820, N'Việt Nam', 600, N'20x13 cm', 325, N'Bìa cứng', N'B015', 1, N'Tác phẩm kinh điển của văn học Việt Nam', N'truyen_kieu.jpg', CAST(200000.00 AS Decimal(10, 2)), 20, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (16, N'Những Ngày Thơ Ấu', N'Nguyên Hồng', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1938, N'Việt Nam', 400, N'19x13 cm', 200, N'Bìa mềm', N'B016', 1, N'Hồi ký tuổi thơ đầy xúc động', N'tho_au.jpg', CAST(120000.00 AS Decimal(10, 2)), 15, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (17, N'Vợ Nhặt', N'Kim Lân', NULL, N'NXB Trẻ', N'NXB Trẻ', 1962, N'Việt Nam', 350, N'20x14 cm', 150, N'Bìa mềm', N'B017', 1, N'Truyện ngắn nổi tiếng phản ánh cuộc sống khó khăn', N'vo_nhat.jpg', CAST(110000.00 AS Decimal(10, 2)), 18, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (18, N'Chí Phèo', N'Nam Cao', NULL, N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1941, N'Việt Nam', 300, N'18x12 cm', 120, N'Bìa mềm', N'B018', 1, N'Truyện ngắn hiện thực phê phán nổi tiếng', N'chi_pheo.jpg', CAST(100000.00 AS Decimal(10, 2)), 22, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (19, N'Đất Rừng Phương Nam', N'Đoàn Giỏi', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1957, N'Việt Nam', 500, N'21x14 cm', 280, N'Bìa mềm', N'B019', 1, N'Truyện về tuổi thơ và thiên nhiên Nam Bộ', N'dat_rung.jpg', CAST(150000.00 AS Decimal(10, 2)), 25, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (20, N'Nhật Ký Trong Tù', N'Hồ Chí Minh', NULL, N'NXB Chính Trị Quốc Gia', N'NXB Chính Trị Quốc Gia', 1943, N'Việt Nam', 450, N'20x14 cm', 250, N'Bìa mềm', N'B020', 1, N'Tập thơ nổi tiếng của Chủ tịch Hồ Chí Minh', N'nhat_ky.jpg', CAST(130000.00 AS Decimal(10, 2)), 30, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (21, N'Mắt Biếc', N'Nguyễn Nhật Ánh', NULL, N'NXB Trẻ', N'NXB Trẻ', 1990, N'Việt Nam', 600, N'20x13 cm', 300, N'Bìa mềm', N'B021', 2, N'Tiểu thuyết tình yêu nổi tiếng', N'mat_biec.jpg', CAST(160000.00 AS Decimal(10, 2)), 20, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (22, N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', N'Nguyễn Nhật Ánh', NULL, N'NXB Trẻ', N'NXB Trẻ', 2008, N'Việt Nam', 550, N'21x14 cm', 320, N'Bìa mềm', N'B022', 2, N'Truyện dành cho lứa tuổi thiếu niên', N've_tuoi_tho.jpg', CAST(140000.00 AS Decimal(10, 2)), 25, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (23, N'Bố Già', N'Mario Puzo', N'Ngọc Thứ Lang', N'NXB Văn Học', N'NXB Văn Học', 1969, N'Việt Nam', 700, N'24x16 cm', 500, N'Bìa cứng', N'B023', 3, N'Tiểu thuyết về giới mafia nổi tiếng', N'bo_gia.jpg', CAST(280000.00 AS Decimal(10, 2)), 10, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (24, N'Dế Mèn Phiêu Lưu Ký', N'Tô Hoài', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1941, N'Việt Nam', 450, N'19x13 cm', 250, N'Bìa mềm', N'B024', 2, N'Truyện thiếu nhi kinh điển', N'de_men.jpg', CAST(120000.00 AS Decimal(10, 2)), 30, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (25, N'Trăm Năm Cô Đơn', N'Gabriel Garcia Marquez', N'Trịnh Lữ', N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1967, N'Việt Nam', 680, N'21x14 cm', 500, N'Bìa mềm', N'B026', 3, N'Tác phẩm văn học Mỹ Latinh nổi tiếng', N'tram_nam.jpg', CAST(260000.00 AS Decimal(10, 2)), 15, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (26, N'Nanh Trắng', N'Jack London', N'Phan Quang Định', N'NXB Văn Học', N'NXB Văn Học', 1906, N'Việt Nam', 550, N'20x14 cm', 350, N'Bìa mềm', N'B027', 3, N'Truyện về cuộc hành trình sinh tồn của một con sói', N'nanh_trang.jpg', CAST(180000.00 AS Decimal(10, 2)), 12, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (27, N'Thi Nhân Việt Nam', N'Hoài Thanh - Hoài Chân', NULL, N'NXB Văn Học', N'NXB Văn Học', 1942, N'Việt Nam', 700, N'21x14 cm', 400, N'Bìa mềm', N'B028', 4, N'Tổng hợp những bài thơ hay thời kỳ Thơ Mới', N'thi_nhan.jpg', CAST(210000.00 AS Decimal(10, 2)), 10, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (28, N'Vang Bóng Một Thời', N'Nguyễn Tuân', NULL, N'NXB Văn Học', N'NXB Văn Học', 1940, N'Việt Nam', 500, N'20x13 cm', 320, N'Bìa mềm', N'B029', 4, N'Tập truyện ngắn nổi tiếng của Nguyễn Tuân', N'vang_bong.jpg', CAST(170000.00 AS Decimal(10, 2)), 15, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (29, N'Lão Hạc', N'Nam Cao', NULL, N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1943, N'Việt Nam', 350, N'18x12 cm', 150, N'Bìa mềm', N'B030', 1, N'Truyện ngắn xúc động về số phận người nông dân', N'lao_hac.jpg', CAST(110000.00 AS Decimal(10, 2)), 25, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (30, N'Harry Potter và Hòn Đá Phù Thủy', N'J.K. Rowling', N'Lý Lan', N'NXB Trẻ', N'NXB Trẻ', 1997, N'Việt Nam', 500, N'20x14 cm', 336, N'Bìa cứng', N'B031', 5, N'Tập đầu tiên trong loạt truyện Harry Potter', N'harry_potter1.jpg', CAST(180000.00 AS Decimal(10, 2)), 20, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (31, N'Charlie và Nhà Máy Sôcôla', N'Roald Dahl', N'Hồng Vân', N'NXB Kim Đồng', N'NXB Kim Đồng', 1964, N'Việt Nam', 450, N'19x13 cm', 208, N'Bìa mềm', N'B032', 5, N'Câu chuyện thú vị về một cậu bé khám phá nhà máy sôcôla', N'charlie.jpg', CAST(150000.00 AS Decimal(10, 2)), 18, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (32, N'Cậu Bé Rừng Xanh', N'Rudyard Kipling', N'Tran Ngoc Anh', N'NXB Văn Học', N'NXB Văn Học', 1894, N'Việt Nam', 400, N'18x12 cm', 250, N'Bìa mềm', N'B033', 5, N'Truyện về cuộc sống của Mowgli trong rừng', N'jungle_book.jpg', CAST(130000.00 AS Decimal(10, 2)), 15, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (33, N'One Piece - Tập 1', N'Eiichiro Oda', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1997, N'Nhật Bản', 300, N'17x12 cm', 200, N'Bìa mềm', N'B034', 8, N'Tập đầu tiên của bộ truyện tranh nổi tiếng One Piece', N'https://cf.shopee.vn/file/6f58c15429706e56ab044e4e34e2fa69', CAST(25000.00 AS Decimal(10, 2)), 50, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (34, N'Doraemon - Tập 1', N'Fujiko F. Fujio', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1969, N'Nhật Bản', 280, N'17x12 cm', 180, N'Bìa mềm', N'B035', 8, N'Những câu chuyện thú vị về Doraemon và Nobita', N'https://th.bing.com/th/id/R.dd0f108257801b3fa728750d79c08120?rik=C%2bA1s4PWs0oGug&pid=ImgRaw&r=0', CAST(20000.00 AS Decimal(10, 2)), 6, 0, 2, 0, 2)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (36, N'DORAEMON - TẬP 2', N'Fujiko F. Fujio', N'HUY', N'JP', N'Fujiko F. Fujio', 1969, N'Tiếng Việt', 69, N'5x5x6', 30, N'Bìa cứng', N'B036', 8, N'Hay', N'https://cf.shopee.vn/file/0aeb318476d359ff932381ce65139f04', CAST(20000.00 AS Decimal(10, 2)), 10, 0, 0, 0, 0)
INSERT [dbo].[BOOK] ([bookID], [title], [author], [translator], [supplier], [publisher], [publishYear], [language], [weight], [dimensions], [pageCount], [format], [sku], [categoryID], [description], [image], [price], [quantity], [viewCount], [purchaseCount], [rating], [reviewCount]) VALUES (38, N'DORAEMON - TẬP 3', N'Fujiko F. Fujio', N'HUY', N'JP', N'Fujiko F. Fujio', 1969, N'Tiếng Việt', 69, N'5x5x6', 30, N'Bìa cứng', N'B036', 8, N'hayyyy', N'https://th.bing.com/th/id/OIP.3WLtiCjsql0fLIAlj_ZoTgHaMT?rs=1&pid=ImgDetMain', CAST(20000.00 AS Decimal(10, 2)), 10, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[BOOK] OFF
GO
SET IDENTITY_INSERT [dbo].[CART] ON 

INSERT [dbo].[CART] ([cartID], [userID], [bookID], [quantity]) VALUES (1, 2, 11, 1)
INSERT [dbo].[CART] ([cartID], [userID], [bookID], [quantity]) VALUES (2, 2, 22, 2)
INSERT [dbo].[CART] ([cartID], [userID], [bookID], [quantity]) VALUES (3, 3, 23, 1)
SET IDENTITY_INSERT [dbo].[CART] OFF
GO
SET IDENTITY_INSERT [dbo].[CATEGORY] ON 

INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (4, N'Công nghệ thông tin')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (1, N'Khoa học viễn tưởng')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (6, N'Kinh tế')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (3, N'Lịch sử')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (7, N'Tâm lý học')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (5, N'Thiếu nhi')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (8, N'Truyện tranh')
INSERT [dbo].[CATEGORY] ([categoryID], [name]) VALUES (2, N'Văn học')
SET IDENTITY_INSERT [dbo].[CATEGORY] OFF
GO
SET IDENTITY_INSERT [dbo].[ORDER_DETAILS] ON 

INSERT [dbo].[ORDER_DETAILS] ([orderDetailID], [orderID], [bookID], [quantity], [price]) VALUES (1, 1, 11, 1, CAST(250000.00 AS Decimal(10, 2)))
INSERT [dbo].[ORDER_DETAILS] ([orderDetailID], [orderID], [bookID], [quantity], [price]) VALUES (2, 1, 22, 2, CAST(300000.00 AS Decimal(10, 2)))
INSERT [dbo].[ORDER_DETAILS] ([orderDetailID], [orderID], [bookID], [quantity], [price]) VALUES (3, 2, 23, 1, CAST(350000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[ORDER_DETAILS] OFF
GO
SET IDENTITY_INSERT [dbo].[ORDERS] ON 

INSERT [dbo].[ORDERS] ([orderID], [userID], [orderDate], [totalPrice], [status]) VALUES (1, 2, CAST(N'2024-03-10T14:30:00.000' AS DateTime), CAST(750000.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[ORDERS] ([orderID], [userID], [orderDate], [totalPrice], [status]) VALUES (2, 3, CAST(N'2024-03-11T09:15:00.000' AS DateTime), CAST(350000.00 AS Decimal(10, 2)), 0)
SET IDENTITY_INSERT [dbo].[ORDERS] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([userID], [username], [password], [email], [phone], [address], [role], [purchasedBook], [quantity], [totalPrice]) VALUES (1, N'admin', N'hashedpassword123', N'admin@example.com', N'0123456789', N'Hà Nội', 1, NULL, NULL, NULL)
INSERT [dbo].[USERS] ([userID], [username], [password], [email], [phone], [address], [role], [purchasedBook], [quantity], [totalPrice]) VALUES (2, N'user1', N'hashedpassword456', N'user1@example.com', N'0987654321', N'TP Hồ Chí Minh', 0, NULL, NULL, NULL)
INSERT [dbo].[USERS] ([userID], [username], [password], [email], [phone], [address], [role], [purchasedBook], [quantity], [totalPrice]) VALUES (3, N'khanhhoa', N'hoa2102', N'hoa@gmail.com', N'0388982778', N'Kon Tum', 1, NULL, NULL, NULL)
INSERT [dbo].[USERS] ([userID], [username], [password], [email], [phone], [address], [role], [purchasedBook], [quantity], [totalPrice]) VALUES (5, N'huy', N'123', N'huy@gmail.com', N'0966867027', N'Quảng Nam', 1, NULL, NULL, NULL)
INSERT [dbo].[USERS] ([userID], [username], [password], [email], [phone], [address], [role], [purchasedBook], [quantity], [totalPrice]) VALUES (10, N'huy123', N'123', N'tanhuytk2004@gmail.com', N'0966867027', N'Việt Nam', 0, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO
/****** Object:  Index [UQ__CART__032446CCCAE26A22]    Script Date: 3/22/2025 6:55:29 PM ******/
ALTER TABLE [dbo].[CART] ADD UNIQUE NONCLUSTERED 
(
	[userID] ASC,
	[bookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CATEGORY__72E12F1BCBBCC5CD]    Script Date: 3/22/2025 6:55:29 PM ******/
ALTER TABLE [dbo].[CATEGORY] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__USERS__AB6E616465EA6CC2]    Script Date: 3/22/2025 6:55:29 PM ******/
ALTER TABLE [dbo].[USERS] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__USERS__F3DBC572B82E0AE9]    Script Date: 3/22/2025 6:55:29 PM ******/
ALTER TABLE [dbo].[USERS] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BOOK] ADD  DEFAULT ((0)) FOR [viewCount]
GO
ALTER TABLE [dbo].[BOOK] ADD  DEFAULT ((0)) FOR [purchaseCount]
GO
ALTER TABLE [dbo].[BOOK] ADD  DEFAULT ((0)) FOR [rating]
GO
ALTER TABLE [dbo].[BOOK] ADD  DEFAULT ((0)) FOR [reviewCount]
GO
ALTER TABLE [dbo].[ORDERS] ADD  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [quantity]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0.0)) FOR [totalPrice]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD FOREIGN KEY([categoryID])
REFERENCES [dbo].[CATEGORY] ([categoryID])
GO
ALTER TABLE [dbo].[CART]  WITH CHECK ADD FOREIGN KEY([bookID])
REFERENCES [dbo].[BOOK] ([bookID])
GO
ALTER TABLE [dbo].[CART]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[USERS] ([userID])
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD FOREIGN KEY([bookID])
REFERENCES [dbo].[BOOK] ([bookID])
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD FOREIGN KEY([orderID])
REFERENCES [dbo].[ORDERS] ([orderID])
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[USERS] ([userID])
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD CHECK  (([quantity]>=(0)))
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD CHECK  (([rating]>=(0) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[CART]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[ORDER_DETAILS]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD CHECK  (([status]=(3) OR [status]=(2) OR [status]=(1) OR [status]=(0)))
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD CHECK  (([totalPrice]>=(0)))
GO
ALTER TABLE [dbo].[USERS]  WITH CHECK ADD CHECK  (([role]=(1) OR [role]=(0)))
GO
USE [master]
GO
ALTER DATABASE [BookShop] SET  READ_WRITE 
GO
