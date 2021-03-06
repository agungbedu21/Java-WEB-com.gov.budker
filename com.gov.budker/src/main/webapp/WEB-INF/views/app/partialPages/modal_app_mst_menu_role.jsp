<%-- 
    Created on : 10 agustus 2017, 1:21:28 PM
    Author     : Agung Abdurohman
--%>

<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- MODAL ADD -->
<script type="text/javascript">
    $('.sel2').select2();
</script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<div data-backdrop="static" class="modal fade in" id="modalMenuRole" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg-50">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    x
                </button>
                <h1 style="font-weight: 500;color: #000;" class="modal-title" id="myModalLabel">
                    <c:if test="${data.menuRoleId == null}">Tambah </c:if>
                    <c:if test="${data.menuRoleId != null}">Ubah </c:if>
                    Menu Role
                    <c:if test="${data.menuRoleId == null}"> Baru</c:if>
                </h1>
            </div>
            <div class="modal-body">
                <form id="formMenuRole">
                    <input type="hidden" id="menuRoleId" name="menuRoleId" value="${data.menuRoleId}">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label><b>Pilih Role</b></label>
                                <select style="width: 100%" name="roleId" id="roleId" class="form-control sel2">
                                    <option value="">-- Pilih Role --</option>
                                    <c:forEach items="${dataRole}" var="data">
                                        <option value="${data.roleId}">${data.roleName} </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label><b>Pilih Menu</b></label>
                                <select style="width: 100%" name="menuId[]" id="menuId" multiple
                                        class="form-control sel2">
                                    <option value="">-- Pilih Menu --</option>
                                    <c:forEach items="${dataMenu}" var="data">
                                        <option value="${data.menuId}">${data.menuName} </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="status"><b>Status</b></label>
                                <select name="status" id="status" class="form-control">
                                    <option value="1"
                                            <c:if test="${data.status == 1}">selected</c:if>>Aktif
                                    </option>
                                    <option value="0"
                                            <c:if test="${data.status == 0}">selected</c:if>>Tidak Aktif
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-border-blue draft" data-dismiss="modal">
                    Batal
                </button>
                <button onclick="validate()" type="button" class="btn btn-primary">
                    Submit
                </button>
            </div>
        </div> <!--/.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- END MODAL ADD -->
<script>
    var modalFunction = function () {
        $('#modalMenuRole')
            .bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    "menuId[]": {
                        validators: {
                            notEmpty: {}
                        }
                    },
                    roleId: {
                        validators: {
                            notEmpty: {}
                        }
                    },
                    status: {
                        validators: {
                            notEmpty: {}
                        }
                    }
                }
            })
            .off('success.form.bv')
            .on('success.form.bv', function (e) {
                e.preventDefault();
                $(".loading").show();
                submit();
            });
    };

    function validate() {
        $('#modalMenuRole').bootstrapValidator('validate');
    }

    function submit() {
        var data = $("#formMenuRole").serializeJSON();
        var dataString = JSON.stringify(data);
        var idData = $("#menuRoleId").val();
        var is = null;
        if (idData === "") {
            is = 1;
        } else {
            is = 2;
        }
        $.ajax({
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            'type': 'POST',
            'url': APP_PATH + '/app/menurole/saveOrUpdate/' + is,
            'data': dataString,
            'dataType': 'json',
            success: function (hasil) {
                if (hasil.status) {
                    $(".loading").hide();
                    $('#modalMenuRole').modal('toggle');
                    otable.ajax.reload(null, false);
                    showSmallInfo("Informasi", "Data berhasil disimpan", 5000);
                } else {
                    $(".loading").hide();
                    showSmallError("Kesalahan", "Data gagal disimpan", 5000);
                }
            }
        });
    }


</script>
<script src="${pageContext.request.contextPath}/resources/custom/js/portal/common.js"></script>