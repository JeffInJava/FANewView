<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePathHttp = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
String basePathHttps = request.getScheme()+"s://"+request.getServerName()+request.getContextPath()+"/";
String basePath=basePathHttp;
%>
<base href="<%=basePath%>">

<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
	
<!-- address icon -->
<link rel="shortcut icon" href="resource/inesa/images/common/bitbug_favicon.ico" type="image/x-icon" />

<!-- basic styles -->
<link href="resource/ace/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="resource/ace/css/font-awesome.min.css" />


<!--[if IE 7]>
  <link rel="stylesheet" href="resource/ace/css/font-awesome-ie7.min.css" />
<![endif]-->


<!-- page specific plugin styles -->
<!-- jquery-ui -->
<link rel="stylesheet" href="resource/ace/css/jquery-ui-1.10.3.full.min.css" />
<!-- select chosen -->
<link rel="stylesheet" href="resource/ace/css/chosen.css" />
<!-- datepicker -->
<link rel="stylesheet" href="resource/ace/css/datepicker.css" />
<!-- jqgrid -->
<link rel="stylesheet" href="resource/ace/css/ui.jqgrid.css" />
<!-- gritter -->
<link rel="stylesheet" href="resource/ace/css/jquery.gritter.css" />
<!-- colorbox -->
<link rel="stylesheet" href="resource/ace/css/colorbox.css" />

<!-- fonts -->
<link rel="stylesheet" href="resource/ace/css/ace-fonts.css" />

<link rel="stylesheet" href="resource/ace/css/dropzone.css" />

<!-- ace styles -->
<link rel="stylesheet" href="resource/ace/css/ace.min.css" />
<link rel="stylesheet" href="resource/ace/css/ace-rtl.min.css" />
<link rel="stylesheet" href="resource/ace/css/ace-skins.min.css" />

<link href="resource/inesa/js/plugin/select2/select2.css" rel="stylesheet" />


<!--[if lte IE 8]>
  <link rel="stylesheet" href="resource/ace/css/ace-ie.min.css" />
<![endif]-->


<!-- animate styles -->
<link rel="stylesheet" href="resource/inesa/css/animate.min.css" />

<!-- inesanet styles -->
<link rel="stylesheet" href="resource/inesa/css/common.css" />
<!-- bootstrapmessager -->
<%--<link rel="stylesheet" href="wf/resource/inesa/css/bootstrap.messager.css" />--%>
<!-- ztree -->
<%--<link rel="stylesheet" type="text/css" href="wf/gooflow/PropertyBox/js/zTreeStyle/zTreeStyle.css">--%>











