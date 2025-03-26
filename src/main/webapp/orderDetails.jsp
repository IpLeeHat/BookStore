<table>
    <tr>
        <th>Order ID</th>
        <th>Order Date</th>
        <th>Purchased Book</th>
        <th>Quantity</th>
        <th>Total Price ($)</th>
        <th>Status</th>
    </tr>
    <c:forEach var="order" items="${orders}">
        <tr>
            <td>${order.orderID}</td>
            <td>${order.orderDate}</td>
            <td>${order.purchasedBook}</td>
            <td>${order.quantity}</td>
            <td>${order.totalPrice}</td>
            <td>${order.status}</td>
        </tr>
    </c:forEach>
</table>
