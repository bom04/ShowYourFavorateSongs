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
public class Follow {
	public Follow() {}
	public Follow(User user,User target_user) {
		System.out.println("에러1");
		this.user=user;
		this.target_user=target_user;
		System.out.println("에러2");
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int follow_id;

//	@ManyToOne
//	@JoinColumn(name = "user_idx")
//	User user;

//	@ManyToOne
//	@JoinFormula(value = "user_idx",referencedColumnName = "user_idx")
	@ManyToOne
	@JoinColumn(name = "user_idx")
	User user;

//	@ManyToOne
//	@JoinFormula(value = "user_idx",referencedColumnName = "user_idx")
	@ManyToOne
	@JoinColumn(name = "user_idx",insertable=false,updatable=false)
	User target_user;

	// @JoinColumnOrFormula(formula =@JoinFormula(value = "brand_cd",referencedColumnName = "brand_cd"))

}
