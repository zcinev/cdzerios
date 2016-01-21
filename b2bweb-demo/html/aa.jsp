<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ page import="com.bc.localhost.*"%>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>兼容性好的Js弹出框，完美拖拽</title>
<style>
*{ margin:0; padding:0}
</style>
</head>
<body>


<input type="button" onclick="openLoginBox()" value="登  录"  />




<script type="text/javascript">
 //动态创建登录框
 var closeLoginBox=function(){
	 var loginBox=document.getElementById('loginBox');
	 	 var cover=document.getElementById('cover');
		 
	 document.body.removeChild(loginBox);
	 document.body.removeChild(cover);
	 
	 }
var openLoginBox=function(){
 var cover=document.createElement('div');
     cover.setAttribute('id','cover');
     cover.style.width='100%';
	 cover.style.height=document.documentElement.scrollHeight+'px';
	 cover.style.background='#f8f8f8';
	 cover.style.position='absolute';
	 	 cover.style.left='0';
	 cover.style.top='0';
	 cover.zIndex='99';
	 cover.style.opacity=0.7;
	 cover.style.filter='alpha(opacity=70)'
	 document.body.appendChild(cover);
 var loginBox=document.createElement('div');
      loginBox.setAttribute('id','loginBox');
     loginBox.style.width='450px';
	 loginBox.style.height='400px';
     loginBox.style.border='5px solid #c66';
     loginBox.style.position='absolute';
     loginBox.style.left='50%';
	 loginBox.style.top=document.documentElement.scrollTop+(document.documentElement.clientHeight-250)/2+'px';
     loginBox.style.overflow='hidden';
     loginBox.style.marginLeft='-200px';
     loginBox.style.width='400px';
	 loginBox.style.boxShadow='0 0 19px #666666'
	 loginBox.style.borderRadius='10px';
	 document.body.appendChild(loginBox);
	 
var loginBoxHandle=document.createElement('h1');
     loginBoxHandle.setAttribute('id','loginBoxHandle');
	 loginBoxHandle.style.fontSize='14px';
	 loginBoxHandle.style.color='#c00';
	 loginBoxHandle.style.background='#f7dcdc';
	 loginBoxHandle.style.textAlign='left';
	 loginBoxHandle.style.padding='8px 15px';
	 loginBoxHandle.style.margin='0';
	 loginBoxHandle.innerHTML='用户登陆<span onclick="closeLoginBox()" title="关闭" style="position:absolute; cursor:pointer; font-size:14px;right:8px; top:8px">×</span>';
     loginBox.appendChild(loginBoxHandle);

var iframe=document.createElement('iframe');
    iframe.setAttribute('src','./login.html');
	iframe.setAttribute('frameborder','0');
	iframe.setAttribute('scrolling','no');
	iframe.setAttribute('width',400);
	iframe.setAttribute('height',250);
	loginBox.appendChild(iframe);
	 new dragDrop({
          target:document.getElementById('loginBox'),
         bridge:document.getElementById('loginBoxHandle')
});		
}
	 

/* new Dragdrop({
 *         target      拖拽元素 HTMLElemnt 必选
 *         bridge     指定鼠标按下哪个元素时开始拖拽，实现模态对话框时用到 
 *         dragX      true/false false水平方向不可拖拽 (true)默认
 *         dragY     true/false false垂直方向不可拖拽 (true)默认
 *         area      [minX,maxX,minY,maxY] 指定拖拽范围 默认任意拖动
 *         callback 移动过程中的回调函数
 * });
*/
Array.prototype.max = function() {
    return Math.max.apply({},this)
}
Array.prototype.min = function() {
    return Math.min.apply({},this)
}
var getByClass=function(searchClass){
        var tags = document.getElementsByTagName('*');
            var el = new Array();
        for(var i=0;i<tags.length;i++){
            if(tags[i].className==searchClass){
                el.push(tags[i])
                };
            }
            return el
    }
function dragDrop(option){
    this.target=option.target;
    this.dragX=option.dragX!=false;
    this.dragY=option.dragY!=false;
    this.disX=0;
    this.disY=0;
    this.bridge =option.bridge;
    this.area=option.area;
    this.callback=option.callback;
    this.target.style.zIndex='0';
    var _this=this;
	     this.bridge && (this.bridge.onmouseover=function(){ _this.bridge.style.cursor='move'});
     this.bridge?this.bridge.onmousedown=function(e){ _this.mousedown(e)}:this.target.onmousedown=function(e){ _this.mousedown(e)}
         }
    dragDrop.prototype={
        mousedown:function(e){
            var e=e||event;
                        var _this=this;    
             this.disX=e.clientX-this.target.offsetLeft;
             this.disY=e.clientY-this.target.offsetTop;
            this.target.style.cursor = 'move';
           
             if(window.captureEvents){ 
             e.stopPropagation();
          e.preventDefault();}
              else{
                e.cancelBubble = true;
                }
            if(this.target.setCapture){
                this.target.onmousemove=function(e){_this.move(e)}
                this.target.onmouseup=function(e){_this.mouseup(e)}
                this.target.setCapture()
                }
                else{
            document.onmousemove=function(e){_this.move(e)}
            document.onmouseup=function(e){_this.mouseup(e)}
                }
                    },
    move:function(e){
	 this.target.style.margin=0;
                var e=e||event;
                var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
                var moveX=e.clientX-this.disX;
                var moveY=e.clientY-this.disY;
                if(this.area){
                moveX < _this.area[0] && (moveX = this.area[0]); // left 最小值
                moveX > _this.area[1] && (moveX = this.area[1]); // left 最大值
                moveY < _this.area[2] && (moveY = this.area[2]); // top 最小值
                moveY > _this.area[3] && (moveY = this.area[3]); // top 最大值                    
                    }
                    
                this.dragX && (this.target.style.left=moveX+'px');
                this.dragY && (this.target.style.top=moveY+'px');
                //限定范围
                 parseInt(this.target.style.top)<0 && (this.target.style.top=0);
                 parseInt(this.target.style.left)<0 && (this.target.style.left=0);
                 parseInt(this.target.style.left)>document.documentElement.clientWidth-this.target.offsetWidth&&(this.target.style.left=document.documentElement.clientWidth-this.target.offsetWidth+"px");
                 parseInt(this.target.style.top)>scrollTop+document.documentElement.clientHeight-this.target.offsetHeight && (this.target.style.top=scrollTop+document.documentElement.clientHeight-this.target.offsetHeight+'px');
                if(this.callback){
                    var obj = {moveX:moveX,moveY:moveY};
                    this.callback.call(this,obj)
                    }
            return false
            },
     mouseup:function (e)
            {
             var e=e||event;
             this.target.style.cursor = 'default';
             var _this=this;
			  this.target.onmousemove=null;
			  this.target.onmouseup=null;
            document.onmousemove=null;
            document.onmouseup=null;
            if(this.target.releaseCapture) {this.target.releaseCapture()}
            }    
        }
		
		
</script>
</body>
</html>