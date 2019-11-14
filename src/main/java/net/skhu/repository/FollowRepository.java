package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.domain.Follow;

public interface FollowRepository extends JpaRepository<Follow, Integer>{

//	@Transactional
//	@Modifying
//	@Query("insert into follow values(my_user_idx,user_idx)")
//	void insertFollow(@RequestParam("my_user_idx") int my_user_idx,@RequestParam("user_idx") int user_idx);
}
