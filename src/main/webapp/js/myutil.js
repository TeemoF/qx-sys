//序列化一个表单称为JSON对象
	$.fn.serializeObject = function () {
	    var o = {};
	    var a = this.serializeArray();
	    $.each(a, function () {
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });
	    var $radio = $('input[type=radio],input[type=checkbox]',this);
	    $.each($radio,function(){
	        if(!o.hasOwnProperty(this.name)){
	            o[this.name] = '';
	        }
	    });
	    return o;
	}; 
	
	//将JSON对象直接加载到表单中，name属性要和JSON对象的key相同
	$.fn.loadJson = function(jsonValue) {
      var obj = this;
      $.each(jsonValue, function(name, ival) {
          var $oinput = obj.find("[name='" + name + "']");
          if ($oinput.attr("type") == "radio"
                  || $oinput.attr("type") == "checkbox") {
              $oinput.each(function() {
                  if (Object.prototype.toString.apply(ival) == '[object Array]') {//是复选框，并且是数组         
                  	for (var i = 0; i < $oinput.length; i++) {
                          if ($(this).val() == ival[i])
                              $(this).attr("checked", "checked");
                      }
                  } else {//否则是单选框
                      if ($(this).val() == ival)
                          $(this).attr("checked", "checked");
                  }
              });
          } else if ($oinput.attr("type") == "textarea") {//多行文本框            
              obj.find("[name='" + name + "']").html(ival);
          } else {
              obj.find("[name='" + name + "']").val(ival);
          }
      });
  }  
  //获取指定名称的cookie的值
function getCookie(objName){
	
	//alert(document.cookie);
    var arrStr = document.cookie.split("; ");
    //alert(arrStr);
    for(var i = 0;i < arrStr.length;i ++){
        var temp = arrStr[i].split("=");
        if(temp[0] == objName) return unescape(temp[1]);
   } 
}
//添加cookie
function addCookie(objName,objValue,objHours){      
    var str = objName + "=" + escape(objValue);
    if(objHours > 0){//为时不设定过期时间，浏览器关闭时cookie自动消失
        var date = new Date();
        var ms = objHours*3600*1000;
        date.setTime(date.getTime() + ms);
        str += "; expires=" + date.toGMTString() + ";path=/";
   }
   document.cookie = str;

}
//删除cookie
function delCookie(name){
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null) {
    	document.cookie= name + "="+cval+";expires="+exp.toGMTString()+ ";path=/";
    }
}
