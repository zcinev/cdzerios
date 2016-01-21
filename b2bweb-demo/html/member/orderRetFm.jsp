<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../public/head3.jsp"%>
<div class="container-fluid">
    <div class="row">
          <%@ include file="../public/memberSidebar.jsp" %>
          <div class="col-xs-10 paddingRight0 paddingLeft0"> 
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading"><strong><a href="#">申请退货</a></strong></div>
                <div class="container-fluid" style="width:80%;margin-top:20px;">
                    <form class="form-horizontal" role="form"  action="<%=basePath%>trade/orderRetFm" method="post">
                    <input type="hidden" name="mainId" value="${mainId}">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">退货理由</label>
                            <div class="col-sm-10 form-inline">
                                <select name="reason" class="form-control" id="reason">
                                      <option value="0">-请选择-</option>
                                </select>
                               
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-2 control-label">具体描述</label>
                            <div class="col-sm-10 form-inline">
                                <textarea name="content" class="form-control" style="width:90%;" rows="10"></textarea>
                            </div>
                        </div>
                        <input type="hidden" name="mainId" id="mainId" />
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-primary">提交</button>
                            </div>
                        </div>
                    </form>
                </div>    
            </div>
        </div>
    </div>
</div>
<%@ include file="../public/foot.jsp"%>
<script>

 $(document).ready(function () {
  var _this = $(this);
           $.ajax({
            type: "GET",
            url: "<%=basePath%>trade/getNotes",
            async:false,
            dataType: "html",
            success: function(data) {
           $('#reason').html(data);
            },
            error: function() {
            _this.text('请求失败');
            }
        });
          });
      function getQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) return unescape(r[2]); return null;
	}
	document.getElementById("mainId").value=getQueryString("mainId");
</script>