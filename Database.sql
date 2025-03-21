
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

INSERT INTO USERS (username, password, email, phone, address, role) VALUES
('admin', 'admin123', 'admin@example.com', '0123456789', N'Hà Nội', 1),
('user1', 'password1', 'user1@example.com', '0987654321', N'Hồ Chí Minh', 0),
('user2', 'password2', 'user2@example.com', '0971122334', N'Đà Nẵng', 0);


INSERT INTO CATEGORY (name) VALUES
(N'Tiểu thuyết'),
(N'Khoa học'),
(N'Truyện tranh'),
(N'Lịch sử'),
(N'Kinh tế');

INSERT INTO BOOK (title, author, publishDate, categoryID, description, image, price, quantity) VALUES
(N'Nhà giả kim', N'Paulo Coelho', '1995-06-15', 1, N'Một cuốn sách truyền cảm hứng', 'alchemist.jpg', 120000, 50),
(N'Sapiens: Lược sử loài người', N'Yuval Noah Harari', '2011-09-04', 2, N'Cuốn sách lịch sử về sự phát triển của con người', 'sapiens.jpg', 250000, 30),
(N'Dragon Ball Tập 1', N'Akira Toriyama', '1984-11-20', 3, N'Truyện tranh huyền thoại', 'dragonball1.jpg', 45000, 100),
(N'Việt Nam sử lược', N'Trần Trọng Kim', '1920-03-15', 4, N'Cuốn sách lịch sử Việt Nam nổi tiếng', 'vietnam_history.jpg', 150000, 20),
(N'Cha giàu cha nghèo', N'Robert Kiyosaki', '2000-04-01', 5, N'Cuốn sách về tư duy tài chính', 'richdad.jpg', 180000, 40);

INSERT INTO CART (userID, bookID, quantity) VALUES
(2, 1, 2),  -- User1 mua 2 cuốn "Nhà giả kim"
(2, 3, 1),  -- User1 mua 1 cuốn "Dragon Ball Tập 1"
(3, 5, 3);  -- User2 mua 3 cuốn "Cha giàu cha nghèo"

INSERT INTO ORDERS (userID, orderDate, totalPrice, status) VALUES
(2, '2025-03-10 14:30:00', 285000, 2),  -- User1 đã nhận hàng
(3, '2025-03-11 10:15:00', 540000, 1);  -- User2 đang giao hàng

INSERT INTO ORDER_DETAILS (orderID, bookID, quantity, price) VALUES
(1, 1, 2, 120000),  -- "Nhà giả kim" x2 trong đơn hàng 1
(1, 3, 1, 45000),   -- "Dragon Ball Tập 1" x1 trong đơn hàng 1
(2, 5, 3, 180000);  -- "Cha giàu cha nghèo" x3 trong đơn hàng 2
