create table USERS (
    userID int identity(1,1) primary key,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    phone varchar(15) not null,
    address nvarchar(255),
    role tinyint not null check (role in (0,1)) -- 0: User, 1: Admin
);

create table CATEGORY (
    categoryID int identity(1,1) primary key,
    name nvarchar(100) not null unique
);

create table BOOK (
    bookID int identity(1,1) primary key,
    title nvarchar(255) not null,
    author nvarchar(100) not null,
    translator nvarchar(100),
    supplier nvarchar(255),
    publisher nvarchar(255),
    publishYear int not null,
    language nvarchar(50),
    weight int,
    dimensions nvarchar(100),
    pageCount int,
    format nvarchar(50),
    sku nvarchar(50),
    categoryID int not null foreign key references CATEGORY(categoryID),
    description nvarchar(2000),
    image nvarchar(255),
    price decimal(10,2) not null check (price >= 0),
    quantity int not null check (quantity >= 0),
    viewCount int not null default 0,
    purchaseCount int not null default 0,
    rating float check (rating between 0 and 5) default 0,
    reviewCount int default 0
);

create table CART (
    cartID int identity(1,1) primary key,
    userID int not null foreign key references USERS(userID),
    bookID int not null foreign key references BOOK(bookID),
    quantity int not null check (quantity > 0),
    unique (userID, bookID)
);

create table ORDERS (
    orderID int identity(1,1) primary key,
    userID int not null foreign key references USERS(userID),
    orderDate datetime not null default getdate(),
    totalPrice decimal(10,2) not null check (totalPrice >= 0),
    status tinyint not null check (status in (0,1,2,3))
);


create table ORDER_DETAILS (
    orderDetailID int identity(1,1) primary key,
    orderID int not null foreign key references ORDERS(orderID),
    bookID int not null foreign key references BOOK(bookID),
    quantity int not null check (quantity > 0),
    price decimal(10,2) not null check (price >= 0),
    totalPrice as (quantity * price) persisted
);

-- Thêm người dùng
INSERT INTO USERS (username, password, email, phone, address, role) VALUES
('admin', 'hashedpassword123', 'admin@example.com', '0123456789', 'Hà Nội', 1),
('user1', 'hashedpassword456', 'user1@example.com', '0987654321', 'TP Hồ Chí Minh', 0),
('khanhhoa', 'hoa2102','hoa@gmail.com','0388982778', 'Kon Tum', 1),
('user2', 'hashedpassword789', 'user2@example.com', '0912345678', 'Đà Nẵng', 0);

-- Thêm danh mục sách
INSERT INTO CATEGORY (name) VALUES
(N'Khoa học viễn tưởng'),
(N'Văn học'),
(N'Lịch sử'),
(N'Công nghệ thông tin'),
(N'Thiếu nhi'),
(N'Kinh tế'),
(N'Tâm lý học'),
(N'Truyện tranh');

-- Thêm sách
INSERT INTO BOOK (title, author, translator, supplier, publisher, publishYear, language, weight, dimensions, pageCount, format, sku, categoryID, description, image, price, quantity) VALUES
(N'Dune', N'Frank Herbert', NULL, N'NXB Trẻ', N'NXB Trẻ', 1965, N'Anh', 800, N'20x14 cm', 688, N'Bìa mềm', N'B001', 1, N'Tiểu thuyết khoa học viễn tưởng nổi tiếng', 'dune.jpg', 250000, 10),
(N'1984', N'George Orwell', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1949, N'Anh', 500, N'19x13 cm', 328, N'Bìa mềm', N'B002', 2, N'Tiểu thuyết dystopia kinh điển', '1984.jpg', 180000, 15),
(N'Sapiens', N'Yuval Noah Harari', NULL, N'NXB Lao Động', N'NXB Lao Động', 2011, N'Anh', 600, N'23x15 cm', 512, N'Bìa cứng', N'B003', 3, N'Lịch sử loài người', 'sapiens.jpg', 300000, 8),
(N'Clean Code', N'Robert C. Martin', NULL, N'NXB FPT', N'NXB FPT', 2008, N'Anh', 700, N'24x16 cm', 464, N'Bìa mềm', N'B004', 4, N'Sách lập trình hướng dẫn viết code sạch', 'cleancode.jpg', 350000, 5),
(N'Thần thoại Bắc Âu', N'Neil Gaiman', NULL, N'NXB Văn Học', N'NXB Văn Học', 2017, N'Anh', 550, N'20x13 cm', 304, N'Bìa cứng', N'B005', 2, N'Cuốn sách kể lại những thần thoại Bắc Âu hấp dẫn', 'norse.jpg', 220000, 12),
(N'Tâm lý học tội phạm', N'David Canter', NULL, N'NXB Đại Học Quốc Gia', N'NXB Đại Học Quốc Gia', 2015, N'Anh', 580, N'22x15 cm', 400, N'Bìa mềm', N'B006', 7, N'Phân tích hành vi tội phạm từ góc nhìn tâm lý học', 'criminal.jpg', 270000, 7),
(N'Nhà Giả Kim', N'Paulo Coelho', N'Lê Chu Cầu', N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1988, N'Việt Nam', 450, N'18x12 cm', 208, N'Bìa mềm', N'B007', 2, N'Tác phẩm kinh điển về hành trình tìm kiếm ý nghĩa cuộc sống', 'alchemist.jpg', 150000, 20),
(N'Đắc Nhân Tâm', N'Dale Carnegie', N'Nguyễn Hiến Lê', N'NXB Trẻ', N'NXB Trẻ', 1936, N'Việt Nam', 400, N'20x14 cm', 320, N'Bìa mềm', N'B008', 6, N'Bí quyết giao tiếp và thành công trong cuộc sống', 'dactam.jpg', 180000, 18),
(N'Tuổi Trẻ Đáng Giá Bao Nhiêu', N'Rosie Nguyễn', NULL, N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 2017, N'Việt Nam', 500, N'21x14 cm', 280, N'Bìa mềm', N'B009', 8, N'Cuốn sách truyền cảm hứng cho người trẻ', 'tuoitre.jpg', 160000, 25),
(N'Người Trong Muôn Nghề', N'Nhiều Tác Giả', NULL, N'NXB Trẻ', N'NXB Trẻ', 2020, N'Việt Nam', 550, N'21x14 cm', 300, N'Bìa mềm', N'B010', 7, N'Tuyển tập chia sẻ của những người đi trước trong nhiều ngành nghề', 'nghe.jpg', 170000, 22),
(N'Lập Trình Viên Đường Tắt', N'John Sonmez', NULL, N'NXB FPT', N'NXB FPT', 2016, N'Anh', 650, N'23x16 cm', 400, N'Bìa mềm', N'B011', 4, N'Cuốn sách giúp lập trình viên phát triển kỹ năng chuyên môn', 'programmer.jpg', 260000, 15),
(N'Homo Deus', N'Yuval Noah Harari', NULL, N'NXB Thế Giới', N'NXB Thế Giới', 2015, N'Anh', 680, N'24x15 cm', 450, N'Bìa cứng', N'B012', 3, N'Tương lai của loài người khi trí tuệ nhân tạo phát triển', 'homodeus.jpg', 290000, 10),
(N'Triết Học Cho Người Trẻ', N'Nhiều Tác Giả', NULL, N'NXB Trẻ', N'NXB Trẻ', 2019, N'Việt Nam', 500, N'20x13 cm', 280, N'Bìa mềm', N'B013', 5, N'Giới thiệu những tư tưởng triết học nổi tiếng', 'philosophy.jpg', 150000, 17),
(N'Tiếng Anh Cơ Bản', N'Nhiều Tác Giả', NULL, N'NXB Giáo Dục', N'NXB Giáo Dục', 2021, N'Việt Nam', 600, N'25x18 cm', 320, N'Bìa mềm', N'B014', 2, N'Sách học tiếng Anh cho người mới bắt đầu', 'english.jpg', 120000, 30),
(N'Truyện Kiều', N'Nguyễn Du', NULL, N'NXB Văn Học', N'NXB Văn Học', 1820, N'Việt Nam', 600, N'20x13 cm', 325, N'Bìa cứng', N'B015', 1, N'Tác phẩm kinh điển của văn học Việt Nam', 'truyen_kieu.jpg', 200000, 20),
(N'Những Ngày Thơ Ấu', N'Nguyên Hồng', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1938, N'Việt Nam', 400, N'19x13 cm', 200, N'Bìa mềm', N'B016', 1, N'Hồi ký tuổi thơ đầy xúc động', 'tho_au.jpg', 120000, 15),
(N'Vợ Nhặt', N'Kim Lân', NULL, N'NXB Trẻ', N'NXB Trẻ', 1962, N'Việt Nam', 350, N'20x14 cm', 150, N'Bìa mềm', N'B017', 1, N'Truyện ngắn nổi tiếng phản ánh cuộc sống khó khăn', 'vo_nhat.jpg', 110000, 18),
(N'Chí Phèo', N'Nam Cao', NULL, N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1941, N'Việt Nam', 300, N'18x12 cm', 120, N'Bìa mềm', N'B018', 1, N'Truyện ngắn hiện thực phê phán nổi tiếng', 'chi_pheo.jpg', 100000, 22),
(N'Đất Rừng Phương Nam', N'Đoàn Giỏi', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1957, N'Việt Nam', 500, N'21x14 cm', 280, N'Bìa mềm', N'B019', 1, N'Truyện về tuổi thơ và thiên nhiên Nam Bộ', 'dat_rung.jpg', 150000, 25),
(N'Nhật Ký Trong Tù', N'Hồ Chí Minh', NULL, N'NXB Chính Trị Quốc Gia', N'NXB Chính Trị Quốc Gia', 1943, N'Việt Nam', 450, N'20x14 cm', 250, N'Bìa mềm', N'B020', 1, N'Tập thơ nổi tiếng của Chủ tịch Hồ Chí Minh', 'nhat_ky.jpg', 130000, 30),
(N'Mắt Biếc', N'Nguyễn Nhật Ánh', NULL, N'NXB Trẻ', N'NXB Trẻ', 1990, N'Việt Nam', 600, N'20x13 cm', 300, N'Bìa mềm', N'B021', 2, N'Tiểu thuyết tình yêu nổi tiếng', 'mat_biec.jpg', 160000, 20),
(N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', N'Nguyễn Nhật Ánh', NULL, N'NXB Trẻ', N'NXB Trẻ', 2008, N'Việt Nam', 550, N'21x14 cm', 320, N'Bìa mềm', N'B022', 2, N'Truyện dành cho lứa tuổi thiếu niên', 've_tuoi_tho.jpg', 140000, 25),
(N'Bố Già', N'Mario Puzo', N'Ngọc Thứ Lang', N'NXB Văn Học', N'NXB Văn Học', 1969, N'Việt Nam', 700, N'24x16 cm', 500, N'Bìa cứng', N'B023', 3, N'Tiểu thuyết về giới mafia nổi tiếng', 'bo_gia.jpg', 280000, 10),
(N'Dế Mèn Phiêu Lưu Ký', N'Tô Hoài', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1941, N'Việt Nam', 450, N'19x13 cm', 250, N'Bìa mềm', N'B024', 2, N'Truyện thiếu nhi kinh điển', 'de_men.jpg', 120000, 30),
(N'Trăm Năm Cô Đơn', N'Gabriel Garcia Marquez', N'Trịnh Lữ', N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1967, N'Việt Nam', 680, N'21x14 cm', 500, N'Bìa mềm', N'B026', 3, N'Tác phẩm văn học Mỹ Latinh nổi tiếng', 'tram_nam.jpg', 260000, 15),
(N'Nanh Trắng', N'Jack London', N'Phan Quang Định', N'NXB Văn Học', N'NXB Văn Học', 1906, N'Việt Nam', 550, N'20x14 cm', 350, N'Bìa mềm', N'B027', 3, N'Truyện về cuộc hành trình sinh tồn của một con sói', 'nanh_trang.jpg', 180000, 12),
(N'Thi Nhân Việt Nam', N'Hoài Thanh - Hoài Chân', NULL, N'NXB Văn Học', N'NXB Văn Học', 1942, N'Việt Nam', 700, N'21x14 cm', 400, N'Bìa mềm', N'B028', 4, N'Tổng hợp những bài thơ hay thời kỳ Thơ Mới', 'thi_nhan.jpg', 210000, 10),
(N'Vang Bóng Một Thời', N'Nguyễn Tuân', NULL, N'NXB Văn Học', N'NXB Văn Học', 1940, N'Việt Nam', 500, N'20x13 cm', 320, N'Bìa mềm', N'B029', 4, N'Tập truyện ngắn nổi tiếng của Nguyễn Tuân', 'vang_bong.jpg', 170000, 15),
(N'Lão Hạc', N'Nam Cao', NULL, N'NXB Hội Nhà Văn', N'NXB Hội Nhà Văn', 1943, N'Việt Nam', 350, N'18x12 cm', 150, N'Bìa mềm', N'B030', 1, N'Truyện ngắn xúc động về số phận người nông dân', 'lao_hac.jpg', 110000, 25),
(N'Harry Potter và Hòn Đá Phù Thủy', N'J.K. Rowling', N'Lý Lan', N'NXB Trẻ', N'NXB Trẻ', 1997, N'Việt Nam', 500, N'20x14 cm', 336, N'Bìa cứng', N'B031', 5, N'Tập đầu tiên trong loạt truyện Harry Potter', 'harry_potter1.jpg', 180000, 20),
(N'Charlie và Nhà Máy Sôcôla', N'Roald Dahl', N'Hồng Vân', N'NXB Kim Đồng', N'NXB Kim Đồng', 1964, N'Việt Nam', 450, N'19x13 cm', 208, N'Bìa mềm', N'B032', 5, N'Câu chuyện thú vị về một cậu bé khám phá nhà máy sôcôla', 'charlie.jpg', 150000, 18),
(N'Cậu Bé Rừng Xanh', N'Rudyard Kipling', N'Tran Ngoc Anh', N'NXB Văn Học', N'NXB Văn Học', 1894, N'Việt Nam', 400, N'18x12 cm', 250, N'Bìa mềm', N'B033', 5, N'Truyện về cuộc sống của Mowgli trong rừng', 'jungle_book.jpg', 130000, 15),
(N'One Piece - Tập 1', N'Eiichiro Oda', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1997, N'Nhật Bản', 300, N'17x12 cm', 200, N'Bìa mềm', N'B034', 8, N'Tập đầu tiên của bộ truyện tranh nổi tiếng One Piece', 'one_piece1.jpg', 25000, 50),
(N'Doraemon - Tập 1', N'Fujiko F. Fujio', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1969, N'Nhật Bản', 280, N'17x12 cm', 180, N'Bìa mềm', N'B035', 8, N'Những câu chuyện thú vị về Doraemon và Nobita', 'doraemon1.jpg', 20000, 60),
(N'Naruto - Tập 1', N'Masashi Kishimoto', NULL, N'NXB Kim Đồng', N'NXB Kim Đồng', 1999, N'Nhật Bản', 320, N'17x12 cm', 210, N'Bìa mềm', N'B036', 8, N'Tập đầu tiên trong bộ truyện tranh Naruto', 'naruto1.jpg', 30000, 40);



-- Thêm sản phẩm vào giỏ hàng
INSERT INTO CART (userID, bookID, quantity) VALUES
(2, 11, 1),
(2, 22, 2),
(3, 23, 1);

-- Thêm đơn hàng
INSERT INTO ORDERS (userID, orderDate, totalPrice, status) VALUES
(2, '2024-03-10 14:30:00', 750000, 1),
(3, '2024-03-11 09:15:00', 350000, 0);

-- Thêm chi tiết đơn hàng
INSERT INTO ORDER_DETAILS (orderID, bookID, quantity, price) VALUES
(1, 11, 1, 250000),
(1, 22, 2, 300000),
(2, 23, 1, 350000);
