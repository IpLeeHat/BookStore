<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Book</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                flex-direction: column; /* 🔥 Đẩy tiêu đề xuống dưới tí */
            }
            h2 {
                text-align: center;
                font-size: 28px;
                color: #333;
                margin-bottom: 20px;
                margin-top: 100px; /* 🔥 ĐẨY XUỐNG THÊM 100PX CHO CHẮC KHỎI LẤP */
            }


            .form-container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 800px;
            }
            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            .full-width {
                grid-column: span 2;
            }
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }
            input, textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            textarea {
                height: 80px;
            }
            .button-group {
                display: flex;
                justify-content: space-between;
                grid-column: span 2;
                margin-top: 15px;
            }
            button {
                background-color: #28a745;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                flex: 1;
                margin-right: 5px;
            }
            button:hover {
                background-color: #218838;
            }
            .cancel-btn {
                text-align: center;
                padding: 10px;
                background: #dc3545;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .cancel-btn:hover {
                background: #c82333;
            }
        </style>
    </head>
    <body>
        <h2>➕ Add Book</h2> <!-- 🔥 Tiêu đề rõ ràng, đẩy xuống dưới tí -->
        <div class="form-container">
            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="addBook">

                <div><label>Title:</label> <input type="text" name="title" required></div>
                <div><label>Author:</label> <input type="text" name="author" required></div>
                <div><label>Translator:</label> <input type="text" name="translator"></div>
                <div><label>Supplier:</label> <input type="text" name="supplier"></div>
                <div><label>Publisher:</label> <input type="text" name="publisher"></div>
                <div><label>Publish Year:</label> <input type="number" name="publishYear" required></div>
                <div><label>Language:</label> <input type="text" name="language" required></div>
                <div><label>Weight (grams):</label> <input type="number" name="weight"></div>
                <div><label>Dimensions (WxHxD):</label> <input type="text" name="dimensions"></div>
                <div><label>Page Count:</label> <input type="number" name="pageCount" required></div>
                <div><label>Format:</label> <input type="text" name="format"></div>
                <div><label>SKU:</label> <input type="text" name="sku"></div>
                <div><label>Category ID:</label> <input type="number" name="categoryID" required></div>
                <div class="full-width"><label>Description:</label> <textarea name="description" required></textarea></div>
                <div class="full-width"><label>Image URL:</label> <input type="text" name="image" required></div>
                <div><label>Price:</label> <input type="number" step="0.01" name="price" required></div>
                <div><label>Quantity:</label> <input type="number" name="quantity" required></div>
                <div><label>Review Count:</label> <input type="number" name="reviewCount"></div>
                <div><label>Purchase Count:</label> <input type="number" name="purchaseCount"></div>

                <div class="button-group">
                    <button type="submit">➕ Add Book</button>
                    <a href="admin.jsp" class="cancel-btn">❌ Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
