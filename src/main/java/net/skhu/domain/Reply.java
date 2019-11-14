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

import org.springframework.data.annotation.CreatedDate;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@Entity
@EqualsAndHashCode(exclude = {"user","reply_likes","comment"})
@ToString(exclude = {"user","reply_likes","comment"})
public class Reply implements Comparable<Object>{
	
	//기본키
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int reply_id;
	
	String content;

	@CreatedDate
	Date date;
	
	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;
	
	@ManyToOne
	@JoinColumn(name = "comment_id")
	Comment comment;
	
	@JsonIgnore
	@OneToMany(mappedBy="reply")
	List<Reply_like> reply_likes;

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		Reply p=(Reply)o;
		return p.date.compareTo(this.date);
	}

}
