package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.skhu.domain.Follow;

public interface FollowRepository extends JpaRepository<Follow, Integer>{

//	@Query("select f from Follow f where f.user.user_idx=:user_idx")
//	Follow findByUser_idxAndTarget(int user_idx);


}
