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
<%--<script src="js/district.js"></script>--%>
<script>
    //使用datagrid绑定数据库，展示区域信息
    $(function () {
        //使用datagrid绑定数据库
        $("#dg").datagrid({
            url: 'getAllDistrict',
            title: "区域信息",
            toolbar: "#ToolBar",  //指定工具栏
            pagination: true,//开启分页
            pageSize: 3,//设置每页多少条
            pageList: [3, 6, 10, 15],//设置选择分页大小的条数
            columns: [[
                {field: 'che', checkbox: true},
                {field: 'id', title: '编号', width: 250},
                {field: 'name', title: '区域名称', width: 250},
                {
                    field: 's', title: '操作', width: 200,
                    formatter: function (value, row, index) { //value:字段值 row:行数据 index:行索引
                        var str = "<a id='but' href='javascript:OpenShowStreetDialog(" + row.id + ")'>查看街道</a>&emsp;" +
                            "<a id='but' href='javascript:delDistrict(" + row.id + ")'>删除街道</a>&emsp;" +
                            "<a id='but' href='javascript:updateDistrict()'>修改街道</a>";
                        return str;
                    }
                }
            ]]
        });
    });


    //打开显示街道对话框
    function OpenShowStreetDialog(did) {
        $('#showStreetDialog').window('setTitle', "街道信息");
        $('#showStreetDialog').window("open");
        //发送绑定数据
        $('#dgStreet').datagrid({
            url: 'getStreetByDid?did=' + did,
            title: "街道信息",
            pagination: true,
            pageList: [3, 6, 9, 15, 20],
            pageSize: 3,
            //singleSelect:true,
            columns: [[
                {field: "cb", checkbox: true},
                {field: 'id', title: '编号', width: 100},
                {field: 'name', title: '街道名称', width: 100}
            ]]
        });
    }

    //点击添加，打开窗口
    function openAddDialog() {
        $('#AddDialog').window('setTitle', "添加区域");
        $('#AddDialog').window('open');
    }

    //关闭添加对话框
    function CloseAddDialog() {
        $('#AddDialog').window('close'); //关闭
    }

    //添加区域
    function addDistrict() {
        //使用easyUi插件以异步请求的方式提交表单
        $("#form1").form('submit', {
            url: "addDistrict",
            success: function (data) { //date表示字符串
                //将返回的json字符串转化成json对象
                data = $.parseJSON(data);
                if (data.result > 0) {
                    //数据更改与服务器交互，刷新当前数据
                    $('#dg').datagrid('load');
                    $.messager.alert('提示', '添加成功！', 'info');//提示框
                    $('#AddDialog').window('close'); //关闭对话框
                } else {
                    $.messager.alert('提示', '添加失败！', 'error');
                    $('#AddDialog').window('close'); //关闭
                }
            }
        });
    }


    //点击修改 打开对话框
    function openUpdateDialog() {
        //1.判断用户选择 获取dagagrid的选中行
        var SelectRows = $("#dg").datagrid('getSelections');  //返回数组
        if (SelectRows.length == 1) {
            $('#updateDialog').window('setTitle', "编辑区域");
            $('#updateDialog').window('open');
            /*
            * 获取当前行的数据:获取主键，查询数据库获取单行数据
            * 如果当显示的数据在dagagrid中存在，无需查询数据库，如果当显示的数据在datagrid中不全，需要查询数据库获单条
            * 发异步请求查询数据库
            * */
            $.post("getOneDistrict", {"id": SelectRows[0].id}, function (data) {
                $("#form2").form('load', data); //将对象还原表单
            }, "json");
        } else {
            $.messager.alert('提示', '你没有选择行或者选择多行', 'warn');  //提示框
        }
    }

    //关闭修改对话框
    function CloseUpdateDialog() {
        $('#updateDialog').window('close'); //关闭
    }

    //修改区域
    function updateDistrict() {
        //使用easyUI去实现修改区域信息
        $("#form2").form('submit', {
            url: "updateDistrict",
            success: function (data) { //date表示字符串
                //将返回的json字符串转化成json对象
                data = $.parseJSON(data);
                if (data.result > 0) {
                    //数据更改与服务器交互，刷新当前数据
                    $('#dg').datagrid('load');
                    $.messager.alert('提示', '修改成功！', 'info');//提示框
                    $('#updateDialog').window('close'); //关闭对话框
                } else {
                    $.messager.alert('提示', '修改失败！', 'error');
                    $('#updateDialog').window('close'); //关闭
                }
            }
        });
    }

    //删除区域信息
    function delDistrict(id) { //参数id
        //确认消息框
        $.messager.confirm('提示', '确定删除吗?', function (r) {
            if (r) {  //实现删除
                //删除数据库
                $.post("delDistrict", {"id": id}, function (data) {
                    if (data.result > 0) {
                        //刷新datagrid
                        $('#dg').datagrid("load");
                    } else {
                        $.messager.alert('提示', '删除失败！', 'error');
                    }
                }, "json");
            }
        });
    }

    //批量删除
    function DeleteBatchDistrict() {
        //1.获取dagagrid的选中行
        var SelectRows = $("#dg").datagrid('getSelections');  //返回数组
        //判断是否选择行
        if (SelectRows.length == 0) {
            $.messager.alert('提示', '请选择要删除的行！', 'warn');
        } else {
            //确认框
            $.messager.confirm('提示', '确定删除吗?', function (r) {
                if (r) {  //删除
                    //3.获取选中项的值,拼接字符串 格式:1,2,3
                    var val = "";
                    for (var i = 0; i < SelectRows.length; i++) {
                        val = val + SelectRows[i].id + ",";
                    }
                    val = val.substring(0, val.length - 1);
                    //4.发送异步请求到服务器实现删除
                    $.post("deleteBatchDistrict", {"ids": val}, function (data) {
                        if (data.result > 0) {
                            //刷新datagrid
                            $('#dg').datagrid("load");
                        } else {
                            $.messager.alert('提示', '删除多项失败！', 'error');
                        }
                    }, "json");
                }
            });
        }
    }

</script>

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

<!--添加区域对话框-->
<div id="AddDialog" class="easyui-dialog" buttons="#AddDialogButtons"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="" id="form1">
        区域名称:<input type="text" name="name">
    </form>
</div>

<!--添加对话框的按钮-->
<div id="AddDialogButtons">
    <a href="javascript:addDistrict()" class="easyui-linkbutton" iconCls="icon-ok">添加</a>
    <a href="javascript:CloseAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<!--修改对话框-->
<div id="updateDialog" class="easyui-dialog" buttons="#UpdateDialogButtons"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="" id="form2">
        <input type="hidden" name="id">
        区域名称:<input type="text" name="name">
    </form>
</div>

<!--修改对话框的按钮-->
<div id="UpdateDialogButtons">
    <a href="javascript:updateDistrict()" class="easyui-linkbutton" iconCls="icon-ok">修改</a>
    <a href="javascript:CloseUpdateDialog()" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<!--显示街道对话框-->
<div id="showStreetDialog" class="easyui-dialog" buttons="#updateDialogButtons"
     style="width: 500px; height: 350px; padding: 10px 20px;" closed="true">
    <table id="dgStreet"></table>
</div>

</body>
</html>
