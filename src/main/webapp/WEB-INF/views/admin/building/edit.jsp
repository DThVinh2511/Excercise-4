<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="BuildinEditURL" value="/admin/building-edit" />
<html>
<head>
    <title>Thêm hoặc sửa tòa nhà</title>
</head>
<body>
    <div class="main-content" id="main-container">
        <div class="main-content">
            <div class="main-content-inner">
                <div class="breadcrumbs" id="breadcrumbs">
                    <script type="text/javascript">
                        try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                    </script>

                    <ul class="breadcrumb">
                        <li>
                            <i class="ace-icon fa fa-home home-icon"></i>
                            <a href="<c:url value="/admin/home"/>">Trang chủ</a>
                        </li>
                        <li class="active">Quản lý tòa nhà</li>
                        <li class="active">Thêm hoặc sửa tòa nhà</li>
                    </ul><!-- /.breadcrumb -->
                </div>

                <div class="page-content">
                    <div class="page-header">
                        <h1>
                            Thêm hoặc sửa tòa nhà
                            <small>
                                <i class="ace-icon fa fa-angle-double-right"></i>
                                overview &amp; stats
                            </small>
                        </h1>
                    </div><!-- /.page-header -->
                    <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                        <form:form modelAttribute="buildingEdit" id="listForm" method="get">
                            <div class="col-xs-12">
                                <form class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <label class="col-xs-3">Thêm tòa nhà</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="text" id="name" name="name" class="form-control">--%>
                                            <form:input path="name" class="form-control" required="required"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class = "col-xs-3">Quận</label>
                                        <div class="col-xs-6">
                                            <form:select class="form-control" path="district" required="required">
                                                <form:option value="">---Chọn Quận---</form:option>
                                                <form:options items="${districts}"/>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Phường</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="text" id="ward" name="ward" class="form-control">--%>
                                            <form:input path="ward" class="form-control" required="required"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Đường</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="text" id="street" name="street" class="form-control">--%>
                                            <form:input path="street" class="form-control" required="required"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Kết cấu</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="text" id="structure" name="structure" class="form-control">--%>
                                            <form:input path="structure" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Số tầng hầm</label>
                                        <div class="col-xs-9">
                                            <form:input path="numberOfBasement" class="form-control"/>
                                                <%--                                        <input type="number" id="numberOfBasement" name="numberOfBasement" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Diện tích sàn</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="number" id="floorArea" name="floorArea" class="form-control">--%>
                                            <form:input path="floorArea" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Hướng</label>
                                        <div class="col-xs-9">
                                            <form:input path="direction" class="form-control"/>
                                                <%--                                        <input type="text" id="direction" name="direction" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Hạng</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="text" id="level" name="level" class="form-control">--%>
                                            <form:input path="level" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Diện tích thuê</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="text" id="rentArea" name="rentArea" class="form-control">--%>
                                            <form:input path="rentArea" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Giá thuê</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="number" id="rentPrice" name="rentPrice" class="form-control">--%>
                                            <form:input path="rentPrice" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Mô tả giá</label>
                                        <div class="col-xs-9">
                                            <form:input path="rentPriceDescription" class="form-control"/>
                                                <%--                                        <input type="text" id="rentPricedescription" name="rentPricedescription" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Phí dịch vụ</label>
                                        <div class="col-xs-9">
                                                <%--                                        <input type="number" id="serviceFee" name="serviceFee" class="form-control">--%>
                                            <form:input path="serviceFee" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Phí ô tô</label>
                                        <div class="col-xs-9">
                                            <form:input path="carFee" class="form-control"/>
                                                <%--                                        <input type="number" id="carFee" name="carFee" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Phí mô tô</label>
                                        <div class="col-xs-9">
                                            <form:input path="motoFee" class="form-control"/>
                                                <%--                                        <input type="number" id="motorbikeFee" name="motorbikeFee" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Phí ngoài giờ</label>
                                        <div class="col-xs-9">
                                            <form:input path="overtimeFee" class="form-control"/>
                                                <%--                                        <input type="number" id="overtimeFee" name="overtimeFee" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Tiền điện</label>
                                        <div class="col-xs-9">
                                            <form:input path="electricityFee" class="form-control"/>
                                                <%--                                        <input type="number" id="electricityFee" name="electricityFee" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Đặt cọc</label>
                                        <div class="col-xs-9">
                                            <form:input path="deposit" class="form-control"/>
                                                <%--                                        <input type="number" id="deposit" name="deposit" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Thanh toán</label>
                                        <div class="col-xs-9">
                                            <form:input path="payment" class="form-control"/>
                                                <%--                                        <input type="number" id="payment" name="payment" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Thời hạn thuê</label>
                                        <div class="col-xs-9">
                                            <form:input path="rentTime" class="form-control"/>
                                                <%--                                        <input type="number" id="rentTime" name="rentTime" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Thời gian trang trí</label>
                                        <div class="col-xs-9">
                                            <form:input path="decorationTime" class="form-control"/>
                                                <%--                                        <input type="text" id="decorationTime" name="decorationTime" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Tên quản lý</label>
                                        <div class="col-xs-9">
                                            <form:input path="managerName" class="form-control"/>
                                                <%--                                        <input type="text" id="managerName" name="managerName" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">SĐT quản lý</label>
                                        <div class="col-xs-9">
                                            <form:input path="managerPhone" class="form-control"/>
                                                <%--                                        <input type="text" id="managerPhoneNumber" name="managerPhoneNumber" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Phí mô giới</label>
                                        <div class="col-xs-9">
                                            <form:input path="brokerageFee" class="form-control"/>
                                                <%--                                        <input type="number" id="brokerageFee" name="brokerageFee" class="form-control">--%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Loại tòa nhà</label>
                                        <div class="col-xs-9">
                                            <form:checkboxes path="typeCode" items="${typeCodes}" required="required"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3">Ghi chú</label>
                                        <div class="col-xs-9">
                                            <form:input path="note" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 no-padding-right">Hình đại diện</label>
                                        <input class="col-sm-3 no-padding-right" type="file" id="uploadImage"/>
                                        <div class="col-sm-9">
                                            <c:if test="${not empty buildingEdit.avatar}">
                                                <c:set var="imagePath" value="/repository${buildingEdit.avatar}"/>
                                                <img src="${imagePath}" id="viewImage" width="300px" height="300px" style="margin-top: 50px">
                                            </c:if>
                                            <c:if test="${empty buildingEdit.avatar}">
                                                <img src="/admin/image/default.png" id="viewImage" width="300px" height="300px">
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3"></label>
                                        <div class="col-xs-9">
                                            <c:if test="${not empty buildingEdit.id}">
                                                <button type="button" class="btn btn-primary" id="btnAddOrUpdateBuilding">Cập nhật tòa nhà</button>
                                                <button type="button" class="btn btn-primary" id="btnCancel">Hủy thao tác</button>
                                            </c:if>
                                            <c:if test="${empty buildingEdit.id}">
                                                <button type="button" class="btn btn-primary" id="btnAddOrUpdateBuilding">Thêm tòa nhà</button>
                                                <button type="button" class="btn btn-primary" id="btnCancel">Hủy thao tác</button>
                                            </c:if>

                                        </div>
                                    </div>
                                    <form:hidden path="id" id="buildingId"/>
                                </form>
                            </div>
                        </form:form>
                    </div>
                </div><!-- /.page-content -->
            </div>
        </div><!-- /.main-content -->
    </div>
    <script>
        let imageBase64 = '';
        let imageName = '';
        $('#btnAddOrUpdateBuilding').click(function() {
            let data = {};
            let typeCode = [];
            let formData = $('#listForm').serializeArray();
            $.each(formData, function(i, v){
                if ('' !== imageBase64) {
                    data['imageBase64'] = imageBase64;
                    data['imageName'] = imageName;
                }
                if(v.name !== 'typeCode') {
                    data['' + v.name + ""] = v.value;
                }
                else {
                    typeCode.push(v.value);
                }
            });
            data['typeCode'] = typeCode;
            if(typeCode != '') {
                addOrUpdateBuilding(data);
            } else {
                back();
            }
        });
        function back() {
            window.location.href = "<c:url value="/admin/building-edit?typeCode=require"/>";
        }
        function addOrUpdateBuilding(data) {
            $.ajax({
                type: "POST",
                url: "/api/building",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: 'json',
                success: function(response){
                    alert("Bạn đã thao tác thành công")
                    window.location.href = "/admin/building-list";
                },
                error: function(respond) {
                    console.log("failed");
                    window.location.href = "<c:url value='/admin/building-edit??message=fail'/>";
                    console.log(respond);
                }
            });
        }
        $("#btnCancel").click(function (){
            window.location.href = "/admin/building-list";
        });
        $('#uploadImage').change(function (event) {
            var reader = new FileReader();
            var file = $(this)[0].files[0];
            reader.onload = function(e){
                imageBase64 = e.target.result;
                imageName = file.name; // ten hinh khong dau, khoang cach. Dat theo format sau: a-b-c
            };
            reader.readAsDataURL(file);
            openImage(this, "viewImage");
        });
        function openImage(input, imageView) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#' +imageView).attr('src', reader.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
