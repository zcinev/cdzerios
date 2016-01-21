<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <%@ include file="../public/head3.jsp"%>
        <div class="container-fluid">
            <div class="row">

                <%--<%@ include file="../public/memberSidebar.jsp" %>
                    --%><div class="col-xs-12 paddingLeft0 paddingRight0">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="background-color: #ecf9ff;border-color: #ddd;">
                            <ol class="breadcrumb bottom-spacing-0">
                            <li class="active">隐私设置 </li> 
                            </ol>
                            
                            </div>
                            <div class="panel-body">
                                <blockquote style="margin-top:20px;">
                                    <h6 style="font-weight: bold;">您的基础信息</h6>
                                </blockquote>
                                <ul class="list-unstyled pwd-strong-ul" style="margin-top: 30px;">
                                    <!--
                                    <li>
                                        <strong class="pull-left">登录邮箱：</strong> 
                                        <p class="pull-left form-control-static"></p>
                                        <strong class="pull-left">您尚未设置登录邮箱</strong> 
                                        <a href="#" class="pull-left">设置</a>
                                    </li>
-->
                                    <li>
                                        <span class="pull-left" style="color: #333;">手机号码：</span>
                                        <span class="pull-left" style="color: #333;">${userName}</span> 
                                         <a href="<%=basePath%>html/member/changeTel.jsp" class="pull-left" style="color:#428BCA;margin-left: 90px;">更换号码</a> 
                                    </li>
                                    <li>
                                     <c:if test="${typeId !='2'}">
                                        <span class="pull-left">上次登录时间：</span> 
z                                        </c:if>
                                        <c:if test="${typeId=='2'}">
                                        <span class="pull-left">上次登录时间：</span> 
                                        </c:if>
                                        <span class="pull-left">${loginTimes.loginTime}  （不是您登录的？请</span> 
                                        <a href="<%=basePath%>html/member/changePwd.jsp" class="pull-left" style="color:#428BCA;">点击这里</a>
                                        <spang class="pull-left">）</span>
                                    </li>
                                    <li></li>
                                </ul>
                                <div class="clearfix" style="border-top:1px solid #ccc;"></div>
                                <blockquote style="margin-top:20px;">
                                   
                                    <h6 style="font-weight: bold;">您的安全服务</h6>
                                </blockquote>
                                <table class="pwd-table" style="margin-left:20px;margin-top: 20px;">
                                    <%--<tr>
                                        <td class="text-center">
                                            <dl>
                                                <dd>
                                                    <img src="<%=basePathpj%>html/img/yes.png" alt="ok">
                                                    <p style="color:#323333">已完成</p>
                                                </dd>
                                            </dl>
                                        </td>
                                        <td><strong>身份认证</strong>
                                        </td>
                                        <td style="width:83%;color: #666;" class="text-center">身份证号码，能够验证你的身份，更加安全！</td>
                                        <td class="text-center"><a href="<%=basePath%>member/identifyTest?id=${sessionScope.userName}" style="color:#428BCA;">修改</a>
                                        </td>
                                    </tr>
                                    --%><tr >
                                        <td class="text-center" style="color: #333;">
                                            <span>强度：<span style="color:#f00;">中</span></span>
                                        </td>
                                        <td><span style="margin-left: 14px;">登录密码</span>
                                        </td>
                                        <td style="width:80%;color: #666;"class="text-center">请设置复杂的密码,以防被盗！！！！</td>
                                        <td class="text-center" ><a href="<%=basePath%>html/member/changePwd.jsp" style="color:#428BCA;"> 修改</a>
                                        </td>
                                    </tr><%--
                                     <tr>
                                        <td class="text-center">
                                            <dl>
                                                <dd>
                                                    <img src="<%=basePathpj%>html/img/no.png" alt="no">
                                                </dd>
                                                <dt>未设置</dt>
                                            </dl>
                                        </td>
                                        <td><strong>安全保护问题</strong>
                                        </td>
                                        <td>当您忘记密码了，可以通过密保来找回哦！！！！</td>
                                        <td class="text-center"><a href="<%=basePath%>html/member/pwdGuard.jsp">设置</a>
                                        </td>
                                    </tr> 
                                     <tr>
                                        <td class="text-center">
                                            <dl>
                                                <dd>
                                                    <img src="<%=basePathpj%>html/img/yes.png" alt="yes">
                                                </dd>
                                            </dl>
                                        </td>
                                        <td><strong>手机绑定</strong>
                                        </td>
                                        <td>最直接的问题就是绑定手机号码，有动态您就知道！！</td>
                                        <td class="text-center"><a href="<%=basePath%>html/member/bindTel.jsp">绑定</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-center">
                                            <dl>
                                                <dd>
                                                    <img src="<%=basePathpj%>html/img/yes.png" alt="yes">
                                                </dd>
                                            </dl>
                                        </td>
                                        <td><strong>操作保护设置</strong>
                                        </td>
                                        <td>维护</td>
                                        <td class="text-center"><a href="<%=basePath%>html/member/safeAction.jsp">维护</a>
                                        </td>
                                    </tr> 
                                --%></table>
                            </div>
                        </div>
                    </div>
            </div>
           
        </div>

        <%@ include file="../public/foot.jsp" %>