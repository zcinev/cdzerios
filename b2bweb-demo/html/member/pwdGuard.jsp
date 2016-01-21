<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../public/head3.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading"><strong><a href="#">密保安全设置</a></strong>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" method="post" enctype="multipart/form-data" role="form">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">手机号码</label>
                                        <div class="col-sm-8 form-inline">
                                            <label class="control-label">
                                                186<span>*****</span>087
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">校验码</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="text" class="form-control" size="5" name="checkCode" placeholder="校验码">
                                            <a href="#" class="btn btn-info">免费获取短信校验码</a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">密保问题一</label>
                                        <div class="col-sm-8 form-inline">
                                            <select name="question[]" class="form-control">
                                                <option value="0">-请选择-</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">密保答案</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="text" class="form-control" name="answer[]" placeholder="答案">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">密保问题二</label>
                                        <div class="col-sm-8 form-inline">
                                            <select name="question[]" class="form-control">
                                                <option value="0">-请选择-</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">密保答案</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="text" class="form-control" name="answer[]" placeholder="答案">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">密保问题三</label>
                                        <div class="col-sm-8 form-inline">
                                            <select name="question[]" class="form-control">
                                                <option value="0">-请选择-</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">密保答案</label>
                                        <div class="col-sm-8 form-inline">
                                            <input type="text" class="form-control" name="answer[]" placeholder="答案">
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