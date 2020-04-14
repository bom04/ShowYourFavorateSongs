package net.skhu;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class SocketTextHandler extends TextWebSocketHandler {

//	ArrayList<WebSocketSession> sessions = new ArrayList<>();
	HashMap<String, WebSocketSession> sessions = new HashMap<>();

	// client에서 메시지가 서버로 전송댈때 실행되는 함수, session에서 메시지를 수신했을때 실행됨
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		String payload = message.getPayload();

		try {
				// 접속된 모든 세션에 메시지 전송
				for (String key : sessions.keySet()) {
					WebSocketSession ss = sessions.get(key);
					ss.sendMessage(new TextMessage(payload));
				}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// connection이 맺어진 후 실행됨
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);

		sessions.put(session.getId(), session);
	}

	// close이후 실행됨
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session.getId());
		super.afterConnectionClosed(session, status);

	}

}