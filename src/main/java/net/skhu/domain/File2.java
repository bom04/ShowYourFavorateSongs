package net.skhu.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Table(name="file")
@Data
@Entity
@EqualsAndHashCode(exclude = {"post"})
@ToString(exclude = {"post"})
public class File2 {
	
	public File2() {
		
	}
	public File2(String file_name, Post post) {
		// TODO Auto-generated constructor stub
		this.file_name=file_name;
		this.post=post;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int file_id;
	
	String file_name;
	
	@ManyToOne
	@JoinColumn(name = "post_id")
	Post post;
	

}
