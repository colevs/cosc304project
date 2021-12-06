<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
</head>
<body>
    <h1>Add Product</h1>
    <form action="addingProduct.jsp" method="GET">
        <div>
            <label for="proudctName">Product Name: </label>
            <input type="text" name="productName" required>
        </div>
        <div>
            <label for="productPrice">Product Price: </label>
            <input type="text" name="productPrice" required>            
        </div>
        <div>
            <label for="categoryID">Category ID: </label>
            <input type="number" name="categoryID" required min="1">                
        </div>
        <div>
            <label for="productDesc">Product Description: </label>
            <textarea name="productDesc" maxlength="1000"></textarea>
        </div>  
        <button type="submit">Submit</button>
        <button type="reset">Reset</button>
    </form>
</body>
</html>