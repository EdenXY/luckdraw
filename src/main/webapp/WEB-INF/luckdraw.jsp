<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctx = request.getContextPath();
	request.setAttribute("ctx", ctx);
%>
<html>

	<head>
		<title>中奖</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<!--<link rel="shortcut icon" href="images/favicon.ico">-->
		<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/awardDetail.css" />
	</head>

	<body>
		<audio class="fireworkSound" src="${ctx}/resources/sound/8028.mp3"></audio>
		<div class="con">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
				<c:if test="${not empty luvo}">
				<tr>
					<td align="center" style="padding-top:30%; color:#f00; font-size:1.4em;">恭喜您！<br>
						<p style="font-size:1.8em;">${luvo.awardsname}</p>
					</td>
				</tr>
				</c:if>
				<tr>
					<!-- <td align="center" valign="bottom">
						<div class="btn_cj">
							<a href="#">返回首页</a>
						</div>
					</td> -->
				</tr>
			</table>
		</div>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:3%;">
			<tr>
				<td class="td_border" id="syawards">
					<P>剩余奖项</P>
					<c:forEach items="${awardsMap}" var="entry" varStatus="vs">
						${entry.value.name}:<span>${entry.value.description}</span>元(<span style="color: white;" id="count${entry.key}" data-count="${entry.value.count}">${entry.value.count}</span>个)
						<c:if test="${not vs.last}">&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td class="td_border">
					<P>已中奖名单</P>

					<div id="awards1" class="sy_div">
					
					</div>

					<div id="awards2" class="sy_div">
						
					</div>

					<div id="awards3" class="sy_div">
						
					</div>

					<div id="awards4" class="sy_div">
						
					</div>

					<div id="awards5" class="sy_div">
						
					</div>
				</td>
			</tr>
		</table>
		<script src="${ctx}/resources/js/mui.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			/* mui.ready(function() {
				mui('table').on('tap', '.btn_cj', function() {
					//					alert(1)
					window.location.href = "index.html";
				})
			}) */
		</script>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-3.2.1.min.js"></script>
		<script src="${ctx}/resources/js/firework.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function() {
				var celebrateFireworks = function() {
					var cw = $(window).innerWidth();
					var ch = $(window).innerHeight();
					var coordinatesArr = [];
					//						Math.floor(Math.random()*(max-min+1)+min);
					for(var i = 0; i < 20; i++) {
						var coordinates = {};
						coordinates.x = Math.floor(Math.random() * (cw - 0 + 1) + 0);
						coordinates.y = Math.floor(Math.random() * (ch * 0.2 - 0 + 1) + 0);
						coordinatesArr.push(coordinates);
					}
					//						console.log("cw:" + cw);
					//						console.log("ch:" + ch);
					//						console.log("coordinatesArr:", coordinatesArr);
					for(var i = coordinatesArr.length - 1; i >= 0; i--) {
						var timeInterval = 0;
						//							console.log("timeInterval:" + timeInterval);
						(function(index) {
							timeInterval = Math.floor(Math.random() * (500 - 100 + 1) + 100);
							//								console.log("timeInterval:", timeInterval);
						})(i);
						(function(index) {
							setTimeout(function() {
								var coordinates = coordinatesArr[index];
								fworks.createFireworks(cw / 2, ch, coordinates.x, coordinates.y);
								playFireworkSound();
								if(index == 0) { // 放完烟花后清除canvas
									fworks.clear();
								}
							}, timeInterval * (coordinatesArr.length - 1 - index))
						})(i);
					}
				}
				celebrateFireworks();
			});
			var playFireworkSound = function() {
				var music = document.querySelector('audio.fireworkSound');
				if(music.paused) {
					music.play();
				} else {
					//					music.pause();
				}
			}
			
			
			window.onload=function(){
				//假设这里每隔三秒执行一次函数
				getLuckusers();
			} 
			
			function getLuckusers() {
				setTimeout(getLuckusers, 3000);
				$.ajax({
					  type : "POST",
					  async : false, //同步请求
					  url : "${ctx}/luckuser/list",
					  timeout:10000,
					  success:function(json){
						  if (200 == json["code"]) {
							  var data = json["data"] || '[]';
							  var li1 = '<div class="tittle" style="background:#dccae3;">特等奖</div>',
							  	li2 = '<div class="tittle" style="background:#fdf4c6;">一等奖</div>',
							  	li3 = '<div class="tittle" style="background:#fcdfbe;">二等奖</div>',
							  	li4 = '<div class="tittle" style="background:#e5d1bb;">三等奖</div>',
							  	li5 = '<div class="tittle" style="background:#e2e2e2;">四等奖</div>';
							  var ac1=0, ac2=0, ac3=0, ac4=0, ac5=0; 
							  var div = '';
							  for(var i=0; i<data.length; i++) {
								  div = '<div class="wx_box"><div class="name"><div class="name_img"><img src="'+data[i]["headimgurl"]+'"></div><div class="name_font">'+data[i]["username"]+'</div><div class="clear"></div></div></div>';
								  if (1 == data[i]["awardsid"]) {
									  li1 += div;
									  ac1++;
								  } else if (2 == data[i]["awardsid"]) {
									  li2 += div;
									  ac2++;
								  } else if (3 == data[i]["awardsid"]) {
									  li3 += div;
									  ac3++;
								  } else if (4 == data[i]["awardsid"]) {
									  li4 += div;
									  ac4++;
								  } else if (5 == data[i]["awardsid"]) {
									  li5 += div;
									  ac5++;
								  }
							  }
							  li1 += '<div class="clear"></div>',
							  li2 += '<div class="clear"></div>',
							  li3 += '<div class="clear"></div>',
							  li4 += '<div class="clear"></div>';
							  li5 += '<div class="clear"></div>',
							  $("#awards1").html(li1);
							  $("#awards2").html(li2);
							  $("#awards3").html(li3);
							  $("#awards4").html(li4);
							  $("#awards5").html(li5);
							  
							  $("#count1").html($("#count1").attr("data-count") - ac1);
							  $("#count2").html($("#count2").attr("data-count") - ac2);
							  $("#count3").html($("#count3").attr("data-count") - ac3);
							  $("#count4").html($("#count4").attr("data-count") - ac4);
							  $("#count5").html($("#count5").attr("data-count") - ac5);
							  
//							  $("#syawards").html('<P>剩余奖项</P>特等奖:<span>1800</span>元('+(1-ac0)+'个)&nbsp;&nbsp;&nbsp;&nbsp;一等奖:<span>1000</span>元('+(2-ac1)+'个)&nbsp;&nbsp;&nbsp;&nbsp;二等奖:<span>600</span>元('+(4-ac2)+'个)&nbsp;&nbsp;&nbsp;&nbsp;三等奖:<span>388</span>元('+(10-ac3)+'个)&nbsp;&nbsp;&nbsp;&nbsp;四等奖:<span>268</span>元('+(15-ac4)+'个)');
						  }
					  },
					  error: function() {
					        // alert("失败，请稍后再试！");
					  }
				});
			}
		</script>
	</body>

</html>