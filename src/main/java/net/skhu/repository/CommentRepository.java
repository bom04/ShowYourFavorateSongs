package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.Comment;

public interface CommentRepository extends JpaRepository<Comment,Integer>{
	@Query("select count(c) from Comment c where c.is_delete <> 1")
	int like_count(@RequestParam("comment_id") int comment_id);

}
