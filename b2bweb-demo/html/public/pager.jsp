<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<form class="pager-form" role="form">
    <label>转到</label>
    <input type="text" class="form-control" onblur="javascript:window.location.href='#';">
    <label>页</label>
</form>
<ul class="pager pull-right" style="margin-left:2px;margin-right:2px;">
    <li><a href="#">上一页</a>
    </li>
    <li><a href="#">下一页</a>
    </li>
</ul>
<span class="label label-default pull-right label-page">共20页</span>
<span class="label label-primary pull-right label-page">当前第5页</span>
<ul class="pagination pull-right">
    <li class="disabled"><a href="#">&laquo;</a>
    </li>
    <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a>
    </li>
    <li><a href="#">2 <span class="sr-only">(current)</span></a>
    </li>
    <li><a href="#">3 <span class="sr-only">(current)</span></a>
    </li>
    <li><a href="#">4 <span class="sr-only">(current)</span></a>
    </li>
    <li><a href="#">5 <span class="sr-only">(current)</span></a>
    </li>
    <li><a href="#">&raquo;</a>
    </li>
</ul>