package net.skhu.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class Comment_like {
	
	//기본키
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int like_id;
	
	@ManyToOne
	@JoinColumn(name = "comment_id")
	Comment comment;

	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;

}
