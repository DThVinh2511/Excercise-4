<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<html>
<head>
    <title>Thêm hoặc sửa thông tin</title>
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
                        <a href="#">Trang chủ</a>
                    </li>
                    <li class="active">Quản lý khách hàng</li>
                    <li class="active">Thêm hoặc sửa thông tin khách hàng</li>
                </ul><!-- /.breadcrumb -->

            </div>

            <div class="page-content">
                <div class="page-header">
                    <h1>
                        Thông tin khách hàng
                    </h1>
                </div><!-- /.page-header -->
                <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                    <form:form modelAttribute="customerEdit" id="listForm" method="get">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form">
                                <div class="form-group">
                                    <label class="col-xs-3">Thêm tòa nhà</label>
                                    <div class="col-xs-9">
                                        <form:input path="fullName" class="form-control" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Số điện thoại</label>
                                    <div class="col-xs-9">
                                        <form:input path="phone" class="form-control" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Email</label>
                                    <div class="col-xs-9">
                                        <form:input path="email" class="form-control" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Tên công ty</label>
                                    <div class="col-xs-9">
                                        <form:input path="companyName" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3">Nhu cầu</label>
                                    <div class="col-xs-9">
                                        <form:input path="demand" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class = "col-xs-3">Tình trạng</label>
                                    <div class="col-xs-6">
                                        <form:select class="form-control" path="status" required="required">
                                            <form:option value="">---Chọn---</form:option>
                                            <form:options items="${Status}"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-3"></label>
                                    <div class="col-xs-9">
                                        <c:if test="${not empty customerEdit.id}">
                                            <button type="button" class="btn btn-primary" id="btnAddOrUpdateCustomer">Cập nhật</button>
                                            <button type="button" class="btn btn-primary" id="btnCancel">Hủy thao tác</button>
                                        </c:if>
                                        <c:if test="${empty customerEdit.id}">
                                            <button type="button" class="btn btn-primary" id="btnAddOrUpdateCustomer">Thêm</button>
                                            <button type="button" class="btn btn-primary" id="btnCancel">Hủy thao tác</button>
                                        </c:if>

                                    </div>
                                </div>
                                <form:hidden path="id" id="customerId"/>
                            </form>
                        </div>
                    </form:form>
                </div>
            </div><!-- /.page-content -->
            <c:forEach var="item" items="${transactionType}">
                <div class="col-xs-12">
                    <div class="col-sm-12">
                        <h3 class="header smaller lighter blue">${item.value}</h3>
                        <button class="btn btn-lg btn-primary" onclick="transactionType('${item.key}', ${customerEdit.id})" title="Thêm giao dịch với khách hàng">
                            <i class="orange ace-icon fa fa-location-arrow bigger-110"></i>Thêm
                        </button>
                    </div>

                    <c:if test="${item.key == 'CSKH'}">
                        <div class="col-xs-12">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Ngày tạo</th>
                                    <th>Người tạo</th>
                                    <th>Ngày sửa</th>
                                    <th>Người sửa</th>
                                    <th>Chi tiết giao dịch</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <c:forEach var="it" items="${transactionCSKH}">
                                    <tbody>
                                    <td>${it.createdDate}</td>
                                    <td>${it.createdBy}</td>
                                    <td>${it.modifiedDate}</td>
                                    <td>${it.modifiedBy}</td>
                                    <td>${it.note}</td>
                                    <td>
                                        <button class="btn btn-xs btn-info" title="Sửa thông tin giao dịch" onclick="updateTransaction(${it.id}, '${it.note}')">
                                            <i class="ace-icon fa fa-pencil bigger-120"></i>
                                        </button>
                                    </td>
                                    </tbody>
                                </c:forEach>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${item.key == 'DDX'}">
                        <div class="col-xs-12">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Ngày tạo</th>
                                        <th>Người tạo</th>
                                        <th>Ngày sửa</th>
                                        <th>Người sửa</th>
                                        <th>Chi tiết giao dịch</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <c:forEach var="it" items="${transactionDDX}">
                                    <tbody>
                                        <td>${it.createdDate}</td>
                                        <td>${it.createdBy}</td>
                                        <td>${it.modifiedDate}</td>
                                        <td>${it.modifiedBy}</td>
                                        <td>${it.note}</td>
                                        <td>
                                            <button class="btn btn-xs btn-info" title="Sửa thông tin giao dịch" onclick="updateTransaction(${it.id}, '${it.note}')">
                                                <i class="ace-icon fa fa-pencil bigger-120"></i>
                                            </button>
                                        </td>
                                    </tbody>
                                </c:forEach>
                            </table>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div><!-- /.main-content -->
</div>
<div class="modal fade" id="transactionModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="title-modal"></h4>
            </div>
            <div class="modal-body">
                <div class="form-group has-success">
                    <label for="transactionDetail" class="col-xs-12 col-sm-3 control-label no-padding-right">Chi tiết giao dịch</label>
                    <div class="col-xs-12 col-sm-9">
                        <span class="block input-icon input-icon-right">
                            <input class="width-100" id="transactionDetail" type="text">
                        </span>
                    </div>
                </div>
                <input type="hidden" id="customerId" name="customerId" value=""/>
                <input type="hidden" id="transactionCode" name="transactionCode" value=""/>
                <input type="hidden" id="transactionId" name="transactionId" value=""/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnAddOrUpdateTransaction"></button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
            </div>
        </div>
    </div>
</div>
<script>
    $('#btnAddOrUpdateCustomer').click(function() {
        let data = {};
        let formData = $('#listForm').serializeArray();
        $.each(formData, function(i, v){
            data['' + v.name + ""] = v.value;
        });
        if(data.fullName === '') {
            back("Bạn chưa nập họ tên.");
        } else if(data.phone === '') {
            back("Bạn chưa nhập số điện thoại.")
        } else {
            addOrUpdateCustomer(data);
        }
    });
    function back(text) {
        alert(text)
    }
    function addOrUpdateCustomer(data) {
        $.ajax({
            type: "POST",
            url: "/api/customer",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json',
            success: function(){
                alert("Thao tác thành công!");
                window.location.href = "/admin/customer-list";
            },
            error: function(respond) {
                console.log("failed");
                alert("Thao tác thất bại!");
                console.log(respond);
            }
        });
    }
    $("#btnCancel").click(function (){
        window.location.href = "/admin/customer-list";
    });
</script>
<script>
    function transactionType(code, customerId) {
        $('#transactionModal').modal();
        $('#customerId').val(customerId);
        $('#transactionCode').val(code);
        $('#title-modal').text("Thêm giao dịch");
        $('#transactionDetail').val("");
        $('#btnAddOrUpdateTransaction').text("Thêm");
    }
    function updateTransaction(id, note) {
        $('#transactionModal').modal();
        $('#transactionId').val(id);
        $('#title-modal').text("Sửa thông tin giao dịch");
        $('#transactionDetail').val(note);
        $('#btnAddOrUpdateTransaction').text("Cập nhật");
    }
    $('#btnAddOrUpdateTransaction').click(function (e){
        e.preventDefault();
        let data = {};
        data['customerId'] = $('#customerId').val();
        data['id'] = $('#transactionId').val();
        data['code'] = $('#transactionCode').val();
        data['note'] = $('#transactionDetail').val();
        if(data.note === '') {
            back("Bạn chưa nhập chi tiết giao dịch.");
        } else {
            addOrUpdateTransaction(data);
        }
    })
    function addOrUpdateTransaction(data) {
        $.ajax({
            type: "POST",
            url: "/api/customer/transaction",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json',
            success: function(respond){
                alert("Thao tác thành công!");
                location.reload(true);
            },
            error: function(respond) {
                console.log("failed");
                alert("Thao tác thất bại!");
                console.log(respond);
            }
        });
    }
</script>
</body>
</html>
