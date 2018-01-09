<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../Include/Init.jsp"%>
<%@ taglib uri="controls" prefix="z"%>
<html>
<head>
	<link href="../Include/Default.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="../Framework/Main.js"></script>
	<script type="text/javascript" src="../template/common/js/jquery.js"></script>
	<script type="text/javascript">
	
	function getFileUrl() {
		var fileUrl=window.document.getElementById("upload").value;
		if(fileUrl==""){
			Dialog.alert("请选择文件! ");
		}else{
			//如果选择了导入文件按上传文件导入
			if(fileUrl!=''&&/\S+\.xls$/.test(fileUrl)){
				fm.submit();
				return;
			}else{
				Dialog.alert("请选择.xls格式的文件！");
			}
		}
	}
	function afterUpload(fileUrl){
		var dc = new DataCollection();	
		dc.add("fileaddress",fileUrl);
		Server.sendRequest("com.wangjin.lineteam.LineTeamPolicyInfo.asyncBatchAdd",dc,function(response){
			var taskID = response.get("TaskID");
			var p = new Progress(taskID, "正在导入信息...");
			p.show(function(){
				
			});
		});

	} 

	</script>
	<title>上传</title>
	<style>
	#mid {
		position: absolute;
		top: 50%;
		left: 50%;
		margin: -50px 0 0 -120px;
		width: 250px;
		height: 100px;
	}
	</style>

</head>

<body>
	<z:init method="com.wangjin.lineteam.LineTeamPolicyInfo.initDialog">
	<div style="display:none;"><iframe src="javascript:void(0);"
		name="targetFrame" width="0" height="0" frameborder="0"></iframe></div>
		<table align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td>
				<div id="mid" style="margin-top:5px">
					<form  action="BatchUploadSave.jsp" method="post" name="fm" enctype="multipart/form-data" target="targetFrame"> <br>
						<input name="upload" id="upload" type="file" value='' size='20' >
						<input onClick="getFileUrl();" type='button' value='上传' name="Import" id="Import">
						<a href="../LineTeam/template/import_template.xls">模板下载</a>
					</form>
					<input name="ip" type="hidden" value="<%=request.getRemoteAddr()%>" class="inputText" id="ip" />
					<td><input type='hidden' id='style' value='0'></td>
				</div>
			</td>
		</tr>
	</table>
	</z:init>
</body>
</html>