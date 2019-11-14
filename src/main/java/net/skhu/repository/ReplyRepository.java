package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import net.skhu.domain.Reply;

public interface ReplyRepository extends JpaRepository<Reply,Integer>{
//	@Query("select r from reply r where r.comment.comment_id=?1")
//	List<Reply> findRepliesByCommentId(int commentId);


}
