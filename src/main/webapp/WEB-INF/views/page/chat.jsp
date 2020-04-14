<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너18채팅방</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:url var="R" value="/" />

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${R}res/common.js"></script>
<link rel="stylesheet" href="${R}res/common.css">


<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script type="text/javascript">
	var textarea;
	var inputMessage;
	var ws;
	var me;
	var num; // 채팅방에 들어와있는 사람 수

    function onOpen(event) {
     }
	function connectWs() {
		num=1;
		textarea = document.getElementById("messageWindow");
		inputMessage= document.getElementById('inputMessage');
		ws=new WebSocket('ws://' + location.host + '/chat');
		me='${user.nickname}';
	    $("#_chatbox").css("display", "block"); // 채팅 시작했을때 안보이던 chatbox가 보이게
	    $("#_exit").css("display", "block");
	    ws.onmessage = function(event) {
	        onMessage(event);
	    };
		ws.onopen = function(event) {
			ws.send("<p style='background:#D8D8D8; padding:5px 0px; clear:both;'>"+me+"님이 채팅에 참여하였습니다.</p>");
			ws.send(me+'접속자 수 추가합니다');
			onOpen(event);
	     };
	     ws.onclose = function(event) { 
	     };
	     console.log('현재 접속자 수:'+num);
	     document.getElementById("peopleNum").innerHTML="현재 접속자 수:"+num;
		$('#startBtn').hide();
	}
	
	function onMessage(event) { 
        var message = event.data.split("|");
        var sender = message[0];
        var content = message[1];

        if (content == "") {
            
        } else if(sender.match(/님이 채팅에 참여하였습니다./)) { // 사람이 들어왔을때 화면에 뿌리기(나,상대방 둘 다에게)
        	if(!sender.match(me)) { // 채팅에 들어온 사람이 내가 아닐때
        		ws.send(me+'접속자 수 추가합니다');
            }
        	console.log(event.data);
			$("#messageWindow").html($("#messageWindow").html()
                    + "<p class='chat_content'>" + message +"</p>");
        } else if(sender.match(/님이 나가셨습니다./)) { // 사람이 나갔을때 화면에 뿌리기(나,상대방)
        	if(!sender.match(me)) { // 채팅에 나간 사람이 내가 아닐때
        		num--; // 현재 사람수를 줄임
    		    console.log('접속자 수:'+num);
    		    document.getElementById("peopleNum").innerHTML="현재 접속자 수:"+num;
            }
        	console.log(event.data);
			$("#messageWindow").html($("#messageWindow").html()
                    + "<p class='chat_content'>" + message +"</p>");
        } else if(sender.match(/접속자 수 추가합니다/)) { // (나,상대방)
            if(!sender.match(me)) { 
            	num++;
    		    console.log('접속자 수:'+num);
    		    document.getElementById("peopleNum").innerHTML="현재 접속자 수:"+num;
            }
			
        } else {
            if(sender!=me) { // 상대방이 보낸거 화면에 보여주기(상대방)
             $("#messageWindow").html($("#messageWindow").html()
                        + "<div class='card border-secondary mb-3' style='max-width: 30rem; margin-left:50px; float:left; text-align:left; clear:both; display:inline;'><div class='card-header'>" + sender + "<div class='card-body'><p class='card-text'>" + content + "</p></div></div></div>");
            }
        }
    }
	function disconnectWs() {
		ws.send("<p style='clear:both; background:#D8D8D8; padding:5px 0px;'>"+me+"님이 나가셨습니다.</p>");
		ws.close();
		$('#endBtn').hide();
		$('#peopleNum').hide();
		alert("채팅방에서 퇴장합니다")
		window.close();
	}

	function send() {
        if (inputMessage.value == "") {
        } else {
            $("#messageWindow").html($("#messageWindow").html()
                + "<div class='card text-white bg-primary mb-3' style='max-width: 30rem; margin-right:50px; float:right; text-align:right; clear:both; display:inline;'><div class='card-header'>나<div class='card-body'><p class='card-text'>" + inputMessage.value + "</p></div></div></div>");
        }
        ws.send(me + "|" + inputMessage.value);
        inputMessage.value = "";
    }
    // 엔터키를 눌러 send함
    function enterkey() {
        if (window.event.keyCode == 13) {
            send();
        }
    }
    window.setInterval(function() {
        var elem = document.getElementById('messageWindow');
        elem.scrollTop = elem.scrollHeight;
    }, 0);
    
    window.onbeforeunload = function() { //x 눌러서 나가도 나가기 적용시킴
    	disconnectWs();
    }


</script>

<body>
	<header>
		<div style="background:black; height:90px; padding:30px;"><h4 align="center" style="color:white;">★너의 18번을 들려줘 채팅방★</h4></div>
	</header>
	<button onclick="connectWs()" id="startBtn" type="button" class="btn btn-primary btn-lg btn-block" style="position:fixed; bottom:0;width:500px">채팅 시작하기</button>
	
	<div id="_chatbox" style="display: none; padding:20px 10px 20px;">
		<fieldset>
			<div id="messageWindow" style="text-align:center; display:inline; clear:both;"></div>
			
			<div style="border:1px solid #D8D8D8; padding:20px; margin-top:30px; text-align:center; clear:both;">
				<input class="form-control mr-sm-2" id="inputMessage" type="text" onkeyup="enterkey()" placeholder="메시지 입력" autofocus style="display:inline-block; width:80%"/>
				<button type="submit" class="btn btn-primary" onclick="send()" style="display:inline-block; border:0px;"/>보내기</button>
			</div>
			<div id="peopleNum" style="text-align:center;"></div>
		</fieldset>
    </div>
 
</body>
</html>