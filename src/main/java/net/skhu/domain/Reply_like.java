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
public class Reply_like {
	
	//기본키
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int like_id;
	
	@ManyToOne
	@JoinColumn(name = "reply_id")
	Reply reply;

	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;

}
