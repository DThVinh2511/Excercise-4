<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<html>
<head>
    <title>Quản lý khách hàng</title>
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
          <li class="active">Quản lý khách hàng</li>
        </ul><!-- /.breadcrumb -->

      </div>

      <div class="page-content">
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
                  <form:form action="/admin/customer-list" id="listForm" method="get" modelAttribute="modelSearch">
                    <div class="row">
                      <div class="form-group">
                        <div class="col-xs-12">
                          <div class="col-xs-4">
                            <label class = "name">Tên khách hàng</label>
                            <form:input path="fullName" class="form-control"/>
                          </div>
                          <div class="col-xs-4">
                            <label class = "name">Số điện thoại</label>
                            <form:input path="phone" class="form-control"/>
                          </div>
                          <div class="col-xs-4">
                            <label class = "name">Email</label>
                            <form:input path="email" class="form-control"/>
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-xs-12">
                          <security:authorize access="hasRole('MANAGER')">
                            <div class="col-xs-4">
                              <label class = "name">Chọn nhân viên</label>
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
                            <button type="button" class="btn btn-danger btn-sm" id="btnSearchCustomer">
                              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
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
                <a href="/admin/customer-edit">
                  <button class = "btn btn-primary" title="Thêm khách hàng">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-add" viewBox="0 0 16 16">
                      <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                      <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
                    </svg>
                  </button>
                </a>
                <security:authorize access="hasRole('MANAGER')">
                  <button class="btn btn-danger" title="Xóa khách hàng" id="btnDeleteCustomer">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-dash" viewBox="0 0 16 16">
                      <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                      <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
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
                <display:column headerClass="text-left" property="fullName" title="Tên khách hàng"/>
                <display:column headerClass="text-left" property="phone" title="Số điện thoại"/>
                <display:column headerClass="text-left" property="email" title="Email"/>
                <display:column headerClass="text-left" property="demand" title="Nhu cầu"/>
                <display:column headerClass="text-left" property="createdBy" title="Người thêm"/>
                <display:column headerClass="text-left" property="createdDate" title="Ngày thêm"/>
                <display:column headerClass="text-left" property="status" title="Tình trạng"/>
                <display:column headerClass="col-actions" title="Thao tác">
                  <div class="hidden-sm hidden-xs btn-group">
                    <security:authorize access="hasRole('MANAGER')">
                      <button class="btn btn-xs btn-success" title="Người chăm sóc khách hàng" onclick="assingmentCustomer(${tableList.id})">
                        <i class="ace-icon fa fa-check bigger-120"></i>
                      </button>
                    </security:authorize>
                    <a class="btn btn-xs btn-info" title="Sửa thông tin khách haàng" href="/admin/customer-edit-${tableList.id}">
                      <i class="ace-icon fa fa-pencil bigger-120"></i>
                    </a>
                    <security:authorize access="hasRole('MANAGER')">
                      <button class="btn btn-xs btn-danger" title="Xóa thông tin khách hàng" onclick="deleteCustomer(${tableList.id})">
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
<div class="modal fade" id="assingmentCustomerModal" role="dialog">
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
        <input type="hidden" id="customerId" name="customerId" value=""/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnAssingmentCustomerModal">Cập nhật</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
      </div>
    </div>
  </div>
</div>

<script>
  $('#btnSearchCustomer').click(function (e) {
    e.preventDefault();
    $('#listForm').submit();
  });
</script>
<script>
  function assingmentCustomer(customerId) {
    $('#assingmentCustomerModal').modal();
    loadStaff(customerId);
    $('#customerId').val(customerId);
  }
  function loadStaff(customerId) {
    $.ajax({
      type: "GET",
      url: "/api/customer/" + customerId + "/staffs" ,
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
      },
      error: function(respond) {
        console.log("failed");
        window.location.href = "<c:url value="/admin/customer-list?message=false"/>";
        console.log(respond);
      }
    });
  }
  $('#btnAssingmentCustomerModal').click((e) => {
    e.preventDefault();
    let data = {};
    data['id'] = $('#customerId').val();
    let staffs = $('#staff-list').find('tbody input[type = checkbox]:checked').map(function() {
      return $(this).val();
    }).get();
    data['staffs'] = staffs;
    addAssignment(data);
  });
  function addAssignment(data) {
    $.ajax({
      type: "POST",
      url: "/api/customer/staffs",
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "JSON",
      success: function(respond){
        alert("Bạn đã cập nhật thành công");
      },
      error: function(respond) {
        alert("Bạn đã cập nhật thất bại");
        console.log(respond);
      }
    });
  }
  function deleteCustomer(id) {
    let customerId = [id];
    deleteCustomers(customerId);
  }
  $('#btnDeleteCustomer').click(function (e) {
    e.preventDefault();
    let customerIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function(){
      return $(this).val();
    }).get();
    deleteCustomers(customerIds);
  });
  function deleteCustomers(data) {
    $.ajax({
      type: "Delete",
      url: "/api/customer/" + data,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "JSON",
      success: function(response){
        alert("Bạn đã xóa thành công");
        location.reload(true);
      },
      error: function(respond) {
        console.log("failed");
        window.location.href = "<c:url value="/admin/customer-list?message=false"/>";
        console.log(respond);
      }
    });
  }
</script>
</body>
</html>
