package net.skhu.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Entity
@NoArgsConstructor
public class Follow {
	//	public Follow() {}
	//	public Follow(User my_user,User target_user) {
	//		System.out.println("에러1");
	//		this.my_user=my_user;
	//		this.target_user=target_user;
	//		System.out.println("에러2");
	//	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	@OrderBy("follow_id")
	int follow_id;

	//	@ManyToOne
	//	@JoinColumn(name = "user_idx")
	//	User user;

	//	@ManyToOne
	//	@JoinFormula(value = "user_idx",referencedColumnName = "user_idx")
	//	@ManyToOne
	//	@JoinColumn(name = "my_user")
	//	User my_user;

	//	@ManyToOne
	//	@JoinFormula(value = "user_idx",referencedColumnName = "user_idx")
	//	@ManyToOne
	//	@JoinColumn(name = "target_user")
	//	User target_user;

	// @JoinColumnOrFormula(formula =@JoinFormula(value = "brand_cd",referencedColumnName = "brand_cd"))

}
