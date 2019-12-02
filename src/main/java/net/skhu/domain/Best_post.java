package net.skhu.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import java.util.Date;

import lombok.Data;

@Table(name="best_post")
@Data
@Entity
public class Best_post implements Comparable<Object>{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int like_id;
	
	//int post_id;
	Date date;
	
	@Override
	public int compareTo(Object o) {
		Best_post p=(Best_post)o;
		return p.date.compareTo(this.date);
	}
	
	@OneToOne
	@JoinColumn(name = "post_id")
	Post post;
}
