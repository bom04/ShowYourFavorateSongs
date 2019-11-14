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

@Data
@Entity
public class Song_like implements Comparable<Object> {
	public Song_like() {}
	public Song_like(Song song,User user,Date date) {
		// TODO Auto-generated constructor stub
		this.song=song;
		this.user=user;
		this.date=date;
	}
	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		Song_like c=(Song_like)o;
		return c.date.compareTo(this.date);
	}
	//기본키
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int like_id;

	@CreatedDate
	Date date;

	@ManyToOne
	@JoinColumn(name = "song_id")
	Song song;

	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;
}
