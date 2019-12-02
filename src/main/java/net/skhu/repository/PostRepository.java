package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.Post;

public interface PostRepository extends JpaRepository<Post, Integer>{
	@Transactional
	@Modifying
	@Query(value="update Post p set p.view=p.view+1 where post_id=:post_id",nativeQuery=true)
	void updateView(@RequestParam("post_id") int post_id);


	@Transactional
	@Modifying
	@Query(value="update Post p set p.title=:title,p.content=:content where post_id=:post_id",nativeQuery=true)
	void updateByPost_id(@RequestParam("title") String title,@RequestParam("content") String content, @RequestParam("post_id") int post_id);

	//검색
	@Query("select p from Post p where p.board.board_id<>5 AND (p.user.nickname like concat('%',:nickname,'%') OR p.title like concat('%',:title,'%'))")   //전체검색
	List<Post> findPostsByNicknameOrTitle(String nickname, String title);
	
	@Query("select p from Post p where p.board.board_id<>5 AND p.user.nickname like concat('%',:nickname,'%')")   //작성자 닉네임으로 검색
	List<Post> findPostsByNickname(String nickname);
	
	@Query("select p from Post p where p.board.board_id<>5 AND p.title like concat('%',:title,'%')")   //제목으로 검색
	List<Post> findPostsByTitle(String title);
	
	//유저 페이지: 포스트
	@Query("select p from Post p where p.user.user_idx=:user_idx")   //유저가 쓴 글 찾기
	List<Post> findUserPost(int user_idx);
	
	@Query("select count(p) from Post p where p.user.user_idx=:user_idx")
	int countUserPost(int user_idx);
	
	@Query("select p from Post p where p.post_id=:post_id AND p.board.board_id=:board_id")
	Post findByIdAndBoard_Id(int post_id, int board_id);

}
