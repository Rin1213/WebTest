<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Sql.Sql" import="Sql.Node" import="java.util.ArrayList" import="java.util.List"  %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="shortcut icon" href="otherResource/theicon.ico" >
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<title>系统效能评估软件系统</title>
	<link type="text/css" rel="stylesheet" href="layui/css/layui.css" media="all">
	<script src="layui/layui.all.js"></script>
	<style>
    .demo-carousel{height: 200px; line-height: 200px; text-align: center;}
    p{text-indent:2em} 
    body{
		background:#009688;
	}
	</style>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="zTree/css/demo.css" type="text/css">
	<link rel="stylesheet" href="zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="zTree/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="zTree/js/jquery.ztree.excheck.js"></script>
	<script type="text/javascript" src="zTree/js/jquery.ztree.exedit.js"></script>
	<SCRIPT type="text/javascript">

		<!--

		var setting = {
			view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
			edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onRemove: onRemove,
				onRename: onRename
			}
		};
		function showLog(str) {
			if (!log) log = $("#log");
			log.append("<li class='"+className+"'>"+str+"</li>");
			if(log.children("li").length > 8) {
				log.get(0).removeChild(log.children("li")[0]);
			}
		}

		function onRename(e, treeId, treeNode, isCancel) {
			showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
		}
		function onRemove(e, treeId, treeNode) {
			showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var form1 = document.createElement("form"); 
			form1.id = "form1"; 
			form1.name = "form1"; 
			// 添加到 body 中 
			document.body.appendChild(form1); 
			// 创建一个输入 
			var input1 = document.createElement("input"); 
			// 设置相应参数 
			input1.type = "text"; 
			input1.name = "Treename"; 
			input1.value = "fq"; 
			// 将该输入框插入到 form 中 
			form1.appendChild(input1); 
			
			var input2 = document.createElement("input"); 
			input2.type = "text"; 
			input2.name = "deleteID"; 
			input2.value = treeNode.id; 
			// 将该输入框插入到 form 中 
			form1.appendChild(input2); 
			
			var input3 = document.createElement("input"); 
			input3.type = "text"; 
			input3.name = "Submits"; 
			input3.value = "6"; 						// 删除节点
			// 将该输入框插入到 form 中 
			form1.appendChild(input3); 
			// form 的提交方式 
			form1.method = "POST"; 
			// form 提交路径 
			form1.action="SqlServlet";
			// 对该 form 执行提交 
			form1.submit(); 
			// 删除该 form 
			document.body.removeChild(form1); 
		}
		
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		};


		function showRemoveBtn(treeId, treeNode) {
			return !treeNode.isFirstNode;
		}
		function showRenameBtn(treeId, treeNode) {
			return !treeNode.isLastNode;
		}


		function setEdit() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			remove = $("#remove").attr("checked"),
			rename = $("#rename").attr("checked"),
			removeTitle = $.trim($("#removeTitle").get(0).value),
			renameTitle = $.trim($("#renameTitle").get(0).value);
			zTree.setting.edit.showRemoveBtn = remove;
			zTree.setting.edit.showRenameBtn = rename;
			zTree.setting.edit.removeTitle = removeTitle;
			zTree.setting.edit.renameTitle = renameTitle;
			showCode(['setting.edit.showRemoveBtn = ' + remove, 'setting.edit.showRenameBtn = ' + rename,
				'setting.edit.removeTitle = "' + removeTitle +'"', 'setting.edit.renameTitle = "' + renameTitle + '"']);
		}
		function showCode(str) {
			var code = $("#code");
			code.empty();
			for (var i=0, l=str.length; i<l; i++) {
				code.append("<li>"+str[i]+"</li>");
			}
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			setEdit();
			$("#remove").bind("change", setEdit);
			$("#rename").bind("change", setEdit);
			$("#removeTitle").bind("propertychange", setEdit)
			.bind("input", setEdit);
			$("#renameTitle").bind("propertychange", setEdit)
			.bind("input", setEdit);
		});

<%
		Sql sql = Sql.getInstance();
		ArrayList <String> trees = sql.getTreeS();
		ArrayList <Node> sqlnode = null;
		int num = 0; 
		int nodenum = 0;
		if(trees != null) {
			sqlnode = sql.getIndexNodetoShow();
			num = trees.size();
		}
		if(sqlnode != null){		
			nodenum = sqlnode.size();
		}
		else{
			sql.Addnode("root", 0, 0);	// 判断是否有根节点来 自动创建根节点
		}
%>
		var zNodes =[];
<%		
		for(int i = 0;i < nodenum;i ++){
%>			zNodes.push({id:<%=sqlnode.get(i).nodeId%>, pId:<%=sqlnode.get(i).parentId%>, name:"<%=sqlnode.get(i).nodeName%>", open:true });
<%		}
%>			
		
		function setCheck() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			isCopy = $("#copy").attr("checked"),
			isMove = $("#move").attr("checked"),
			prev = $("#prev").attr("checked"),
			inner = $("#inner").attr("checked"),
			next = $("#next").attr("checked");
			zTree.setting.edit.drag.isCopy = isCopy;
			zTree.setting.edit.drag.isMove = isMove;
			showCode(1, ['setting.edit.drag.isCopy = ' + isCopy, 'setting.edit.drag.isMove = ' + isMove]);

			zTree.setting.edit.drag.prev = prev;
			zTree.setting.edit.drag.inner = inner;
			zTree.setting.edit.drag.next = next;
			showCode(2, ['setting.edit.drag.prev = ' + prev, 'setting.edit.drag.inner = ' + inner, 'setting.edit.drag.next = ' + next]);
		}
		function showCode(id, str) {
			var code = $("#code" + id);
			code.empty();
			for (var i=0, l=str.length; i<l; i++) {
				code.append("<li>"+str[i]+"</li>");
			}
		}
<%
		int nodeid = sql.getNumofnodes() + 1;
%>
		var newCount = <%=nodeid%>;
		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.addNodes(treeNode, {id:newCount, pId:treeNode.id, name:"new node" + newCount});

				var form1 = document.createElement("form"); 
				form1.id = "form1"; 
				form1.name = "form1"; 
				// 添加到 body 中 
				document.body.appendChild(form1); 
				// 创建一个输入 
				
				var input1 = document.createElement("input"); 
				input1.type = "text"; 
				input1.name = "parent"; 
				input1.value = treeNode.id; 
				// 将该输入框插入到 form 中 
				form1.appendChild(input1); 
				
				var input2 = document.createElement("input"); 
				input2.type = "text"; 
				input2.name = "Nodename"; 
				input2.value = "new node"+newCount; 
				// 将该输入框插入到 form 中 
				form1.appendChild(input2); 
				
				var input3 = document.createElement("input"); 
				input3.type = "text"; 
				input3.name = "Submits"; 
				input3.value = "1"; 
				// 将该输入框插入到 form 中 
				form1.appendChild(input3); 
				// form 的提交方式 
				form1.method = "POST"; 
				// form 提交路径 
				form1.action="SqlServlet";
				// 对该 form 执行提交 
				form1.submit(); 
				// 删除该 form 
				document.body.removeChild(form1); 
				return false;
			});
		};

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			setCheck();
			$("#copy").bind("change", setCheck);
			$("#move").bind("change", setCheck);
			$("#prev").bind("change", setCheck);
			$("#inner").bind("change", setCheck);
			$("#next").bind("change", setCheck);
		});
		//-->
	</SCRIPT>
</head>

<body>
	<div class="layui-layout layui-layout-admin kit-layout-admin">
        <div class="layui-header layui-bg-black">
            <div class="layui-logo">
            	<i class="layui-icon" style="font-size: 20px; color: #009688;">&#xe62c;</i>系统效能评估软件系统
            </div>
            <ul class="layui-nav layui-layout-right kit-nav">
                <li class="layui-nav-item">
                	<a href="login.jsp"> 注销</a>
                </li>
            </ul>
        </div>

        <div class="layui-side layui-bg-cyan kit-side">
            <div class="layui-side-scroll">
                <div class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
               <!-- <ul class="layui-nav layui-nav-tree" lay-filter="kitNavbar" kit-navbar> -->
                <ul class="layui-nav layui-nav-tree" lay-filter="test">
				<!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
					<li class="layui-nav-item layui-bg-cyan">
                        <a href="intro.jsp" data-url="" data-name="form" kit-loader><i class="fa fa-plug" aria-hidden="true"></i><span> 系统简介</span></a>
                    </li>
                    <li class="layui-nav-item layui-nav-itemed layui-bg-cyan">
                        <a href="javascript:;" ></i><span> 指标体系选择</span></a>
                    	<dl class="layui-nav-child">
                            <dd><a href="showIndexSystem.jsp" kit-target data-options="{url:'',icon:'&#xe658;',title:'威胁度',id:'8'}"><i class="layui-icon">&#xe658;</i><span> 威胁度（目前只有这一个指标体系）</span></a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item layui-bg-cyan">
                      	<a href="javascript:;"></i><span> 数据配置</span></a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="javascript:;" data-url="" data-icon="&#xe658;" data-title="数据导入" kit-target data-id='1'><i class="layui-icon">&#xe658;</i><span>数据导入</span></a>
                            </dd>
                            <dd>
                                <a href="javascript:;" data-url="" data-icon="&#xe658;" data-title="归一化" kit-target data-id='2'><i class="layui-icon">&#xe658;</i><span>归一化</span></a>
							</dd>
							<dd>
                                <a href="javascript:;" data-url="" data-icon="&#xe658;" data-title="量化分类" kit-target data-id='3'><i class="layui-icon">&#xe658;</i><span>量化分类</span></a>
							</dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item layui-nav-itemed layui-bg-cyan">
                        <a href="javascript:;" data-url="" data-name="form" kit-loader><span> 模型训练</span></a>
                    	<dl class="layui-nav-child">
                            <dd><a href="javascript:;" kit-target data-options="{url:'',icon:'&#xe658;',title:'分类',id:'8'}"><i class="layui-icon">&#xe658;</i><span> 算法</span></a></dd>
                            <dd><a href="javascript:;" kit-target data-options="{url:'',icon:'&#xe658;',title:'回归',id:'9'}"><i class="layui-icon">&#xe658;</i><span> 算法</span></a></dd>
                            <dd><a href="javascript:;" kit-target data-options="{url:'',icon:'&#xe658;',title:'随机过程',id:'10'}"><i class="layui-icon">&#xe658;</i><span> 还是算法</span></a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item layui-bg-cyan">
                        <a href="javascript:;" data-url="" data-name="table" kit-loader><i class="fa fa-plug" aria-hidden="true"></i><span> 模型选择</span></a>
                    </li>
                    <li class="layui-nav-item layui-bg-cyan">
                        <a href="javascript:;" data-url="" data-name="form" kit-loader><i class="fa fa-plug" aria-hidden="true"></i><span> 输出结果</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="layui-body" id="container" >
            <!-- 内容主体区域  -->
            <div style="padding: 30px;">
            <form action="SqlServlet" method="post">
				<div>
				树的名字:<input type="text" name="Treename" id="Treename" size="10">	
				节点的父节点编号:<input type="text" name="parent" id="parent" size="10" value="0">				
				节点的名字:<input type="text" name="Nodename" id="Nodename" size="10">
				节点的值:<input type="text" name="value" id="value" size="10" value="0">
				</div>
				<div>
				<button class="layui-btn layui-btn-primary" lay-submit lay-filter="formDemo" onclick="return checkuser()" name="Submits" value="0">新建树</button>
				<button class="layui-btn layui-btn-primary" lay-submit lay-filter="formDemo" onclick="return checkuser()" name="Submits" value="1">新建节点</button>
				<button class="layui-btn layui-btn-primary" lay-submit lay-filter="formDemo" onclick="return checkuser()" name="Submits" value="4">改变节点的值</button>
				</div>
			</form>
			<form action="SqlServlet" method="post" name = "showTree">
								<table bgcolor="#DEDEDE" border="2" cellspacing="5" cellpadding="5" width="400">
					<thead>
						<tr>
							<th>序号</th>
							<th>指标体系</th>
							<th>.</th>
						</tr>
					</thead>
					<tbody>
<%
					for(int i=0;i<num;i++) {
%>
						<tr>
							<td><%= i%></td>
							<td><%=trees.get(i).toString() %></td>
							<td><input type="radio" name = "nameofTree" value="<%=trees.get(i).toString() %>"></td>
						</tr>
<%
					}
%>
						<tr>
							<button class="layui-btn layui-btn-primary" lay-submit lay-filter="formDemo"  name="Submits" value="3">删除树</button>
							<button class="layui-btn layui-btn-primary" lay-submit lay-filter="formDemo"  name="Submits" value="5">显示树</button>
						</tr>
					</tbody>	
				
			</form>
			</div>
			
			<div class="content_wrap" id="container" >
				<div class="zTreeDemoBackground left" >
					<ul id="treeDemo" class="ztree"></ul>
				</div>
				<div class="right" style="display: none" onMouseout="hidden();">
					<ul class="info">
							<li><p>
								<br><br><br><br>
								<form id = "form1" name="form1"method="post">
									<input type="checkbox" id="remove" class="checkbox first" checked />
									<input type="checkbox" id="rename" class="checkbox " checked />
									<input type="text" id="removeTitle" value="remove" /><br/>
									<input type="text" id="renameTitle" value="rename" />
								</form>
								</p>
							</li>
							</ul>
						</li>
						
					</ul>
				</div>
			</div>
			
        </div>

        <div class="layui-footer layui-bg-black">
            <!-- 底部固定区域 -->
           	<font color="#009688" size="3px">样式来源：<a href="http://www.layui.com/">layui.com</a></font>
        </div>
    </div>
    
    <script src="layui/layui.js" charset="utf-8"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
	layui.use('element', function(){
	  var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
	  
	  //监听导航点击
	  element.on('nav(demo)', function(elem){
	    //console.log(elem)
	    layer.msg(elem.text());
	  });
	});
	</script>
</body>
</html>