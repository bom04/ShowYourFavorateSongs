package net.skhu.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Table(name="rank_TJ")
@Data
@Entity
public class Rank_TJ {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int song_id;
	
	int song_num;
	String title;
	String singer;
	int likenum;
}
