package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.Post_like;

public interface Post_likeRepository extends JpaRepository<Post_like, Integer>{
	@Query("select p from Post_like p where p.post.post_id=:post_id and p.user.user_idx=:user_idx")
	Post_like findExistPost_like(@RequestParam("post_id") int post_id,@RequestParam("user_idx") int user_idx);

	@Query("select count(p) from Post_like p where p.post.post_id=:post_id")
	int findPost_like_num(@RequestParam("post_id") int post_id);

	@Transactional
	@Modifying
	@Query("DELETE FROM Post_like p WHERE p.post.post_id=:post_id and p.user.user_idx=:user_idx")
	void deletePost_like(@RequestParam("post_id") int post_id,@RequestParam("user_idx") int user_idx);
}
