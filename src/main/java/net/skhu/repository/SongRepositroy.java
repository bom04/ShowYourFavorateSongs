package net.skhu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.Song;

public interface SongRepositroy extends JpaRepository<Song,Integer>{
	List<Song> findByTitleIgnoreCaseContaining(String title);
	List<Song> findBySingerIgnoreCaseContaining(String singer);

	@Query("select s from Song s where s.song_num=:song_num and kara_type=:kara_type")
	Song findBySongNumAndKara_Type(@RequestParam("song_num") int song_num,@RequestParam("kara_type") int kara_type);

//	Song findBySong_numAndKara_type(int song_num,int kara_type);
}
