package net.skhu.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import net.skhu.domain.Best_post;

public interface Best_postRepository extends JpaRepository<Best_post,Integer>{
	@Query("select b from Best_post b where b.post.board.board_id=:board_id")
	List<Best_post> findByBoard(int board_id);
}
