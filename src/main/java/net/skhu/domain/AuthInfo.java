package net.skhu.domain;

//회원 정보 세션 유지
public class AuthInfo {

	private int user_idx;
	private String email;
	private String password;
	private String message;
	private String nickname;
	private String user_auth;

	public AuthInfo(int user_idx, String email, String password) {
		//      this.id = id;
		//      this.name = name;
		//      this.grade = grade;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUser_auth() {
		return user_auth;
	}

	public void setUser_auth(String user_auth) {
		this.user_auth = user_auth;
	}


}
