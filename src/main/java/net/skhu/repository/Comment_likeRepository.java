package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.Comment_like;

public interface Comment_likeRepository extends JpaRepository<Comment_like,Integer>{
	@Query("select c from Comment_like c where c.comment.comment_id=:comment_id and c.user.user_idx=:user_idx")
	Comment_like findExistComment_like(@RequestParam("comment_id") int comment_id,@RequestParam("user_idx") int user_idx);
	
	@Query("select count(c) from Comment_like c where c.comment.comment_id=:comment_id")
	int like_count(@RequestParam("comment_id") int comment_id);
	
	//comment_id에 해당하는 코멘트 좋아하는 유저들의 user_idx
	@Query("select c.user.user_idx from Comment_like c where c.comment.comment_id=:comment_id")
	List<Integer> like_user(@RequestParam("comment_id") int comment_id);
	
	@Transactional
	@Modifying
	@Query("DELETE FROM Comment_like c WHERE c.comment.comment_id=:comment_id and c.user.user_idx=:user_idx")
	void deleteComment_like(@RequestParam("comment_id") int comment_id,@RequestParam("user_idx") int user_idx);

}
