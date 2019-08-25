<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="easyUI/css/demo.css">
    <script src="js/jquery-1.8.3.js"></script>
    <!--jquery.easyui.min.js包含了easyUI中的所有插件-->
    <script src="js/jquery.easyui.min.js"></script>
</head>
<script src="js/district.js"></script>

<body>

<%--显示所有区域--%>
<table id="dg"></table>

<!--制作工具栏-->
<div id="ToolBar">
    <div style="height: 40px;">
        <a href="javascript:openAddDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加区域</a> <a
            href="javascript:openUpdateDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改区域</a> <a
            href="javascript:DeleteBatchDistrict()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">批量删除</a>
    </div>
</div>

<!--添加对话框-->
<div id="AddDialog" class="easyui-dialog" buttons="#AddDialogButtons"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="" id="form1">
        区域名称:<input type="text" name="name">
    </form>
</div>

<!--添加对话框的按钮-->
<div id="AddDialogButtons">
    <a href="javascript:addDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">添加</a> <a href="javascript:CloseAddDialog()"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<!--修改对话框-->
<div id="updateDialog" class="easyui-dialog" buttons="#updateDialogButtons"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="" id="form2">
        <input type="hidden" name="id">
        区域名称:<input type="text" name="name">
    </form>
</div>
<!--修改对话框的按钮-->
<div id="updateDialogButtons">
    <a href="javascript:updateDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">修改</a> <a href="javascript:CloseUpdateDialog()"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<!--显示街道对话框-->
<div id="showStreetDialog" class="easyui-dialog" buttons="#updateDialogButtons"
     style="width: 500px; height: 350px; padding: 10px 20px;" closed="true">
    <table id="dgStreet"></table>
    <form method="post">
        街道名称:<input type="text" name="name" id="name1">
        <input type="button" value="添加">
    </form>
</div>

</body>
</html>
