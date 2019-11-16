package net.skhu.domain;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.transaction.Transactional;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;


//@ToString(exclude={"students","courses","professors"})
@EqualsAndHashCode(exclude={"posts"})
@Data
@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int user_idx;

	String email;
	String password;
	String nickname;
	String message;
	String auth_key;
	boolean user_auth;
	boolean manager;


	public User() {}
	public User(String email,String password, String nickname,String message,
			String auth_key,boolean user_auth,boolean manager) {
		this.email=email;
		this.password=password;
		this.nickname=nickname;
		this.message=message;
		this.auth_key=auth_key;
		this.user_auth=user_auth;
		this.manager=manager;
	}

	public String getEmail() {
		return email;
	}
	public String getPassword() {
		return password;
	}
	public String getNickname() {
		return nickname;
	}
	public String getAuth_key() {
		return auth_key;
	}
	public boolean getUser_auth() {
		return user_auth;
	}
	public boolean getManager() {
		return manager;
	}



	public void setEmail(String email) {
		this.email=email;
	}
	public void setPassword(String password) {
		this.password=password;
	}
	public void setNickname(String nickname) {
		this.nickname=nickname;
	}
	public void setMessage(String message) {
		this.message=message;
	}
	public void setAuth_key(String auth_key) {
		//		users2=new ArrayList<>();
		//		users3=new ArrayList<>();
		this.auth_key=auth_key;
	}
	public void setUser_auth(boolean user_auth) {
		this.user_auth=user_auth;
	}
	public void setManager(boolean manager) {
		this.manager=manager;
	}



	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Post> posts;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Comment> comments;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Reply> reply;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Post_like> post_likes;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Comment_like> comment_likes;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Reply_like> Reply_like;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	List<Song_like> song_likes;

	//    @JsonIgnore
	//    @OneToMany(mappedBy="user")
	//    List<Follow> follows;
	//
	//    @JsonIgnore
	//    @OneToMany(mappedBy="target_user")
	//    List<Follow> target_follows;
	//cascade = CascadeType.MERGE

	@JsonIgnore
	@ManyToMany
	@JoinTable(name="Follow",
	joinColumns=@JoinColumn(name="user_idx"),
	inverseJoinColumns=@JoinColumn(name="target_user_idx")
			)
	List<User> users2;

	@JsonIgnore
	@ManyToMany(mappedBy = "users2",fetch = FetchType.EAGER)
	List<User> users3;

	@Transactional
	public List<User> getUsers2() {
		return users2;
	}
	@Transactional
	public List<User> getUsers3() {
		return users3;
	}

	public void addFollower(User user1) {
		users2.add(user1); // 본인말고 상대방 저장됨
		user1.users3.add(this);
	}
	public void addFollowing(User user1) {
		user1.addFollower(this);
	}


	//	@ManyToMany
	//	@JoinTable(name="follow",
	//	 joinColumns=@JoinColumn(name="target_user_idx"),
	//	 inverseJoinColumns=@JoinColumn(name="user_idx")
	//	)
	//	List<User> users3;
}
