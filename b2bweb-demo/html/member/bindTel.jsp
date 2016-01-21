<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading"><strong><a href="#">绑定手机号</a></strong>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" method="post" enctype="multipart/form-data" role="form">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">请输入您的手机号</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="text" class="form-control" name="tel" placeholder="手机号码">
                                            <a href="#" class="btn btn-info">免费获取验证码</a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">输入验证码</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="text" class="form-control" name="code" placeholder="验证码">
                                            <p class="help-block">请输入您收到的6位验证码，验证码1小时内有效。</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-4 col-sm-8">
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