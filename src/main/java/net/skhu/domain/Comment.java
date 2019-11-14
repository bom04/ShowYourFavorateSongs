package net.skhu.domain;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;

import org.springframework.data.annotation.CreatedDate;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@Entity
@EqualsAndHashCode(exclude = {"user","comment_likes","post","replies"})
@ToString(exclude = {"user","comment_likes","post","replies"})
public class Comment implements Comparable<Object>{

	//기본키
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int comment_id;

	String content;
	int is_delete;

	@CreatedDate
	Date date;

	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;

	@ManyToOne
	@JoinColumn(name = "post_id")
	Post post;

	@JsonIgnore
	@OneToMany(mappedBy="comment")
	List<Comment_like> comment_likes;

	@JsonIgnore
	@OneToMany(mappedBy="comment")
	@OrderBy("date asc") // date asc순대로 replies를 정렬할때 사용
	List<Reply> replies;

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		Comment c=(Comment)o;
		return this.date.compareTo(c.date);
	}

}
