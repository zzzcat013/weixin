<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String user = request.getParameter("user");
String xmid = request.getParameter("xmid");
String addrip = request.getParameter("addrip");
%>

<!DOCTYPE HTML>
<html>
  <head>     
    <title>秒杀</title>   
	<meta charset="utf-8">   
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    
 <link type="text/css" rel="stylesheet" href="file/css/reset.css">
 <link type="text/css" rel="stylesheet" href="file/css/default.css">
 <link type="text/css" rel="stylesheet" href="file/css/content.css">
    
	<script language="javascript" src="/weixin/pages/jquery.js"></script>
	<script language="javascript" src="/weixin/pages/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var cjarr = new Array();
var choujiang = true;


function onBridgeReady(){	
	//获取appId、timeStamp、nonceStr、package、signType、paySign
	var addrip = "<%=addrip%>";
	var userid = "<%=user%>";
	var appId;
	var timeStamp;
	var nonceStr;
	var signType;
	var packAge;
	var paySign;
	$.post('/weixin/cj/Cjaction!getParameter.action',{addrip:addrip,userid:userid},function(data)
	{
		var brandWCPayParameter =data[0];
		appId = brandWCPayParameter.appId;
		timeStamp = brandWCPayParameter.timeStamp;
		nonceStr = brandWCPayParameter.nonceStr;
		signType = brandWCPayParameter.signType;
		packAge = brandWCPayParameter.packAge;
		paySign = brandWCPayParameter.paySign;
		alert(paySign);
		WeixinJSBridge.invoke(
			'getBrandWCPayRequest', {
				"appId" : appId,     //公众号名称，由商户传入     
				"timeStamp": timeStamp,         //时间戳，自1970年以来的秒数     
				"nonceStr" : nonceStr, //随机串     
				"package" : packAge,     
				"signType" : signType,         //微信签名方式:     
				"paySign" : paySign    //微信签名 
			},
				      
			function(res){     
				if(res.err_msg == "get_brand_wcpay_request:ok" ) {
				    alert("支付成功");
				}     
			}
		); 
	},"json");
}
	
	
function order()
{
	//保存订单信息
	var addrip = "<%=addrip%>";
	var userid = "<%=user%>";
	var name = document.getElementById('name').value;
	var phonenumber = document.getElementById('phonenumber').value;
	var address = document.getElementById('address').value;
	var product = "高山黄桃";
	var reg = new RegExp("^[0-9]*$");
	if((!reg.test(phonenumber)) || (phonenumber.length != 11)){
		showAlert("输入的电话号码有误，请重新输入");
	}
	else
	{
		//获取appId、timeStamp、nonceStr、package、signType、paySign
		$.post('/weixin/cj/Cjaction!getParameter.action',{addrip:addrip,userid:userid},function(data)
		{
			var brandWCPayParameter =data[0];
			var appId = brandWCPayParameter.appId;
			var timeStamp = brandWCPayParameter.timeStamp;
			var nonceStr = brandWCPayParameter.nonceStr;
			var signType = brandWCPayParameter.signType;
			var packAge = brandWCPayParameter.packAge;
			var paySign = brandWCPayParameter.paySign;
			
			alert(paySign);
		},"json");
		
		/*
		$.post('/weixin/cj/Cjaction!saveOrder.action',{name:name,phoneNumber:phonenumber,address:address,product:product},function(data)
		{
		},"text");	
		showAlert("成功生成订单！感谢您的购买，我们将在48小时内发货！");
		*/
	}
}

//微信支付方法
function pay(){
	if (typeof WeixinJSBridge == "undefined"){
	   if( document.addEventListener ){
	       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	   }else if (document.attachEvent){
	       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	   }
	}else{
	   onBridgeReady();
	} 
}

function myrecord()
{
	var user = "<%=user%>";
	window.location.href='/weixin/pages/choujiangjilu.jsp?user='+user;
}

function mygift()
{
	var user = "<%=user%>";
	window.location.href='/weixin/pages/zhongjiangjilu.jsp?user='+user;
}

function prizelist()
{
	var user = "<%=user%>";
	window.location.href='/weixin/pages/0yuangou.jsp?user='+user;
}

function rule()
{
	var user = "<%=user%>";
	window.location.href='/weixin/pages/rule.jsp?user='+user;
}

Array.prototype.contains = function (element) { 
	for (var i = 0; i < this.length; i++) { 
        if (this[i] == element) { 
            return true; 
        } 
    } 
    return false; 
} 


function showAlert(str)
{
	var messContent="<div style='background:#eee;font-size:14px;line-height:1.5rem;padding:5px 10px 10px 10px;text-align:center;'>"+str+"</div>";  // 弹出提示框  
	messageBox.showMessageBox('',messContent,250); 
}

function showMessage5yuan(zjbm){  
	var messContent="<div style='font-size:16;padding:5px 10px 10px 10px;text-align:center;'>您的抽奖编号：</div>  <div style = 'font-size:24;color:#FF0000;text-align:center;'>"+zjbm+"<\div><div  style = 'font-size:22; color:#000000'>8月20日17点公布结果</div> <br/> <br/><div style = 'font-size:16;color:#000000'>同时恭喜您获三等奖</div><div><img src = '/weixin/pages/file/5yuan_xiao.jpg'/></div> <div style = 'font-size:16;color:#000000'>96360商城代金券5元</div>";  // 弹出提示框  
	messageBox.showMessageBox('',messContent,250); 
}

function showMessage10yuan(zjbm){  
	var messContent="<div style='font-size:16;padding:5px 10px 10px 10px;text-align:center;'>您的抽奖编号：</div>  <div style = 'font-size:24;color:#FF0000;text-align:center;'>"+zjbm+"<\div> <br/><div  style = 'font-size:22; color:#000000'>开奖日公布结果</div> <br/> <br/><div style = 'font-size:16;color:#000000'>获二等奖</div><div><img src = '/weixin/pages/file/10yuan_xiao.jpg'/></div> <div style = 'font-size:16;color:#000000'>96360商城代金券10元</div>";  // 弹出提示框  
	messageBox.showMessageBox('',messContent,250); 
}

function showMessageCJBH(zjbm){  
	var messContent="<div style='font-size:20;padding:5px 10px 10px 10px;text-align:center;'>您的抽奖编号：</div>  <div style = 'font-size:22;color:#FF0000;text-align:center;'>"+zjbm+"<\div> <br/><div  style = 'font-size:20; color:#000000'>开奖日公布结果</div>";  // 弹出提示框  
	messageBox.showMessageBox('',messContent,250); 
}



</script>

  </head>
  
  <BODY>
      <nav>收货地址</nav>
	<DIV class="main_container">
	
	<DIV id=u0_container class="u0_container">
	<DIV id="u0_img" class="u0_original"></DIV>
	<DIV id=u1 class="u1" >
	<DIV id=u1_rtf>&nbsp;</DIV></DIV>
	</DIV>
    
	<div class="content">
         <ol>
             <li>
                 <b>高山黄桃抢购</b>
             </li>
             <li>
                 <span>请输入您的姓名</span>
             </li>
         </ol>
     </div>
	
	 <input name="name" type="text" id="name" value="姓名" size="30"               
		 onmouseover=this.focus();this.select();              
		 onclick="if(value==defaultValue){value='';this.style.color='#000'}"              
		 onBlur="if(!value){value=defaultValue;this.style.color='#999'}" 
		 style="color:#999; position:relative;left:30px;width:100px;height:25px;font-size:16px" 
	 />
	 
	 <div class="content">
         <ol>
             <li>
                 <span>请输入您的手机号码</span>
             </li>
         </ol>
     </div>
	 
	 <input name="phonenumber" type="text" id="phonenumber" value="手机号码" size="30"               
		 onmouseover=this.focus();this.select();              
		 onclick="if(value==defaultValue){value='';this.style.color='#000'}"              
		 onBlur="if(!value){value=defaultValue;this.style.color='#999'}" 
		 style="color:#999; position:relative;left:30px;width:150px;height:25px;font-size:16px" 
	 />
	 
	 <div class="content">
         <ol>
             <li>
                 <span>请输入您的收货地址</span>
             </li>
         </ol>
     </div>
	 
	 <input name="address" type="text" id="address" value="地址" size="30"               
		 onmouseover=this.focus();this.select();              
		 onclick="if(value==defaultValue){value='';this.style.color='#000'}"              
		 onBlur="if(!value){value=defaultValue;this.style.color='#999'}" 
		 style="color:#999; position:relative;left:30px;width:250px;height:25px;font-size:16px" 
	 />
	 
	<div class="btn">
	<input onClick="pay()"  type="button"  value="立即秒杀"></input>
	</div>
	</DIV>
	</BODY>
	
</html>
