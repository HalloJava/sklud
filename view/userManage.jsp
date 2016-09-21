<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/9/1 0001
  Time: 上午 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/commons/common/taglibs.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>用户管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" rel="stylesheet" href="${staticf}/css/bootstrap-table.css">
    <script type="text/javascript" src="${staticf}/javascript/bootstrap-table.js"></script>
    <script type="text/javascript" src="${staticf}/javascript/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="${staticf}/javascript/editTable.js"></script>
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="block-flat">
            <div class="header">
                <h3>用户列表</h3>
            </div>
            <div class="content">
                <div class="bs-example" data-example-id="hoverable-table">
                        <table class="table table-hover" id="tbd">
                        <thead>
                            <tr>
                                <th>用户名</th>
                                <th>身份</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="editable">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--<form class="form-horizontal form-bordered form-row-strippe" action="" data-toggle="validator"--%>
          <%--enctype="multipart/form-data">--%>
        <%--<div class="modal-body">--%>
            <%--<div class="row">--%>
                <%--<div class="col-md-12">--%>
                    <%--<div class="form-group"><label class="control-label col-md-3">用户名</label>--%>
                        <%--<div class="col-md-9"><input id="Name" name="Name" type="text" class="form-control"--%>
                                                     <%--placeholder="名称..."/></div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-12">--%>
                    <%--<div class="form-group"><label class="control-label col-md-3">角色</label>--%>
                        <%--<div class="col-md-9">--%>
                            <%--<c:forEach var="role" items="roles">--%>
                                <%--<input type="checkbox" name="role" value=\''+${role.rolename}+'\'/>${role.rolename}--%>
                            <%--</c:forEach>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-12">--%>
                    <%--<div class="form-group"><label class="control-label col-md-3">密码</label>--%>
                        <%--<div class="col-md-9"><input type="password" class="form-control"/></div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-md-12">--%>
                    <%--<div class="form-group"><label class="control-label col-md-3">确认密码</label>--%>
                        <%--<div class="col-md-9"><input type="password" class="form-control"/></div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</form>--%>


    <!-- system modal start -->
    <div id="ycf-alert" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"><i class="fa fa-exclamation-circle"></i> [Title]</h4>
                </div>
                <div class="modal-body ">
                    <p><h4><strong>[Message]</strong></h4></p>
                </div>
                <div class="modal-footer" >
                    <button id="submit" type="submit" class="btn btn-primary ok1">[BtnOk]</button>
                    <button type="button" class="btn btn-default cancel" data-dismiss="modal">[BtnCancel]</button>
                </div>
            </div>
        </div>
    </div>
    <!-- system modal end -->

    <script>
        ;
        $(function () {
            window.Modal = function () {
                var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
                var alr = $("#ycf-alert");
                var ahtml = alr.html();

                //关闭时恢复 modal html 原样，供下次调用时 replace 用
                //var _init = function () {
                //	alr.on("hidden.bs.modal", function (e) {
                //		$(this).html(ahtml);
                //	});
                //}();

                /* html 复原不在 _init() 里面做了，重复调用时会有问题，直接在 _alert/_confirm 里面做 */


                var _alert = function (options) {
                    alr.html(ahtml);	// 复原
                    alr.find('.ok').removeClass('btn-success').addClass('btn-primary');
                    alr.find('.cancel').hide();
                    _dialog(options);

                    return {
                        on: function (callback) {
                            if (callback && callback instanceof Function) {
                                alr.find('.ok').click(function () { callback(true) });
                            }
                        }
                    };
                };

                var _confirm = function (options) {
                    alr.html(ahtml); // 复原
                    alr.find('.ok').removeClass('btn-primary').addClass('btn-success');
                    alr.find('.cancel').show();
                    _dialog(options);

                    return {
                        on: function (callback) {
                            if (callback && callback instanceof Function) {
                                alr.find('.ok1').click(function () { callback(true) });
//                                alr.find('.cancel').click(function () { callback(false) });
                            }
                        }
                    };
                };

                var _dialog = function (options) {
                    var ops = {
                        msg: "提示内容",
                        title: "操作提示",
                        btnok: "确定",
                        btncl: "取消"
                    };

                    $.extend(ops, options);


                    var html = alr.html().replace(reg, function (node, key) {
                        return {
                            Title: ops.title,
                            Message: ops.msg,
                            BtnOk: ops.btnok,
                            BtnCancel: ops.btncl
                        }[key];
                    });

                    alr.html(html);
                    alr.modal({
                        width: 500,
                        backdrop: 'static'
                    });
                }

                return {
                    alert: _alert,
                    confirm: _confirm
                }

            }();
        });
    </script>

    <script>
        $(document).ready(function(){
            userData();
        });
    </script>
    <script>
        function userData() {
            $("#tbd").bootstrapTable('destroy');
            var requestUrl = __base_url__ + "userData";
            $("#tbd").bootstrapTable({
                url: requestUrl,     //请求后台的URL（*）
                method: 'POST',           //请求方式（*）
                dataType: "json",
                pagination: true,          //是否显示分页（*）
                sidePagination: "client",  //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1,            //初始化加载第一页，默认第一页
                pageSize: 10,            //每页的记录行数（*）
                pageList: [10, 25, 50, 100],    //可供选择的每页的行数（*）
                clickToSelect: true,        //是否启用点击选中行
                sortable: true,
                sortOrder: "desc",          //排序方式
                columns: [{
                    title: '用户名',
                    field: 'mobile',
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '身份',
                    field: 'rolename',
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '操作',
//                    field: 'id',
                    align: 'center',
                    valign: 'middle',
                    formatter:function(value,row,index){
                        var a = "<span style='cursor:pointer' title='添加' class='glyphicon glyphicon-plus' onclick='plus()'></span>&nbsp;";
                        var b = "<span style='cursor:pointer' title='编辑' id='editt' class='glyphicon glyphicon-edit editt' onclick='edit(\""+row.roleId+"\" ,\""+row.mobile+"\")'></span>&nbsp;";
//                        var c = "<span style='cursor:pointer' title='删除' class='glyphicon glyphicon-remove' onclick='dele()'></span>&nbsp;";
                        var d = "<span style='cursor:pointer' title='重置密码' class='glyphicon glyphicon-refresh resetPass'></span>"
                        return a+b+d;
                    }
                }],
                onLoadSuccess: function(){  //加载成功时执行
                    jQuery(function($){
//                        $(".editt").click(function(){
//                            var name = $(this).parent().parent().children("td").get(0).innerHTML;
//                            edit(name);
//                        });
                        $(".resetPass").click(function () {
                            var name = $(this).parent().parent().children("td").get(0).innerHTML;
                            resetPassword(name);
                        })
                    });
//                    editLastTable();
                },
            })
        }
    </script>
    <script>
        function plus(){
//            $.ajax({
//                url:__base_url__ + 'roleData',
//                dataType:'json',
//                type:'POST',
//                success:function (result) {
//                    console.log(result.rolename);
                    Modal.confirm({
                        msg: '<div class="modal-body"> <div class="row"> <div class="col-md-12"> <div class="form-group"> <label class="control-label col-md-3">用户名</label><div class="col-md-9"> <input id="name" name="Name" type="text" class="form-control" placeholder="名称..."/><span id="nameTip" style="display:none;color:red;"></span></div> </div> </div> <div class="col-md-12"><div class="form-group"> <label class="control-label col-md-3">角色</label><div class="col-md-9"><c:forEach var="role" items="${roles}"> <input id="rolename" type="checkbox" name="role" value="${role.id}" />${role.rolename}</c:forEach> <br><span id="rolenameTip" style="display:none;color:red;"></span></div> </div> </div> <div class="col-md-12"> <div class="form-group"> <label class="control-label col-md-3">新密码</label> <div class="col-md-9"> <input id="newPassword" type="password" class="form-control"/><span id="newPasswordTip" style="display:none;color:red;"></span></div> </div> </div> <div class="col-md-12"> <div class="form-group"> <label class="control-label col-md-3">确认密码</label> <div class="col-md-9"> <input id="rePassword" type="password" class="form-control" /> <span id="rePasswordTip" style="display:none;color:red;"></span></div> </div> </div></div> </div>',
                        title: '添加信息',
                        btncl:'取消',
                        btnok: '确定'
                    })
                            .on(function(e){
                                var error = false;
                                var name = $("#name").val();
                                var newPassword = $("#newPassword").val();
                                var rePassword = $("#rePassword").val();
                                var rolename = $("input:checkbox[name='role']:checked").map(function(index,elem) {
                                    return $(elem).val();
                                }).get().join(',');
//                                alert("选中的checkbox的值为："+rolename);
                                    $("#name").blur(function () {
                                        if(name=='') {
                                            showError('name', "用户名不能为空");
                                            error = true;
                                            return;
                                        }else {
//                                            $("#name").css({"border-color": "green"});
                                            $("#nameTip").css({"display": "none"});
                                        }
                                    });
                                $("#newPassword").blur(function () {
                                    if(newPassword==''){
                                        showError('newPassword','密码不能为空');
                                        error = true;
                                        return ;
                                    }else {
//                                        $("#newPassword").css({"border-color": "green"});
                                        $("#newPasswordTip").css({"display": "none"});
                                    }
                                })

                                    $("#rolename").blur(function(){
                                        if($("input:checkbox[name='role']:checked").size() ==0)
                                        {
                                            showError('rolename','请选择角色');
                                            error = true;
                                            return ;
                                        }else {
//                                            $("#rolename").css({"border-color": "green"});
                                            $("#rolenameTip").css({"display": "none"});
                                        }
                                })
//                                $("#rePassword").blur(function () {
//                                    if(rePassword = ''){
//                                        showError('rePassword','确认密码不为空');
//                                        error = true;
//                                        return ;
//                                    }
//                                })
                                $("#rePassword").blur(function () {
                                    if(rePassword != newPassword){
                                        showError('rePassword','两次密码不一致');
                                        error = true ;
                                        return ;
                                    }else {
//                                        $("#rePassword").css({"border-color": "green"});
                                        $("#rePasswordTip").css({"display": "none"});
                                    }
                                })

                                    $("#name").blur();
                                    $("#newPassword").blur();
                                    $("#rolename").blur();
                                    $("#rePassword").blur();
                                    if(!error){
                                        $.ajax({
                                            url:__base_url__ + 'addUser',
                                            data:{'mobile':name,'password':newPassword,'rolename':rolename},
                                            dataType:'text',
                                            type:'POST',
                                            success:function(){
                                                $("#ycf-alert").modal("hide");
                                                location.reload();
                                            },
                                            error:function(){
                                                alert('fail');
                                            }
                                    });
                                    }

                            })
//                }
//            });
        }

        function edit(roleId,name){
            $('#ycf-alert').off().on('show.bs.modal', function (e) {
                var ckb = $("input[type='checkbox']");
//                for (var i=0;i<ckb.length;i++){
//                    var f = ckb[i];
                    if(roleId.indexOf(",") != -1){
                        var s = roleId.split(",");
                        for(var i = 0;i<s.length;i++){
                            $("input[value='"+s[i]+"']").attr("checked","checked");
//                            if(f.value==s[i]){
//                                f.checked=true;
//                            }
                        }
                    }else {
                        $("input[value='"+roleId+"']").attr("checked","checked");
//                        if(ckb.value==roleId){
//                            ckb.checked=true;
//                        }
                    }
//                }
            })

            Modal.confirm({
                msg:'<div class="modal-body"> <div class="row"> <div class="col-md-12"> <div class="form-group"> <label class="control-label col-md-2">用户名</label><div class="col-md-10"> <input id="name" name="Name" class="form-control" disabled="true" value=\''+ name +'\'/> </div> </div> </div> <div class="col-md-12"><div class="form-group"> <label class="control-label col-md-2">角色</label><div class="col-md-10"> <c:forEach var="role" items="${roles}"> <input type="checkbox" name="role" value="${role.id}" />${role.rolename}</c:forEach> </div> </div> </div></div> </div>',
                title:'修改信息',
                btncl: '取消',
                btnok: '确定'
            })
                .on(function(e){
                    var name = $("#name").val();
                    var rolename = $("input:checkbox[name='role']:checked").map(function(index,elem) {
                        return $(elem).val();
                    }).get().join(',');
//                    alert("选中的checkbox的值为："+text);
                    $.ajax({
                        url:__base_url__+'updateUserRole',
                        data:{'mobile':name,'rolename':rolename},
                        dataType:'text',
                        type:'POST',
                        success:function(){
//                            $("#ycf-alert").modal("hide");
                            location.reload();
                        }
                    });
                })
        }
        function dele (){
            Modal.confirm({
                msg:'是否要删除用户？',
                title:'操作提示',
                btnok:'确定',
                btncl:'取消'
            })
                    .on(function(e){
                        $.ajax({
                            url:'',
                            data:{},
                            dataType:'',
                            type:'',
                            success:function(){}
                        });
                    })
        }

        function resetPassword(name) {
            Modal.confirm({
                msg:'确定重置密码？',
                title:'操作提示',
                btnok:'确定',
                btncl:'取消'
            })
                    .on(function(e){
                        $.ajax({
                            url:__base_url__+'updateUserPassword',
                            data:{'mobile':name},
                            dataType:'text',
                            type:'POST',
                            success:function(){
                                location.reload();
                            }
                        });
                    })
        }

        function showError(formSpan,errorText){
            $("#" + formSpan).css({"border-color": "red"});
            $("#" + formSpan + "Tip").empty();
            $("#" + formSpan + "Tip").append(errorText);
            ;
            $("#" + formSpan + "Tip").css({"display": "inline"});
        }
    </script>
    <script defer="defer">
        function editLastTable(){
            $('.editable').handleTable({
                "handleFirst" : true,
                "del" : " <span class='glyphicon glyphicon-remove-circle'></span> ",
                "cancel" : " <span class='glyphicon glyphicon-remove'></span> ",
                "edit" : "	<span class='glyphicon glyphicon-edit'></span> ",
                "add" : " <span class='glyphicon glyphicon-plus'></span> ",
                "save" : " <span class='glyphicon glyphicon-saved'></span> ",
                "confirm" : " <span class='glyphicon glyphicon-ok'></span> ",
                "operatePos" : -1,
                "editableCols" : [0,1],
                "order": ["add","edit","del"],
                "saveCallback" : function(data, isSuccess) { //这里可以写ajax内容，用于保存编辑后的内容
                    //data: 返回的数据
                    //isSucess: 方法，用于保存数据成功后，将可编辑状态变为不可编辑状态
                    var flag = true; //ajax请求成功（保存数据成功），才回调isSuccess函数（修改保存状态为编辑状态）
                    if(flag) {
                        isSuccess();
                        alert(data + " 保存成功");
                    } else {
                        alert(data + " 保存失败");
                    }
                    return true;
                },
                "addCallback" : function(data,isSuccess) {
                    var flag = true;
                    if(flag) {
                        isSuccess();
                        alert(data + " 增加成功");
                    } else {
                        alert(data + " 增加失败");
                    }
                },
                "delCallback" : function(isSuccess) {
                    var flag = true;
                    if(flag) {
                        isSuccess();
                        alert("删除成功");
                    } else {
                        alert("删除失败");
                    }
                }
            });
        }
    </script>
    <script>
        $("#user_ink").addClass('active');
    </script>
</div>
</body>
</html>
