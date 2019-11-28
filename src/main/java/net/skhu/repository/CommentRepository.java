package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import net.skhu.domain.Comment;

public interface CommentRepository extends JpaRepository<Comment,Integer>{
	
	//유저 페이지: 댓글
	@Query("select c from Comment c where c.user.user_idx=:user_idx and c.is_delete=0")   //유저가 쓴 댓글 찾기
	List<Comment> findUserComment(int user_idx);
	
	@Query("select count(c) from Comment c where c.user.user_idx=:user_idx and c.is_delete=0")  //카운팅
	int countUserComment(int user_idx);

}
