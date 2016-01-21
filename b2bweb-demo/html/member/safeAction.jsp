<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading"><strong><a href="#">操作保护设置</a></strong>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" method="post" enctype="multipart/form-data" role="form">
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label"></label>
                                        <div class="col-sm-8 form-inline">
                                            <label for="item1" class="control-label"><input type="checkbox" id="item1" name="item[]" value="1"> 修改手机号时先进行验证</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label"></label>
                                        <div class="col-sm-8 form-inline">
                                            <label for="item2" class="control-label"><input type="checkbox" id="item2" name="item[]" value="2"> 登录时先进行手机验证</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label"></label>
                                        <div class="col-sm-8 form-inline">
                                            <label for="item3" class="control-label"><input type="checkbox" id="item3" name="item[]" value="3"> 付款时先进行手机验证</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-1 col-sm-8">
                                            <button type="submit" class="btn btn-warning">确认提交</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <%@ include file="../public/footer.jsp" %>