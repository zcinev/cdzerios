<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
var path = '<%=basePath%>html/plugin/SWFUpload';
//var url = '__APP__/Public/';
</script>
<script src="<%=basePath%>html/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/SWFUpload/js/swfupload.js"></script>
<script type="text/javascript" src="<%=basePath%>html/plugin/SWFUpload/js/handlers.js"></script>
<link type="text/css" rel="stylesheet" href="<%=basePath%>html/plugin/SWFUpload/css/default.css" />

<script type="text/javascript">
var swfu;
window.onload = function() {
    swfu = new SWFUpload({
        upload_url: "",//上传图片的处理方法地址配置
        post_params: {
            "PHPSESSID": "<?php echo session_id();?>"
        },
        file_size_limit: "2 MB",
        file_types: "*.jpg;*.png;*.gif;*.bmp",
        file_types_description: "JPG Images",
        file_upload_limit: "8",
        file_queue_error_handler: fileQueueError,
        file_dialog_complete_handler: fileDialogComplete,
        upload_progress_handler: uploadProgress,
        upload_error_handler: uploadError,
        upload_success_handler: uploadSuccess,
        upload_complete_handler: uploadComplete,
        button_image_url: "<%=basePath%>html/plugin/SWFUpload/images/upload.png",
        button_placeholder_id: "spanButtonPlaceholder",
        button_width: 113,
        button_height: 33,
        button_text: '',
        button_text_style: '.spanButtonPlaceholder { font-family: Helvetica, Arial, sans-serif; font-size: 14pt;} ',
        button_text_top_padding: 0,
        button_text_left_padding: 0,
        button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
        button_cursor: SWFUpload.CURSOR.HAND,
        flash_url: "<%=basePath%>html/plugin/SWFUpload/swf/swfupload.swf",
        custom_settings: {
            upload_target: "divFileProgressContainer"
        },
        debug: false
    });
};
</script>
<span id="spanButtonPlaceholder"></span>
<div id="divFileProgressContainer"></div>
<font color="#360" style="display:block;float:left;">[图片最多只可以上传8张，多余的图片会被系统自动删除。]</font><br/>
<div id="pic_list" class="thumbnails">
     <dl class="thumb-dl" style="border:2px solid #000;">
         <dt>
             <img class='content' src="" style="width:100px;height:100px;" />
             <img class='button' src="<%=basePath%>html/plugin/SWFUpload/images/fancy_close.png" data-id="" />
         </dt>
         <dd>
             <input type="text" name="intro[]" style="display:inline-block;width:96px;" value="" />
             <input type="hidden" name="src[]" value="" />
         </dd>
         <dd class="set_first">
             <input type="button" value="设为封面" />
             <input class="sort" type="hidden" name="sort[]" value="" />
         </dd>
     </dl>
     <dl>
         <dt>
             <img class='content' src="" style="width:100px;height:100px;" />
             <img class='button' src="<%=basePath%>html/plugin/SWFUpload/images/fancy_close.png" data-id="" />
         </dt>
         <dd>
             <input type="text" name="intro[]" style="display:inline-block;width:96px;" value="" />
             <input type="hidden" name="src[]" value="" />
         </dd>
         <dd class="set_first">
             <input type="button" value="设为封面" />
             <input class="sort" type="hidden" name="sort[]" value="" />
         </dd>
     </dl>
     <dl>
         <dt>
             <img class='content' src="" style="width:100px;height:100px;" />
             <img class='button' src="<%=basePath%>html/plugin/SWFUpload/images/fancy_close.png" data-id="" />
         </dt>
         <dd>
             <input type="text" name="intro[]" style="display:inline-block;width:96px;" value="" />
             <input type="hidden" name="src[]" value="" />
         </dd>
         <dd class="set_first">
             <input type="button" value="设为封面" />
             <input class="sort" type="hidden" name="sort[]" value="" />
         </dd>
     </dl>
</div>
<input type="hidden" name="s" value="" />
<script type="text/javascript">
$(function() {
    $('#pic_list dl').delegate(".set_first","mouseover",function() {
    	$(this).find(':button').show().closest('dl').siblings('dl').find(':button').hide();
    });
    
    $('#pic_list dl').delegate(".set_first","mouseout", function() {
    	$('#pic_list').find(':button').hide();
    });

	//设为封面图片的方法
    $('#pic_list dl .set_first').delegate(":button","click", function() {
        $(this).closest('dl').css({
            "border": "2px solid #000"
        }).siblings('dl').css({
            "border": "none"
        });
        $(this).siblings('.sort').val(1).closest('dl').siblings('dl').find('.sort').val(0);
    });

	//图片删除方法
    $('#pic_list dl dt').delegate(".button","click", function() {
   		//这里配置删除方法地址
        var href = "";
        var _this = $(this);
        $.get(href, function(data) {
            if (data == 1) {
                $(_this).closest('dl').remove();
            }
        });
    });
});
</script>