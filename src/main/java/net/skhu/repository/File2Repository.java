package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.File2;
import net.skhu.domain.Post;

public interface File2Repository extends JpaRepository<File2, Integer>{
	List<File2> findAllByPost(Post post);
	
	@Query("select f.post.post_id from File2 f where f.file_id=:file_id")
	int findPostByFile(@RequestParam("file_id") int file_id);

}
