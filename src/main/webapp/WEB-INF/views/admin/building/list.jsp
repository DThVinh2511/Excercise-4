<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<c:url var="formUrl" value="/admin/building-list"/>
<html>
<head>
    <title>Danh sách tòa nhà</title>
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
                            <a href="<c:url value="/admin/home"/>">TRang chủ</a>
                        </li>
                        <li class="active">Quản lý tòa nhà</li>
                    </ul><!-- /.breadcrumb -->

                </div>

                <div class="page-content">
                    <div class="page-header">
                        <h1>
                            Danh sách tòa nhà
                            <small>
                                <i class="ace-icon fa fa-angle-double-right"></i>
                                overview &amp; stats
                            </small>
                        </h1>
                    </div><!-- /.page-header -->
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="widget-box ui-sortable-handle">
                                <div class="widget-header">
                                    <h5 class="widget-title">Tìm Kiếm</h5>

                                    <div class="widget-toolbar">
                                        <a href="#" data-action="collapse">
                                            <i class="ace-icon fa fa-chevron-up"></i>
                                        </a>
                                    </div>
                                </div>

                                <div class="widget-body" style="display: block; font-family: 'Times New Roman', Times, serif;">
                                    <div class="widget-main">
                                        <form:form action="/admin/building-list" id="listForm" method="get" modelAttribute="modelSearch">
                                            <div class="row">
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-6">
                                                            <label class = "name">Tên tòa nhà</label>
<%--                                                            <input type="text" class="form-control" value="${modelSearch.name}" name="name">--%>
                                                            <form:input path="name" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <label class = "name">Diện tích sàn</label>
<%--                                                            <input type="number" class="form-control" name="floorArea" value="">--%>
                                                            <form:input path="floorArea" class="form-control"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-2">
                                                            <label class = "name">Quận</label>
                                                            <form:select class="form-control" path="district">
                                                                <form:option value="">---Chọn Quận---</form:option>
                                                                <form:options items="${districts}"/>
                                                            </form:select>
                                                        </div>
                                                        <div class="col-xs-5">
                                                            <label class = "name">Phường</label>
<%--                                                            <input type="text" class="form-control" name="ward" value="">--%>
                                                            <form:input path="ward" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-5">
                                                            <label class = "name">Đường</label>
<%--                                                            <input type="text" class="form-control" name="street" value="">--%>
                                                            <form:input path="street" class="form-control"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-4">
                                                            <label class = "name">Số tầng hầm</label>
<%--                                                            <input class="form-control" type="text" name="numberOfBasement" value="">--%>
                                                            <form:input path="numberOfBasement" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <label class = "name">Hướng</label>
<%--                                                            <input type="text" class="form-control" name="direction" value="">--%>
                                                            <form:input path="direction" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <label class = "name">Hạng</label>
<%--                                                            <input type="number" class="form-control" name="level" value="">--%>
                                                            <form:input path="level" class="form-control"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-3">
                                                            <label class = "name">Diện tích từ</label>
<%--                                                            <input class="form-control" type="text" name="areaFrom" value="">--%>
                                                            <form:input path="areaFrom" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-3">
                                                            <label class = "name">Diện tích đến</label>
<%--                                                            <input type="text" class="form-control" name="areaTo" value="">--%>
                                                            <form:input path="areaTo" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-3">
                                                            <label class = "name">Giá thuê từ</label>
<%--                                                            <input type="number" class="form-control" name="rentPriceFrom" value="">--%>
                                                            <form:input path="rentPriceFrom" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-3">
                                                            <label class = "name">Giá thuê đến</label>
<%--                                                            <input type="number" class="form-control" name="rentPriceTo" value="">--%>
                                                            <form:input path="rentPriceTo" class="form-control"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-5">
                                                            <label class = "name">Tên quản lý</label>
<%--                                                            <input type="text" class="form-control" name="managerName" value="">--%>
                                                            <form:input path="managerName" class="form-control"/>
                                                        </div>
                                                        <div class="col-xs-5">
                                                            <label class = "name">SĐT quản lý</label>
<%--                                                            <input type="text" class="form-control" name="managerPhone" value="">--%>
                                                            <form:input path="managerPhone" class="form-control"/>
                                                        </div>
                                                        <security:authorize access="hasRole('MANAGER')">
                                                            <div class="col-xs-2">
                                                                <label class = "name">Nhân viên</label>
                                                                <form:select class="form-control" path="staffId">
                                                                    <form:option value="">---Chọn Nhân viên---</form:option>
                                                                    <form:options items="${listStaffs}"/>
                                                                </form:select>
                                                            </div>
                                                        </security:authorize>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-6">
                                                            <form:checkboxes path="typeCode" items="${typeCodes}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12">
                                                        <div class="col-xs-6">
                                                            <button type="button" class="btn btn-danger" id="btnSearchBuilding">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"></path>
                                                                </svg>
                                                                Tím Kiếm
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form:form>

                                    </div>
                                </div>
                                <div class="pull-right">
                                    <a href="/admin/building-edit">
                                        <button class = "btn btn-info" title="Thêm tòa nhà">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                                                <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                                <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                                <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                            </svg>
                                        </button>
                                    </a>
                                    <security:authorize access="hasRole('MANAGER')">
                                        <button class="btn btn-danger" title="Xóa tòa nhà" id="btnDeleteBuilding">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                                                <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                                <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                                <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                            </svg>
                                        </button>
                                    </security:authorize>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Danh sách bảng -->
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="table-responsive">
                                <display:table name="model.listResult" cellspacing="0" cellpadding="0"
                                               requestURI="${formUrl}" partialList="true" sort="external"
                                               size="${model.totalItems}" defaultsort="2" defaultorder="ascending"
                                               id="tableList" pagesize="${model.maxPageItems}"
                                               export="false"
                                               class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                               style="margin: 3em 0 1.5em;">
                                    <display:column title="<fieldset class=''>
                                                           <input type='checkbox' id='checkAll' class='check-box-element'>
                                                           </fieldset>" class="center select-cell"
                                                    headerClass="center select-cell">
                                        <fieldset>
                                            <input type="checkbox" name="checkList" value="${tableList.id}"
                                                   id="checkbox_${tableList.id}" class="check-box-element"/>
                                        </fieldset>
                                    </display:column>
                                    <display:column headerClass="text-left" property="name" title="Tên"/>
                                    <display:column headerClass="text-left" property="address" title="Địa chỉ"/>
                                    <display:column headerClass="text-left" property="numberOfBasement" title="Số tầng hầm"/>
                                    <display:column headerClass="text-left" property="managerName" title="Tên quản lý"/>
                                    <display:column headerClass="text-left" property="managerPhone" title="SĐT quản lý"/>
                                    <display:column headerClass="text-left" property="floorArea" title="Diện tích sàn"/>
                                    <display:column headerClass="text-left" property="rentArea" title="Diện tích thuê"/>
                                    <display:column headerClass="text-left" property="emptyArea" title="Diện tích trống"/>
                                    <display:column headerClass="text-left" property="serviceFee" title="Phí dịch vụ"/>
                                    <display:column headerClass="col-actions" title="Thao tác">
                                        <div class="hidden-sm hidden-xs btn-group">
                                            <security:authorize access="hasRole('MANAGER')">
                                                <button class="btn btn-xs btn-success" title="Giao tòa nhà" onclick="assingmentBuilding(${tableList.id})">
                                                    <i class="ace-icon fa fa-check bigger-120"></i>
                                                </button>
                                            </security:authorize>
                                            <a class="btn btn-xs btn-info" title="Sửa tòa nhà" href="/admin/building-edit-${tableList.id}">
                                                <i class="ace-icon fa fa-pencil bigger-120"></i>
                                            </a>
                                            <security:authorize access="hasRole('MANAGER')">
                                                <button class="btn btn-xs btn-danger" title="Xóa tòa nhà" onclick="deleteBuilding(${tableList.id})">
                                                    <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                                </button>
                                            </security:authorize>
                                        </div>
                                    </display:column>
                                </display:table>
                            </div>
                        </div>
                    </div>
                    <!-- End Danh sách bảng -->
                </div><!-- /.page-content -->
            </div>
        </div><!-- /.main-content -->
    </div><!-- /.main-container -->
    <div class="modal fade" id="assingmentBuildingModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Danh sách nhân viên</h4>
                </div>
                <div class="modal-body">
                    <table id="staff-list" class="table table-striped table-bordered table-hover center" style="margin: 1.5em 0 1.5em;">
                        <thead>
                        <tr>
                            <th class="center">
                                Chọn
                            </th>
                            <th class="center">Tên nhân viên</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <input type="hidden" id="buildingId" name="buildingId" value=""/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btnAssingmentBuildingModal">Giao tòa nhà</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function assingmentBuilding(buildingId) {
            $('#assingmentBuildingModal').modal();
            loadStaff(buildingId);
            $('#buildingId').val(buildingId);
        }
        function loadStaff(buildingId) {
            $.ajax({
                type: "GET",
                url: "/api/building/" + buildingId + "/staffs" ,
                // data: JSON.stringify(data),
                contentType: "application/json",
                dataType: 'json',
                success: function(response){
                    let row = "";
                    $.each(response.data, function (index, item){
                        row += '<tr>';
                        row += '<td class="text-center"><input type="checkbox" id="checkbox_ + ' + item.staffId + '"  value= "' + item.staffId + '" class="check-box-element" '+ item.checked + ' /></td>';
                        row += '<td class="text-center">' + item.fullName + '</td>';
                        row += '</tr>'
                    });
                    $('#staff-list tbody').html(row);
                    console.info("success");
                },
                error: function(respond) {
                    console.log("failed");
                    window.location.href = "<c:url value="/admin/building-list?message=false"/>";
                    console.log(respond);
                }
            });
        }
        $('#btnAssingmentBuildingModal').click((e) => {
            e.preventDefault();
            let data = {};
            data['id'] = $('#buildingId').val();
            let staffs = $('#staff-list').find('tbody input[type = checkbox]:checked').map(function() {
                return $(this).val();
            }).get();
            data['staffs'] = staffs;
            addAssignment(data);
        });
        function deleteBuilding(id) {
            let buildingId = [id];
            deleteBuildings(buildingId);
        };
        function addAssignment(data) {
            $.ajax({
                type: "POST",
                url: "/api/building/staffs",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function(response){
                    alert("Bạn đã cập nhật thành công");
                },
                error: function(respond) {
                    console.log("failed");
                    alert("Bạn đã cập nhật thất bại");
                    console.log(respond);
                }
            });
        }

        $('#btnDeleteBuilding').click(function (e) {
            e.preventDefault();
            let buildingIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            deleteBuildings(buildingIds);
        });
        function deleteBuildings(data) {
            $.ajax({
                type: "Delete",
                url: "/api/building/" + data,
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function(response){
                    alert("Bạn đã xóa thành công.")
                    location.reload(true);
                },
                error: function(respond) {
                    console.log("failed");
                    window.location.href = "<c:url value="/admin/building-list?message=false"/>";
                    console.log(respond);
                }
            });
        }
    </script>
    <script>
        $('#btnSearchBuilding').click(function (e) {
            e.preventDefault();
            $('#listForm').submit();
        });
    </script>
</body>
</html>
