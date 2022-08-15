<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Cart</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.css">

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>


    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">

</head>

<body>

<jsp:include page="view/header.jsp"></jsp:include>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li><a href="Home">Home</a></li>
                    <li class="active">Cart</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- /BREADCRUMB -->
<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <c:if test='${mess!=null&&mess!=""}'>
            <div class="mb-3">
                <div class="alert alert-danger" role="alert">${mess}</div>
            </div>
        </c:if>
        <div class="row">
            <form action="checkout" method="post">
                <div class="col-md-7">
                    <!-- Billing Details -->
                    <div class="billing-details">
                        <div class="section-title">
                            <h3 class="title">DELIVERY ADDRESS</h3>
                        </div>
                        <div class="mb-3">
                            <input class="form-control" type="text" name="name" placeholder="name">
                        </div>
                        <div class="mb-3">
                            <input class="form-control" type="email" name="email" placeholder="Email">
                        </div>
                        <div class="mb-3">
                            <input class="form-control" type="tel" name="phone" placeholder="Number phone">
                        </div>
                        <select id="city" class="form-select mb-3" name="city">
                            <option value="" selected="selected">-- Province/ City --</option>

                        </select>
                        <select id="district" class="form-select mb-3" name="district">
                        </select>
                        <div class="mb-3">
                            <input class="form-control" type="text" name="address" placeholder="Building, Street...">
                        </div>
                    </div>
                    <!-- /Billing Details -->
                </div>
                <!-- Order Details -->
                <div class="col-md-5 order-details border-r10">
                    <div class="section-title text-center">
                        <h3 class="title">Payment</h3>
                    </div>
                    <div class="order-summary">
                        <div class="order-col">
                            <div><strong>PRODUCT</strong></div>
                            <div><strong>TOTAL</strong></div>
                        </div>
                        <div class="order-products">
                            <div class="order-col">
                                <div>1x Sản phẩm 1</div>
                                <div>120.000VND</div>
                            </div>
                            <div class="order-col">
                                <div>2x Sản phẩm 2</div>
                                <div>120.000VND</div>
                            </div>
                        </div>
                        <div class="order-col">
                            <div>SHIPPING COST</div>
                            <div><strong>Free</strong></div>
                        </div>
                        <div class="order-col">
                            <div><strong>TOTAL MONEY</strong></div>
                            <div><strong class="order-total">240.000VND</strong></div>
                        </div>
                    </div>
                    <button type="submit" class="primary-btn order-submit">Payment</button>
                </div>
            </form>

            <!-- /Order Details -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->
<!-- FOOTER -->
<jsp:include page="view/footer.jsp"></jsp:include>
<!-- /FOOTER -->

<!-- jQuery Plugins -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="js/bootstrap.bundle.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/main.js"></script>
<script src="js/cartJS.js"></script>
<script src="js/cart_controller.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    var Parameter = {
        url: './data/vietnam.json',//Đường dẫn đến file chứa dữ liệu hoặc api do backend cung cấp
        method: 'GET', //do backend cung cấp
        responseType: 'application/json', //kiểu Dữ liệu trả về do backend cung cấp
    }
    //gọi ajax = axios => nó trả về cho chúng ta là một promise
    var promise = axios(Parameter);
    //Xử lý khi request thành công
    promise.then(function (result) {
        renderCity(result.data);
    });
    promise.then(function (result) {
        console.log(result.data)
    });
    var citis = document.getElementById("city");
    var districts = document.getElementById("district");

    function renderCity(data) {
        for (const x of data) {
            citis.options[citis.options.length] = new Option(x.Name, x.Name);
        }
        citis.onchange = function () {
            district.length = 0;

            if (this.value != "") {
                const result = data.filter(n => n.Name === this.value);

                for (const k of result[0].Districts) {
                    district.options[district.options.length] = new Option(k.Name, k.Name);
                }
            }
        };
    }
</script>
</body>

</html>