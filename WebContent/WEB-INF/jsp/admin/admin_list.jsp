<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
  <meta charset="utf-8">
  <title>layui</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/static/layui/css/layui.css"  media="all">
  <script src="<%=request.getContextPath() %>/static/jquery-easyui-1.3.5/jquery.min.js"></script>
</head>
<body style="margin: 15px;">  
<div style="margin-bottom: 5px;">          
  <p>����Ա�û���</p>

</div>
 
<div class="layui-btn-group demoTable">
  <button class="layui-btn" data-type="getCheckData">��ȡѡ��������</button>
  <button class="layui-btn" data-type="getCheckLength">��ȡѡ����Ŀ</button>
  <button class="layui-btn" data-type="isAll">��֤�Ƿ�ȫѡ</button>
</div>
 
<table class="layui-table" lay-data="{height:400, url:'<%=request.getContextPath() %>/admin/select_admin_list.do', page:true, id:'idTest'}" lay-filter="demo">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'user', width:220, sort: true, fixed: true}">ID</th>
      <th lay-data="{field:'user', width:220}">�û���</th>
      <th lay-data="{field:'password', width:220, sort: true}">����</th>
      <th lay-data="{fixed: 'right', width:160, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>

 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="detail">�鿴</a>
  <a class="layui-btn layui-btn-mini" lay-event="edit">�༭</a>
  <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">ɾ��</a>
</script>
               
          
<script src="<%=request.getContextPath() %>/static/layui/layui.js" charset="utf-8"></script>

<script>
layui.use('table', function(){
  var table = layui.table;
  //��������ѡ��ѡ��
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  });
  //����������
  table.on('tool(demo)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
      layer.msg('ID��'+ data.id + ' �Ĳ鿴����');
    } else if(obj.event === 'del'){
      layer.confirm('���ɾ����ô', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
      //layer.alert('�༭�У�<br>'+ JSON.stringify(data));
      layer.open({
    	  type: 1,
    	  skin: 'layui-layer-rim', //���ϱ߿�
    	  area: ['840px', '420px'], //����
    	  content: '\
    	      <form class="layui-form layui-form-pane" action="update_admin.do">\
        	    <div class="layui-form-item">\
        	      <label class="layui-form-label">�û���</label>\
        	      <div class="layui-input-block">\
        	        <input type="text" id="user" name="user" autocomplete="off" placeholder="�������û���" class="layui-input" readonly unselectable="on">\
        	      </div>\
        	    </div>\
        	    <div class="layui-form-item">\
      	          <label class="layui-form-label">����</label>\
      	          <div class="layui-input-block">\
      	            <input type="text" id="password" name="password" autocomplete="off" placeholder="����������" class="layui-input">\
      	          </div>\
      	        </div>\
        	    <input type="submit" class="layui-btn" value="�޸���Ϣ" />\
        	  </form>\
    	  '
    	});
      $("#user").val(eval(JSON.stringify(data.user)));
      $("#password").val(eval(JSON.stringify(data.password)));
    }
  });
  
  var $ = layui.$, active = {
    getCheckData: function(){ //��ȡѡ������
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.alert(JSON.stringify(data));
    }
    ,getCheckLength: function(){ //��ȡѡ����Ŀ
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.msg('ѡ���ˣ�'+ data.length + ' ��');
    }
    ,isAll: function(){ //��֤�Ƿ�ȫѡ
      var checkStatus = table.checkStatus('idTest');
      layer.msg(checkStatus.isAll ? 'ȫѡ': 'δȫѡ')
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});

</script>

</body>
</html>