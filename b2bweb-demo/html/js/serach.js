  document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0]; 
         var keyword=document.getElementById("keyword").value;        
        if(e && e.keyCode==13){ 
               if(keyword !=""){
                     ssfun();
                     
         }
        } 
    }; 