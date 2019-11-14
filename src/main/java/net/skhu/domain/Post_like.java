package net.skhu.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.springframework.data.annotation.CreatedDate;

import lombok.Data;

//@EqualsAndHashCode(exclude = {"posts"})
//@ToString(exclude = {"posts"})
@Data
@Entity
public class Post_like {
	public Post_like() { }

	public Post_like(Post post,User user,Date date) {
		// TODO Auto-generated constructor stub
		this.post=post;
		this.user=user;
		this.date=date;
	}
	//기본키
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int like_id;

	@CreatedDate
	Date date;

	@ManyToOne
	@JoinColumn(name = "post_id")
	Post post;

	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;

}
