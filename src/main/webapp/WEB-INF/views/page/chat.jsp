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
   var list; // 접속한 사람 목록(중복있음)
   var final_data; // 접속자 명단 중복 제거

   function onOpen(event) {
   }
   function connectWs() {
      list='';
      final_data = []; 
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
       $("#bg_img").css("display", "none");
      ws.onopen = function(event) {
         ws.send("<p style='background:#D8D8D8; padding:5px 0px; clear:both;'>"+me+"님이 채팅에 참여하였습니다.</p>");
         ws.send(me+'접속자 수 추가합니다');
         ws.send('접속자 명단,'+me);
         onOpen(event);
        };
        ws.onclose = function(event) { 
        };
        console.log('현재 접속자 수:'+num);
        console.log(final_data);
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
              ws.send('접속자 명단,'+me);
            }
           console.log(event.data);
         $("#messageWindow").html($("#messageWindow").html()
                    + "<p class='chat_content'>" + message +"</p>");
        } else if(sender.match(/님이 나가셨습니다./)) { // 사람이 나갔을때 화면에 뿌리기(나,상대방)
           if(!sender.match(me)) { // 채팅에 나간 사람이 내가 아닐때
              num--; // 현재 사람수를 줄임
              console.log('접속자 수:'+num);
              final_data = $.grep(final_data,function(n){ return n == " " || n; }); // 배열 빈요소 제거
              let outUser=sender.split('님이 나가셨습니다.')[0];
              final_data.splice(final_data.indexOf(outUser),1); // "A"를 찾아서 삭제한다.
              console.log('나감');
              console.log(final_data);
              document.getElementById("peopleNum").innerHTML="현재 접속자 수:"+num;
              let peopleList='';
              for(let i=0;i<final_data.length;i++) {
                    peopleList+=final_data[i]+"<br>";
              }
              document.getElementById("peopleName").innerHTML=peopleList;
            }
           console.log(event.data);
         $("#messageWindow").html($("#messageWindow").html()
                    + "<p class='chat_content'>" + message +"</p>");
        } else if(sender.match(/접속자 수 추가합니다/)) { // (나,상대방)
            if(!sender.match(me)) { 
               num++;
              console.log('접속자 수:'+num);
              document.getElementById("peopleNum").innerHTML="현재 접속자 수:"+num;
               let peopleList='';
              for(let i=0;i<final_data.length;i++) {
                    peopleList+=final_data[i]+"<br>";
              }
              document.getElementById("peopleName").innerHTML=peopleList;
            }
        } else if(sender.match(/접속자 명단,/)) {
           list+=sender.split('접속자 명단,')[1]+'<br>';
           let list_array=list.split('<br>');
           $.each(list_array,function(i,value){
               if(final_data.indexOf(value) == -1 ) final_data.push(value);
           });
           final_data = $.grep(final_data,function(n){ return n == " " || n; }); // 배열 빈요소 제거
          console.log(final_data);
           let peopleList='';
              for(let i=0;i<final_data.length;i++) {
                    peopleList+=final_data[i]+"<br>";
              }
          document.getElementById("peopleName").innerHTML=peopleList;
        }  else {
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
      <div style="background:black; height:90px; padding:30px;"><h4 align="center" style="color:white;">🎤너의 18번을 들려줘 채팅방</h4></div>
   </header>
   
   <section>
      <div id="bg_img" style="background-image:url('${pageContext.request.contextPath}/res/images/chat.gif'); height:86%; background-repeat: no-repeat; background-size: cover; 
            background-attachment: fixed;"></div>
      <button onclick="connectWs()" id="startBtn" type="button" class="btn btn-primary btn-lg btn-block" style="position:fixed; bottom:0;">채팅 시작하기</button>

      <div id="_chatbox" style="display: none; padding:20px 10px 100px;">
         <fieldset>
            <div id="messageWindow" style="text-align:center; display:inline; clear:both;"></div>
            
            <div style="border:1px solid #D8D8D8; padding:20px; margin-top:320px; text-align:center; clear:both;">
               <input class="form-control mr-sm-2" id="inputMessage" type="text" onkeyup="enterkey()" placeholder="메시지 입력" autofocus style="display:inline-block; width:80%"/>
               <button type="submit" class="btn btn-primary" onclick="send()" style="display:inline-block; border:0px;"/>보내기</button>
            </div>
            <div style="text-align:center; margin-top:30px;">
               <div id="peopleNum" style="display:inline-block; margin-right:20px;"></div>
               <button type="button" class="btn btn-primary" id="myBtn2">참여자 보기</button>
            </div>
         </fieldset>
       </div>
      
   </section>
   
         <div class="modal" id="myModal2" style="top:200px;">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     현재 채팅 참여자
                  </div>
      
                  <div class="modal-body">
                     <div id="peopleName"></div>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                  </div>
               </div>
            </div>
         </div>

   
</body>
