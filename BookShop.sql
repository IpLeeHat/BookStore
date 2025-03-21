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
    publishDate date not null,
    categoryID int not null foreign key references CATEGORY(categoryID),
    description nvarchar(1000),
    image nvarchar(255), -- Đường dẫn ảnh
    price decimal(10,2) not null check (price >= 0),
    quantity int not null check (quantity >= 0),
    viewCount int not null default 0,
    purchaseCount int not null default 0
);

create table CART (
    cartID int identity(1,1) primary key,
    userID int not null foreign key references USERS(userID),
    bookID int not null foreign key references BOOK(bookID),
    quantity int not null check (quantity > 0),
    unique (userID, bookID) -- Tránh trùng sách trong giỏ hàng của cùng một user
);

create table ORDERS (
    orderID int identity(1,1) primary key,
    userID int not null foreign key references USERS(userID),
    orderDate datetime not null default getdate(),
    totalPrice decimal(10,2) not null check (totalPrice >= 0),
    status tinyint not null check (status in (0,1,2,3)) 
    -- 0: Chờ xử lý, 1: Đang giao, 2: Đã giao, 3: Đã hủy
);

create table ORDER_DETAILS (
    orderDetailID int identity(1,1) primary key,
    orderID int not null foreign key references ORDERS(orderID),
    bookID int not null foreign key references BOOK(bookID),
    quantity int not null check (quantity > 0),
    price decimal(10,2) not null check (price >= 0),
    totalPrice as (quantity * price) persisted -- Tổng tiền của từng sách trong đơn hàng
);

-- Thêm người dùng
INSERT INTO USERS (username, password, email, phone, address, role) VALUES
('admin', 'hashedpassword123', 'admin@example.com', '0123456789', 'Hà Nội', 1),
('user1', 'hashedpassword456', 'user1@example.com', '0987654321', 'TP Hồ Chí Minh', 0),
('user2', 'hashedpassword789', 'user2@example.com', '0912345678', 'Đà Nẵng', 0);

-- Thêm danh mục sách
INSERT INTO CATEGORY (name) VALUES
(N'Khoa học viễn tưởng'),
(N'Văn học'),
(N'Lịch sử'),
(N'Công nghệ thông tin');

-- Thêm sách
INSERT INTO BOOK (title, author, publishDate, categoryID, description, image, price, quantity) VALUES
(N'Dune', N'Frank Herbert', '1965-08-01', 1, N'Tiểu thuyết khoa học viễn tưởng nổi tiếng', 'dune.jpg', 250000, 10),
(N'1984', N'George Orwell', '1949-06-08', 2, N'Tiểu thuyết dystopia kinh điển', '1984.jpg', 180000, 15),
(N'Sapiens', N'Yuval Noah Harari', '2011-09-01', 3, N'Lịch sử loài người', 'sapiens.jpg', 300000, 8),
(N'Clean Code', N'Robert C. Martin', '2008-08-01', 4, N'Sách lập trình hướng dẫn viết code sạch', 'cleancode.jpg', 350000, 5);

-- Thêm sản phẩm vào giỏ hàng
INSERT INTO CART (userID, bookID, quantity) VALUES
(2, 1, 1), -- user1 thêm Dune vào giỏ
(2, 3, 2), -- user1 thêm Sapiens vào giỏ
(3, 4, 1); -- user2 thêm Clean Code vào giỏ

-- Thêm đơn hàng
INSERT INTO ORDERS (userID, orderDate, totalPrice, status) VALUES
(2, '2024-03-10 14:30:00', 750000, 1),
(3, '2024-03-11 09:15:00', 350000, 0);

-- Thêm chi tiết đơn hàng
INSERT INTO ORDER_DETAILS (orderID, bookID, quantity, price) VALUES
(1, 1, 1, 250000), -- user1 mua Dune
(1, 3, 2, 300000), -- user1 mua 2 cuốn Sapiens
(2, 4, 1, 350000); -- user2 mua Clean Code
