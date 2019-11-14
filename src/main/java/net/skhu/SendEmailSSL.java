package net.skhu;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmailSSL { // 이메일 보내기 위해 만든 클래스
	final String username = "iris21kr@gmail.com"; // 이메일을 보낼 계정 쓰기
	final String password = "dnqls13579"; // 이메일을 보낼 계정의 비밀번호 쓰기(실제 이메일,비밀번호 안쓰면 에러)
	Properties prop;

	public SendEmailSSL() {
		prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	}
	public void sendEmail(String toEmail,String auth_key) {
		Session session = Session.getInstance(prop,
				new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});


		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("iris21kr0@gmail.com"));
			message.setRecipients(
					Message.RecipientType.TO,
					InternetAddress.parse(toEmail) // 받는 사람 email
					);
			message.setSubject("이메일 인증");
			message.setText(new StringBuffer().append("아래의 링크를 눌러 회원가입 인증을 완료하세요.\n")
					.append("http://localhost:8080/page/join_success?auth_key=")
					.append(auth_key)
					.toString());
			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public void sendPwChange(String toEmail,String auth_key) {
		Session session = Session.getInstance(prop,
				new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});


		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("iris21kr0@gmail.com"));
			message.setRecipients(
					Message.RecipientType.TO,
					InternetAddress.parse(toEmail) // 받는 사람 email
					);
			message.setSubject("비밀번호 변경");
			message.setText(new StringBuffer().append("아래의 링크를 눌러 비밀번호를 바꾸세요.\n")
					.append("http://localhost:8080/page/changePw?auth_key=")
					.append(auth_key)
					.toString());
			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
