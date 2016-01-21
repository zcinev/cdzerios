<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp" %>
 <script src="<%=basePath%>html/js/join.js"></script>
<script src="<%=basePath%>html/js/validate.js" type="text/javascript"></script>
<style>
 /* 验证样式 */
.message{display:none;}
.messageLabel{color:red;}
.messageShow{font-size:10px;color:red;}
 
</style>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../public/memberSidebar.jsp" %>
        <div class="col-md-10 pull-right paddingRight0 paddingLeft0">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">
                    <ol class="breadcrumb bottom-spacing-0">
                        <li><a href="#">会员中心</a>
                        </li>
                        <li class="active">修改手机号</li>
                    </ol>
                </div>

                <div class="container-fluid" style="width:80%;margin-top:20px;">
                    <form class="form-horizontal" role="form" method="post" action="" name="form1">
                        <div class="form-group">
                            <label for="tel" class="col-sm-2 control-label">旧号码</label>
                            <div class="col-sm-3">
                                <input type="tel" class="form-control" name="oldTel" id="oldTel" placeholder="旧手机号码" readonly value="${sessionScope.userName}" >
                               
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tel" class="col-sm-2 control-label">新号码</label>
                            <div class="col-sm-3">
                                <input type="tel" id="telphone" class="form-control" name="mobile" placeholder="新手机号码" onblur="validatelegalTel('oldTel');">
                                 <span class="message" >新号码格式不正确！[]</span>
                   								 <span class="messageShow" ></span>
                            </div>
                            <div class="col-sm-3">
                                <a href="javascript:;" class="btn btn-default" id="get-ucode">获取校验码</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="code" class="col-sm-2 control-label">校验码</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" name="code" placeholder="手机校验码" onblur="validatelegalName('code');">
                                 <span class="message" >校验码不能为空！[]</span>
                   								 <span class="messageShow" ></span>
                            </div>
                            <div class="col-sm-3 help-block">
                                请输入手机校验码！
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-primary" onclick="updateTelphone();">修改</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="../public/foot3.jsp"%>
 <script type="text/javascript">
  function updateTelphone(){
  var check = true; 
     if (!validatelegalTel('oldTel')) {
		check = false;
	}
	 if (!validatelegalName('code')) {
		check = false;
	}
	if(check==false){
	  return ;
	}
	document.form1.action ="<%=basePath %>member/updateTel";
	document.form1.submit();
  }
  
  </script>
<script type="text/javascript">
$('#get-ucode').click(function() {
    var _this = $(this);
    $.ajax({
        type: "POST",
        url: "/b2bweb-demo/mobile/ucode",
        data: {mobile:$("#telphone").val()},
        dataType: "json",
        success: function(dat) {
            _this.text('30秒之后重新发送');
            var wait = 30;
            _this.text(wait + '秒之后重新发送');
            var interval = setInterval(function() {
                var time = --wait;
                $('.smsCode').html(time + '秒之后重新发送');
                if (time <= 0) {
                    $.post('/b2bweb-demo/mobile/ucode',{mobile:$("#telphone").val()},function() {
                        _this.text('获取校验码');
                    },"json");
                    clearInterval(interval);
                };
            }, 30000);
        },
        error: function() {
            _this.text('发送失败');
        }
    });
});
</script>