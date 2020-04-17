<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>채팅방</title>
</head>

<script type="text/javascript">

	var ws;
	var me;
	function connectWs() {
		ws = new WebSocket('ws://' + location.host + '/chat');
		me='${user.nickname}';
		ws.onopen = function() {
           //ws.send('========'+me+'님이 입장하셨습니다.========');
         }
		ws.onmessage = function(data) {
			console.log(data.data);
			$("<p>"+data.data+"</p>").prependTo('#chat');
		}
		$('#startBtn').hide();
	}

	function disconnectWs() {
		ws.onclose = function(data) { 
			
      	}
		//ws.send('========'+me+'님이 나가셨습니다.========');
		
		ws.close();
		$('#endBtn').hide();
	}



	function send() {
		ws.send('${user.nickname}: '+$("#chatting").val());
		$('#chatting').val("");
	}
</script>

<body>

	<h1>채팅 방 입니다</h1>
	<button onclick="connectWs()" id="startBtn"> 채팅 시작하기</button>
	<input id="chatting"></input><button onclick="send()"> 보내기 </button>
	<div>
		<p id="chat"></p>
	</div>
	<button onclick="disconnectWs()" id="endBtn"> 나가기</button>
</body>
</html>