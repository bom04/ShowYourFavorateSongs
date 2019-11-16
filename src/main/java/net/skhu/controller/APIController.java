package net.skhu.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.skhu.SendEmailSSL;
import net.skhu.TempAuth_key;
import net.skhu.domain.Board;
import net.skhu.domain.Comment;
import net.skhu.domain.Comment_like;
import net.skhu.domain.File2;
import net.skhu.domain.Post;
import net.skhu.domain.Post_like;
import net.skhu.domain.Reply;
import net.skhu.domain.Song;
import net.skhu.domain.Song_like;
import net.skhu.domain.User;
import net.skhu.repository.BoardRepository;
import net.skhu.repository.CommentRepository;
import net.skhu.repository.Comment_likeRepository;
import net.skhu.repository.File2Repository;
import net.skhu.repository.FollowRepository;
import net.skhu.repository.PostRepository;
import net.skhu.repository.Post_likeRepository;
import net.skhu.repository.ReplyRepository;
import net.skhu.repository.Reply_likeRepository;
import net.skhu.repository.SongRepositroy;
import net.skhu.repository.Song_likeRepository;
import net.skhu.repository.UserRepository;


@Controller
@RequestMapping("/page")
public class APIController {
	@Autowired
	UserRepository userRepository;
	@Autowired
	BoardRepository boardRepository;
	@Autowired
	File2Repository fileRepository;

	@Autowired
	PostRepository postRepository;
	@Autowired
	Post_likeRepository post_likeRepository;

	@Autowired
	CommentRepository commentRepository;
	@Autowired
	Comment_likeRepository comment_likeRepository;

	@Autowired
	ReplyRepository replyRepository;
	@Autowired
	Reply_likeRepository reply_likeRepository;
	@Autowired
	SongRepositroy songRepositroy;
	@Autowired
	Song_likeRepository song_likeRepository;
	@Autowired
	FollowRepository followRepository;
	//가입
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String join(Model model) {
		List<User> users = userRepository.findAll();
		model.addAttribute("users", users);
		// System.out.println("갯수:"+users.size());
		return "page/join";
	}

	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String join2(Model model, User user) {
		String auth_key = new TempAuth_key().getKey(45, false);
		SendEmailSSL es = new SendEmailSSL();
		// if(userRepositroy.findByEmail(user.getEmail())==null
		// &&userRepositroy.findByNickname(user.getNickname())==null) {
		userRepository
		.save(new User(user.getEmail(), user.getPassword(), user.getNickname(), null, auth_key, false, false));
		es.sendEmail(user.getEmail(), auth_key); // 받는 사람 이메일
		return "redirect:joinNext";
	}

	@RequestMapping(value = "joinNext", method = RequestMethod.GET)
	public String edit(Model model) {
		int max = userRepository.findMaxUser_idx();
		Optional<User> optinalEntity = userRepository.findById(max);
		User user = optinalEntity.get();
		model.addAttribute("user", user);
		return "page/joinNext";
	}

	@RequestMapping(value = "join_success", method = RequestMethod.GET)
	public String join_success(Model model, @RequestParam("auth_key") String auth_key) {
		User user = userRepository.findByAuth_key(auth_key);
		user.setAuth_key(user.getEmail());
		userRepository.updateAuth_key(user.getEmail());
		return "page/join_success";
	}

	@RequestMapping(value = "findPw", method = RequestMethod.GET)
	public String findPw(Model model, User user) {
		List<User> users = userRepository.findAll();
		model.addAttribute("users", users);
		return "page/findPw";
	}

	@RequestMapping(value = "findPw", method = RequestMethod.POST)
	public String findPw2(Model model, @RequestParam("email") String email) {
		User user = userRepository.findByEmail(email);
		SendEmailSSL es = new SendEmailSSL();
		// if(userRepositroy.findByEmail(user.getEmail())==null
		// &&userRepositroy.findByNickname(user.getNickname())==null) {
		es.sendPwChange(user.getEmail(), user.getAuth_key());
		return "redirect:findPwNext";
	}

	@RequestMapping(value = "changePw", method = RequestMethod.GET)
	public String changePw(Model model, @RequestParam("auth_key") String auth_key) {
		return "page/changePw";
	}

	@RequestMapping(value = "changePw", method = RequestMethod.POST)
	public String changePw2(Model model, @RequestParam("auth_key") String auth_key,
			@RequestParam("password") String password) {
		User user = userRepository.findByAuth_key(auth_key);
		userRepository.updatePassword(user.getEmail(), password);//auth키 수정?
		return "redirect:changePwNext";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(Model model) {
		List<User> users = userRepository.findAll();
		model.addAttribute("users", users);
		return "page/login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView login2(@Valid User user, BindingResult bindingResult, HttpSession session,
			HttpServletResponse response) throws Exception {
		if (bindingResult.hasErrors()) {
			ModelAndView mv = new ModelAndView("page/login");
			return mv;
		}
		User user2 = userRepository.findByEmail(user.getEmail());
		session.setAttribute("user", user2);

		Cookie rememberCookie = new Cookie("REMEMBER", user2.getEmail());
		rememberCookie.setPath("/");
		response.addCookie(rememberCookie);
		ModelAndView mv = new ModelAndView("redirect:home");
		return mv;

	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public ModelAndView logtout(HttpSession session) {
		session.invalidate();
		ModelAndView mv = new ModelAndView("redirect:home");
		return mv;
	}

	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String list() {
		return "page/home";
	}

	@RequestMapping(value = "changePwNext", method = RequestMethod.GET)
	public String changePwNext() {
		return "page/changePwNext";
	}
	@RequestMapping(value = "searchingSong/{kara_type}", method = RequestMethod.GET)
	public String searching2(Model model, @PathVariable("kara_type") int kara,@RequestParam("keyword") String keyword) throws UnsupportedEncodingException {
		keyword=URLEncoder.encode(keyword, "UTF-8");
		return "redirect:/page/searchingSong?keyword="+keyword+"&kara_type="+kara;
	}
	@RequestMapping(value = "searchingSong", method = RequestMethod.GET)
	public String searching(Model model, @RequestParam("keyword") String keyword,@RequestParam("kara_type") int kara) {
		List<Song> list=songRepositroy.findBySingerIgnoreCaseContaining(keyword);
		list.addAll(songRepositroy.findByTitleIgnoreCaseContaining(keyword));
		List<Song> result=new ArrayList<>();
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getKara_type()==kara)
				result.add(list.get(i));
		}
		model.addAttribute("kara",kara);
		model.addAttribute("keyword",keyword);
		model.addAttribute("songList",result);
		return "page/searchingSong";
	}
	@RequestMapping(value = "addSong", method = RequestMethod.GET)
	public String addSong(Model model,@RequestParam("keyword") String keyword,@RequestParam("kara_type") int kara_type,@RequestParam("song_num") int song_num,final HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		keyword=URLEncoder.encode(keyword, "UTF-8");
		Song song=songRepositroy.findBySongNumAndKara_Type(song_num,kara_type);
		// Song_like s=song_like.get();
		System.out.println("addsong");
		User user = (User) session.getAttribute("user");
		if(user==null) {
			return "redirect:/page/login";
		}
		System.out.println("song_id:"+song.getSong_id());
		Song_like song_like=song_likeRepository.ExistBySong_id(song.getSong_id());
		if(song_like==null) {
			song_likeRepository.save(new Song_like(song,user,new Date()));
		}
		else {
			System.out.println("이미있는곡");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('이미 추가된 곡입니다.');history.go(-1);</script>");
			out.flush();
		}
		return "redirect:/page/searchingSong?keyword="+keyword+"&kara_type="+kara_type;
	}

	@RequestMapping(value = "deleteSong", method = RequestMethod.GET)
	public String deleteSong(Model model,@RequestParam("user_idx") int user_idx,@RequestParam("kara_type") int kara_type,@RequestParam("sort") int sort,@RequestParam("song_id") int song_id) {
		song_likeRepository.deleteSong(song_id,user_idx);
		return "redirect:/page/user?user_idx="+user_idx+"&kara_type="+kara_type+"&sort="+sort;
	}
	@RequestMapping(value = "follow", method = RequestMethod.GET)
	public String follow(Model model,@RequestParam("user_idx") int user_idx,@RequestParam("kara_type") int kara_type,@RequestParam("sort") int sort,@RequestParam("my_user_idx") int my_user_idx) {
		if(my_user_idx==-1)
			return "redirect:/page/login";
		Optional<User> other_user=userRepository.findById(user_idx);
		Optional<User> my_user=userRepository.findById(my_user_idx);
		User my_user1=my_user.get();
		User other_user1=other_user.get();


		my_user1.addFollower(other_user1);
		// userRepository.save(other_user1); // 근데 왜 follow의 id 번호값이 들쑥날쑥하지?무더기로 저장되기도 하고 참...
		userRepository.save(my_user1);
		System.out.println("크기:"+my_user1.getUsers3().size());
		//		for(int i=0;i<my_user1.getUsers2().size();i++) { // my_user1와 other_user1하고 size()가 다름
		//			if(my_user1.getUsers2().get(i).getUser_idx()==other_user1.getUser_idx()) { // 팔로우를 이미 한 사람이면
		//
		//			}
		//			System.out.println("내가 팔로우한 상대방 id: "+my_user1.getUsers2().get(i).getUser_idx()); // 내가 팔로우한 target_user_idx를 반환==other_user1인지 확인해야됨
		//		}
		//		for(int i=0;i<other_user1.getUsers3().size();i++) { // my_user1와 other_user1하고 size()가 다름
		//			System.out.println(other_user1.getUsers3().get(i).getUser_idx()); // 현재 마이페이지의 유저를 팔로우 한 user_idx가 반환됨==my_user1인지 확인
		//		}


		System.out.println("에러3");
		return "redirect:/page/user?user_idx="+user_idx+"&kara_type="+kara_type+"&sort="+sort;
	}
	@RequestMapping(value = "unfollow", method = RequestMethod.GET)
	public String unfollow(Model model,@RequestParam("user_idx") int user_idx,@RequestParam("kara_type") int kara_type,@RequestParam("sort") int sort,@RequestParam("my_user_idx") int my_user_idx) {
		if(my_user_idx==-1)
			return "redirect:/page/login";
		Optional<User> other_user=userRepository.findById(user_idx);
		Optional<User> my_user=userRepository.findById(my_user_idx);
		User my_user1=my_user.get();
		User other_user1=other_user.get();
		int n=-1,m=-1;
		for(int i=0;i<my_user1.getUsers2().size();i++) { // my_user1와 other_user1하고 size()가 다름
			if(my_user1.getUsers2().get(i).getUser_idx()==other_user1.getUser_idx()) { // 팔로우를 이미 한 사람이면
				n=i;
			}
			// System.out.println("내가 팔로우한 상대방 id: "+my_user1.getUsers2().get(i).getUser_idx()); // 내가 팔로우한 target_user_idx를 반환==other_user1인지 확인해야됨
		}
		if(n!=-1)
			my_user1.getUsers2().remove(n);
		for(int i=0;i<my_user1.getUsers2().size();i++) { // my_user1와 other_user1하고 size()가 다름
			System.out.println("내가 팔로우한 상대방 id: "+my_user1.getUsers2().get(i).getUser_idx()); // 내가 팔로우한 target_user_idx를 반환==other_user1인지 확인해야됨
		}
		for(int i=0;i<other_user1.getUsers3().size();i++) { // my_user1와 other_user1하고 size()가 다름
			if(other_user1.getUsers3().get(i).getUser_idx()==my_user1.getUser_idx()) { // 팔로우를 이미 한 사람이면
				m=i;
			}
			// System.out.println("상대방을 팔로워한 user_idx: "+other_user1.getUsers3().get(i).getUser_idx()); // 현재 마이페이지의 유저를 팔로우 한 user_idx가 반환됨==my_user1인지 확인
		}
		if(m!=-1)
			other_user1.getUsers3().remove(m);
		for(int i=0;i<other_user1.getUsers3().size();i++) { // my_user1와 other_user1하고 size()가 다름
			System.out.println("상대방을 팔로워한 user_idx: "+other_user1.getUsers3().get(i).getUser_idx()); // 현재 마이페이지의 유저를 팔로우 한 user_idx가 반환됨==my_user1인지 확인
		}
		userRepository.save(my_user1);
		return "redirect:/page/user?user_idx="+user_idx+"&kara_type="+kara_type+"&sort="+sort;
	}
	@Transactional
	@RequestMapping(value = "user", method = RequestMethod.GET)
	public String user(Model model,@RequestParam("user_idx") int user_idx,@RequestParam("kara_type") int kara_type,@RequestParam("sort") int sort,final HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		Optional<User> optinalEntity2=userRepository.findById(user_idx);
		User user = optinalEntity2.get();
		List<Song_like> song_likes=song_likeRepository.findByUser_idxAndKara_type(user.getUser_idx(),kara_type);
		User me = (User) session.getAttribute("user");

		Optional<User> mee=null;
		User me2=null; // 세션한 저장된 로그인된 유저를 저장함(바로 세션에서 이용하면 no session 오류 발생해서..)
		boolean followResult=false;

		if(me!=null) {
			mee=userRepository.findById(me.getUser_idx());
			me2=mee.get();
			for(int i=0;i<me2.getUsers2().size();i++) { // 바로 session으로 getUsers2를 접근하면 no session 오류 발생해서 우회로 해결
				if(me2.getUsers2().get(i).getUser_idx()==user.getUser_idx()) { // 팔로우를 이미 한 사람이면
					model.addAttribute("follow",true);
					followResult=true;
				}

			}
		}
		if(!followResult) // 팔로우를 한 사람이 아니라면
			model.addAttribute("follow",false);

		int followedNum=0; // 현 마이페이지의 유저를 팔로우한 사람들의 수
		for(int i=0;i<user.getUsers3().size();i++) { // my_user1와 other_user1하고 size()가 다름
			followedNum++;
			System.out.println("상대방을 팔로워한 user_idx: "+user.getUsers3().get(i).getUser_idx()); // 현재 마이페이지의 유저를 팔로우 한 user_idx가 반환됨==my_user1인지 확인
		}
		model.addAttribute("followedNum",followedNum);

		model.addAttribute("followingList",user.getUsers2());

		Comparator<Song_like> salesComparator;
		if(sort==0) { // 가수별 정렬일때
			salesComparator = new Comparator<Song_like>() {
				@Override
				public int compare(Song_like o1, Song_like o2) {
					return o1.getSong().getSinger().compareTo(o2.getSong().getSinger());
				}
			};
		}
		else { // 제목별 정렬일때
			salesComparator = new Comparator<Song_like>() {
				@Override
				public int compare(Song_like o1, Song_like o2) {
					return o1.getSong().getTitle().compareTo(o2.getSong().getTitle());
				}
			};
		}
		Collections.sort(song_likes,salesComparator);
		model.addAttribute("me",me);
		model.addAttribute("songs",song_likes);
		model.addAttribute("u",user); // 로그인한 자신이 아니라  해당 유저페이지의 유저
		model.addAttribute("kara",kara_type);
		model.addAttribute("sort",sort);
		System.out.println("유저페이지~");
		return "page/user";
	}
	@RequestMapping(value = "changeProfile", method = RequestMethod.GET)
	public String changeProfile(Model model,@RequestParam("user_idx") int user_idx,final HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		User user = (User) session.getAttribute("user");
		Optional<User> me=userRepository.findById(user.getUser_idx());
		model.addAttribute("me",me.get());
		List<User> users=userRepository.findAll();
		model.addAttribute("users",users);
		return "page/changeProfile";
	}
	@RequestMapping(value = "changeProfile", method = RequestMethod.POST)
	public String changeProfile(Model model,@RequestParam("message") String message,@RequestParam("nickname") String nickname,@RequestParam("password") String password,final HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		User user = (User) session.getAttribute("user");
		System.out.println("changeProfile post");
		System.out.println("nickname:"+nickname+" message:"+message+" password:"+password);
		userRepository.updateProfile(user.getUser_idx(),message,nickname,password);
		//		session.invalidate();
		//		session.setAttribute("user", user);
		return "redirect:/page/user?user_idx="+user.getUser_idx()+"&kara_type=0&sort=0";
	}

	@RequestMapping(value = "map", method = RequestMethod.GET)
	public String map() {
		return "page/map";
	}

	@RequestMapping(value = "notice", method = RequestMethod.GET)
	public String notice(Model model,@RequestParam("pg") int pg) {
		Board board= boardRepository.findById(5).get();
		List<Post> notices_ex=board.getPosts();//게시판
		//		List<Post> notices=new ArrayList<>();
		//		for(int i=notices_ex.size()-1;i>=0;i--) { // date기준으로 역순으로 정렬하려고
		//			notices.add(notices_ex.get(i));
		//		}
		Collections.sort(notices_ex);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<notices_ex.size();i++) {
			map.put(notices_ex.get(i).getPost_id(),post_likeRepository.findPost_like_num(notices_ex.get(i).getPost_id()));
			// System.out.println("post_id: "+freePosts_ex.get(i).getPost_id()+" count: "+post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
		}
		model.addAttribute("map_like",map);
		model.addAttribute("pg", pg);
		model.addAttribute("notices", notices_ex);
		return "page/notice";
	}

	@RequestMapping(value = "chartBoard", method = RequestMethod.GET)
	public String chartBoard() {
		return "page/chartBoard";
	}

	@RequestMapping(value = "bestBoard", method = RequestMethod.GET)
	public String bestBoard(Model model) {
		return "page/bestBoard";
	}

	@RequestMapping(value="freeBoard", method=RequestMethod.GET)
	public String freeBoard(Model model,@RequestParam("pg") int pg) {
		Board board= boardRepository.findById(1).get();
		List<Post> freePosts_ex=board.getPosts();//게시판
		Collections.sort(freePosts_ex);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<freePosts_ex.size();i++) {
			map.put(freePosts_ex.get(i).getPost_id(),post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
			//System.out.println("post_id: "+freePosts_ex.get(i).getPost_id()+" count: "+post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
		}
		model.addAttribute("map_like",map);

		model.addAttribute("pg",pg);
		model.addAttribute("freePosts", freePosts_ex);

		return "page/freeBoard";
	}

	//팁게시판 조회
	@RequestMapping(value="tipBoard", method=RequestMethod.GET)
	public String tipBoard(Model model,@RequestParam("pg") int pg) {
		Board board= boardRepository.findById(4).get();
		List<Post> tipPosts_ex=board.getPosts();
		//		List<Post> tipPosts=new ArrayList<>();
		//		for(int i=tipPosts_ex.size()-1;i>=0;i--) { // date기준으로 역순으로 정렬하려고
		//			tipPosts.add(tipPosts_ex.get(i));
		//		}
		Collections.sort(tipPosts_ex);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<tipPosts_ex.size();i++) {
			map.put(tipPosts_ex.get(i).getPost_id(),post_likeRepository.findPost_like_num(tipPosts_ex.get(i).getPost_id()));
			// System.out.println("post_id: "+freePosts_ex.get(i).getPost_id()+" count: "+post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
		}
		model.addAttribute("map_like",map);
		model.addAttribute("pg",pg);
		model.addAttribute("tipPosts", tipPosts_ex);

		return "page/tipBoard";
	}

	//추천게시판
	@RequestMapping(value="recommendBoard", method=RequestMethod.GET)
	public String recommendBoard(Model model,@RequestParam("pg") int pg) {
		Board board= boardRepository.findById(3).get();
		List<Post> recomPosts_ex=board.getPosts();
		//		List<Post> recomPosts=new ArrayList<>();
		//		for(int i=recomPosts_ex.size()-1;i>=0;i--) { // date기준으로 역순으로 정렬하려고
		//			recomPosts.add(recomPosts_ex.get(i));
		//		}
		Collections.sort(recomPosts_ex);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<recomPosts_ex.size();i++) {
			map.put(recomPosts_ex.get(i).getPost_id(),post_likeRepository.findPost_like_num(recomPosts_ex.get(i).getPost_id()));
			// System.out.println("post_id: "+freePosts_ex.get(i).getPost_id()+" count: "+post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
		}
		model.addAttribute("map_like",map);
		model.addAttribute("pg",pg);
		model.addAttribute("recomPosts", recomPosts_ex);

		return "page/recommendBoard";
	}

	//자랑게시판
	@RequestMapping(value="boastBoard", method=RequestMethod.GET)
	public String boastBoard(Model model,@RequestParam("pg") int pg) {
		Board board= boardRepository.findById(2).get();
		List<Post> boastPosts_ex=board.getPosts();
		//		List<Post> boastPosts=new ArrayList<>();
		//		for(int i=boastPosts_ex.size()-1;i>=0;i--) { // date기준으로 역순으로 정렬하려고
		//			boastPosts.add(boastPosts_ex.get(i));
		//		}
		Collections.sort(boastPosts_ex);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<boastPosts_ex.size();i++) {
			map.put(boastPosts_ex.get(i).getPost_id(),post_likeRepository.findPost_like_num(boastPosts_ex.get(i).getPost_id()));
			// System.out.println("post_id: "+freePosts_ex.get(i).getPost_id()+" count: "+post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
		}
		model.addAttribute("map_like",map);
		model.addAttribute("pg",pg);
		model.addAttribute("boastPosts", boastPosts_ex);

		return "page/boastBoard";
	}
	@RequestMapping(value = "searchPost/{pg}", method = RequestMethod.GET)
	public String searchPost2(Model model,@PathVariable("pg") int pg,@RequestParam("search_type") String type, @RequestParam("keyword") String keyword) throws UnsupportedEncodingException {
		keyword=URLEncoder.encode(keyword, "UTF-8");
		return "redirect:/page/searchPost?pg="+pg+"&search_type="+type+"&keyword="+keyword;
	}
	//게시글 검색
	@RequestMapping(value = "searchPost", method = RequestMethod.GET)
	public String searchPost(Model model,@RequestParam("search_type") String type, @RequestParam("keyword") String keyword,@RequestParam("pg") int pg) {
		List<Post> findedPosts=new ArrayList<Post>();
		if(type.equals("all")) {
			System.out.println("전체검색---------------");
			findedPosts=postRepository.findPostsByNicknameOrTitle(keyword, keyword);
		}
		else if(type.equals("title")) {
			System.out.println("제목검색---------------");
			findedPosts=postRepository.findPostsByTitle(keyword);
		}
		else{
			System.out.println("작성자검색---------------");
			findedPosts=postRepository.findPostsByNickname(keyword);
		}
		System.out.println("!!!!!!!!"+type);

		Collections.sort(findedPosts);
		model.addAttribute("finded", findedPosts);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);

		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<findedPosts.size();i++) {
			map.put(findedPosts.get(i).getPost_id(),post_likeRepository.findPost_like_num(findedPosts.get(i).getPost_id()));
			//System.out.println("post_id: "+freePosts_ex.get(i).getPost_id()+" count: "+post_likeRepository.findPost_like_num(freePosts_ex.get(i).getPost_id()));
		}
		model.addAttribute("pg",pg);
		model.addAttribute("map_like",map);

		return "page/searchPost";
	}

	@RequestMapping(value="post/{id}", method=RequestMethod.GET)
	public String postId(Model model, @PathVariable("id") int id,final HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		postRepository.updateView(id);
		Post post= postRepository.findById(id).get();
		List<File2> files=post.getFiles();//파일

		User user = (User) session.getAttribute("user");

		Comment comment=new Comment();
		Reply reply=new Reply();

		List<Comment> comments=post.getComments();
		Collections.sort(comments);

		int board_id=post.getBoard().getBoard_id();
		// System.out.println("board_id~: "+board_id);
		//		List<Post_like> post_like=post_likeRepository.findAllByPost(post);
		int like_num=post_likeRepository.findPost_like_num(post.getPost_id());
		if(user!=null) {
			//System.out.println("user_idx: "+user.getUser_idx());
			Post_like isLiked=post_likeRepository.findExistPost_like(id,user.getUser_idx());

			model.addAttribute("isLiked",isLiked);
		}
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0;i<comments.size();i++) {
			map.put(comments.get(i).getComment_id(),comment_likeRepository.like_count(comments.get(i).getComment_id()));
		}

		//댓글좋아요 유저 목록
		HashMap<Integer, List<Integer>> map2 = new HashMap<Integer, List<Integer>>();
		for(int i=0;i<comments.size();i++) {
			map2.put(comments.get(i).getComment_id(),comment_likeRepository.like_user(comments.get(i).getComment_id()));
		}


		model.addAttribute("like_num",like_num);
		model.addAttribute("comment_like",map);
		model.addAttribute("cl_user",map2);
		model.addAttribute("selectBoard",board_id);
		model.addAttribute("post", post);
		model.addAttribute("files", files);
		model.addAttribute("comment", comment);
		model.addAttribute("reply", reply);
		model.addAttribute("comments", comments);


		return "page/post";
	}

	@RequestMapping(value="post/{id}/comment/{comment_id}/delete", method = RequestMethod.GET)
	public String deleteComment(Model model, @PathVariable("id") int id, @PathVariable("comment_id") int comment_id, final HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException{
		//System.out.println("댓글 삭제"+comment.getComment_id()+"내용:"+comment.getContent());
		Comment c=commentRepository.findById(comment_id).get();
		c.setContent("삭제된 코멘트");

		c.setIs_delete(1);
		if(c.getReplies().isEmpty()) { // 댓글 삭제했는데 대댓글도 비어있을때 아얘 그 댓글 삭제해버리기
			commentRepository.deleteById(c.getComment_id());
		}
		else {
			commentRepository.save(c);
		}
		//		comment.setContent("삭제된 코멘트");
		//		Post p=postRepository.findById(id).get();
		//
		//		comment.setPost(p);
		//		comment.setIs_delete(1);
		//		comment.setDate(comment.getDate());

		return "redirect:/page/post/"+id;
	}

	@RequestMapping(value="post/{id}/comment/{comment_id}/{reply_id}/delete", method = RequestMethod.GET)
	public String deleteReply(Model model, @PathVariable("id") int id, @PathVariable("comment_id") int comment_id,
			@PathVariable("reply_id") int reply_id, final HttpSession session,HttpServletRequest request, HttpServletResponse response, Comment comment) throws IOException{

		System.out.println("대댓글 삭제"+comment.getComment_id()+"내용:"+comment.getContent());
		Reply r=replyRepository.findById(reply_id).get();
		replyRepository.delete(r);
		if(r.getComment().getReplies().isEmpty() && r.getComment().getIs_delete()==1) { // 대댓글 삭제 했는데 댓글도 삭제된 댓글이고 대댓글도 더이상 없을때 그 댓글 삭제
			commentRepository.deleteById(r.getComment().getComment_id());
		}
		return "redirect:/page/post/"+id;
	}


	//댓글입력
	@RequestMapping(value="post/{id}/comment", method = RequestMethod.GET)
	public String createComment(Model model, @PathVariable("id") int id,final HttpSession session,HttpServletRequest request, HttpServletResponse response, Comment comment) throws IOException {
		System.out.println("댓글 입력됨");
		System.out.println(comment.getContent());

		User user = (User) session.getAttribute("user");
		Optional<Post> post = postRepository.findById(id);
		Post p=post.get();

		//		List<Reply> replies=comment.getReplies();
		//		model.addAttribute("replies", replies);
		//		for(int i=0;i<replies.size();i++) {
		//			System.out.println(replies.get(i));
		//		}

		comment.setDate(new Date());
		comment.setUser(user);
		comment.setPost(p);
		//comment.setIs_delete(0);

		commentRepository.save(comment);



		return "redirect:/page/post/"+id;
	}

	//댓글입력
	@RequestMapping(value="post/{id}/comment", method=RequestMethod.POST)
	public String createComment2(Model model, @PathVariable("id") int id,final HttpSession session,HttpServletRequest request, HttpServletResponse response, Comment comment) throws IOException {

		return "redirect:/page/post/"+id;
	}

	@RequestMapping(value="post/{id}/comment/{comment_id}/reply", method = RequestMethod.GET)
	public String createReply(Model model, @PathVariable("id") int id,@PathVariable("comment_id") int comment_id,final HttpSession session,HttpServletRequest request, HttpServletResponse response, Reply reply) throws IOException {
		System.out.println("대댓글 입력됨");
		System.out.println(reply.getContent());

		User user = (User) session.getAttribute("user");
		Optional<Comment> comment = commentRepository.findById(comment_id);
		Comment c=comment.get();

		reply.setDate(new Date());
		reply.setUser(user);
		reply.setComment(c);

		replyRepository.save(reply);

		return "redirect:/page/post/"+id;
	}

	@RequestMapping(value="post/{id}/comment/{comment_id}/reply", method = RequestMethod.POST)
	public String createReply2(Model model, @PathVariable("id") int id,@PathVariable("comment_id") int comment_id,final HttpSession session,HttpServletRequest request, HttpServletResponse response, Reply reply) throws IOException {
		//		System.out.println("대댓글 입력됨");
		//		System.out.println(reply.getContent());
		//
		//		User user = (User) session.getAttribute("user");
		//		Optional<Comment> comment = commentRepository.findById(id);
		//		Comment c=comment.get();
		//
		//		reply.setDate(new Date());
		//		reply.setUser(user);
		//		reply.setComment(c);
		//
		//		replyRepository.save(reply);

		return "redirect:/page/post/"+id;
	}

	@RequestMapping(value="post/{id}/post_like", method=RequestMethod.GET)
	public String postId2(Model model, @PathVariable("id") int id,final HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("post의 post");
		Optional<Post> optinalEntity =postRepository.findById(id);
		Post post = optinalEntity.get();
		User user = (User) session.getAttribute("user");
		if(post_likeRepository.findExistPost_like(id,user.getUser_idx())!=null) {
			post_likeRepository.deletePost_like(post.getPost_id(),user.getUser_idx());
			System.out.println("없음");
		}
		else if(post_likeRepository.findExistPost_like(id,user.getUser_idx())==null)
			post_likeRepository.save(new Post_like(post,user,new Date()));


		return "redirect:/page/post/"+id; // url바꾸고 싶을때 redirect사용
	}

	//냇글 좋아요
	@RequestMapping(value="post/{id}/comment/{comment_id}/like", method=RequestMethod.GET)
	public String commentLike(Model model, @PathVariable("id") int id, @PathVariable("comment_id") int comment_id, final HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("아이디:"+comment_id);

		Comment comment = commentRepository.findById(comment_id).get();
		User user = (User) session.getAttribute("user");

		Comment_like cl=new Comment_like();

		if(comment_likeRepository.findExistComment_like(comment.getComment_id(),user.getUser_idx())!=null) {
			System.out.println(comment.getComment_id()+"추천취소");
			comment_likeRepository.deleteComment_like(comment.getComment_id(),user.getUser_idx());
		}
		else if(comment_likeRepository.findExistComment_like(comment.getComment_id(),user.getUser_idx())==null) {
			System.out.println(comment.getComment_id()+"추천됨");
			cl.setUser(user);
			cl.setComment(comment);
			comment_likeRepository.save(cl);
		}

		return "redirect:/page/post/"+id;
	}

	@RequestMapping(value = "relative", method = RequestMethod.GET)
	public String relative() {
		return "page/relative";
	}

	@RequestMapping(value = "findId", method = RequestMethod.GET)
	public String findId() {
		return "page/findId";
	}

	@RequestMapping(value = "findIdNext", method = RequestMethod.GET)
	public String findIdNext() {
		return "page/findIdNext";
	}

	@RequestMapping(value = "findPwNext", method = RequestMethod.GET)
	public String findPwNext() {
		return "page/findPwNext";
	}

	//   @RequestMapping(value = "fileForm", method = RequestMethod.POST)
	//   public String fileForm2() {
	//      System.out.println("fileForm post");
	//      return "page/fileFormOK";
	//   }
	@RequestMapping(value = "fileForm", method = RequestMethod.GET)
	public String fileForm3() {
		System.out.println("fileForm post");
		return "page/fileForm";
	}

	@RequestMapping(value = "fileFormOK", method = RequestMethod.GET)
	public String fileFormOK() {
		System.out.println("fileFormOK GET");
		return "page/fileForm";
	}
	// 유저 삭제 메소드
	@RequestMapping(value = "userDelete", method = RequestMethod.GET)
	public String userDelete(Model model,@RequestParam("user_idx") int user_idx) {
		System.out.println("유저삭제입니다!");
		Optional<User> optinalEntity2 =userRepository.findById(user_idx);
		User user = optinalEntity2.get();
		userRepository.deleteById(user_idx);
		return "redirect:home";

	}

	// 글 삭제 메소드
	@RequestMapping(value = "postDelete", method = RequestMethod.GET)
	public String postDelete(Model model,@RequestParam("post_id") int post_id) {
		Optional<Post> optinalEntity2 = postRepository.findById(post_id);
		Post post = optinalEntity2.get();
		Board board=post.getBoard();
		postRepository.deleteById(post_id);
		if(board.getBoard_id()==1)
			return "redirect:freeBoard?pg=1";
		else if(board.getBoard_id()==2)
			return "redirect:boastBoard?pg=1";
		else if(board.getBoard_id()==3)
			return "redirect:recommendBoard?pg=1";
		else if(board.getBoard_id()==4)
			return "redirect:tipBoard?pg=1";
		return "redirect:notice?pg=1";

	}

	// 글 수정
	@RequestMapping(value = "postModify", method = RequestMethod.GET)
	public String postModify(Model model,@RequestParam("post_id") int post_id) {
		Optional<Post> optinalEntity2 = postRepository.findById(post_id);
		Post post = optinalEntity2.get();
		int board_id=post.getBoard().getBoard_id();
		model.addAttribute("post", post);
		List<File2> files=fileRepository.findAllByPost(post);
		for(int i=0;i<files.size();i++) {
			System.out.println(files.get(i).getFile_name());
		}

		model.addAttribute("filelist", files);
		model.addAttribute("selectBoard", board_id);
		model.addAttribute("postModify", "yes");
		// System.out.println("파일 id: "+file.get(0).getFile_id());
		return "page/postWrite";

	}

	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String fileDelete(Model model, @RequestParam("id") int file_id) {
		File2 file=fileRepository.findById(file_id).get();
		int post_id=file.getPost().getPost_id();
		System.out.println(file.getFile_name()+"파일이 삭제됐어요");

		fileRepository.deleteById(file_id);

		//		File2 file=fileRepository.findById(id).get();
		//		Files.delete(getFilePath(file));
		return "redirect:postModify?post_id="+post_id;

	}

	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public String fileDelete2(Model model, @RequestParam("id") int file_id) {
		File2 file=fileRepository.findById(file_id).get();
		int post_id=file.getPost().getPost_id();
		System.out.println(file.getFile_name()+"파일이 삭제됐어요");

		fileRepository.deleteById(file_id);

		//		File2 file=fileRepository.findById(id).get();
		//		Files.delete(getFilePath(file));
		return "redirect:postModify?post_id="+post_id;

	}

	//글 수정 메소드   (수정중)
	@RequestMapping(value = "postModify", method = RequestMethod.POST)
	public String postModify2(@RequestParam("post_id") int post_id, final HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		int maxSize  = 1024*1024*10;

		// 웹서버 컨테이너 경로
		String root = request.getSession().getServletContext().getRealPath("/");
		System.out.println("root:"+root);
		// 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
		String savePath = root + "upload/";

		// 업로드 파일명
		String uploadFile = "";

		// 실제 저장할 파일명
		String newFileName = "";

		int read = 0;
		byte[] buf = new byte[1024];
		FileInputStream fin = null;
		FileOutputStream fout = null;
		long currentTime = System.currentTimeMillis();
		SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
		String title="";
		String content="";
		int user_idx=0;
		int board_id=0;
		User user = (User) session.getAttribute("user");
		if(user==null)
			System.out.println("nulllll");
		else
			System.out.println("id입니다!!!:"+user.getUser_idx());
		Board board=null;
		try{
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			// 전송받은 parameter의 한글깨짐 방지
			title = multi.getParameter("title");
			content = multi.getParameter("content");
			System.out.println("title:"+title);


			//			user_idx = Integer.parseInt(multi.getParameter("user_idx"));
			System.out.println("user_idx:"+user_idx);

			//			Optional<User> optinalEntity = userRepository.findById(user_idx);
			//			user = optinalEntity.get();

			//			board_id = Integer.parseInt(multi.getParameter("board_id"));
			//			Optional<Board> optinalEntity2 = boardRepository.findById(board_id);
			//			board = optinalEntity2.get();

			//title = new String(title.getBytes("8859_1"), "UTF-8");

			//         System.out.println("board_id:"+board_id);
			Enumeration files = multi.getFileNames();

			while(files.hasMoreElements()){
				String file1 = (String)files.nextElement();

				uploadFile = multi.getOriginalFileName(file1);
				newFileName = multi.getFilesystemName(file1);

				File file = multi.getFile(file1);
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!추가된 이미지: "+uploadFile);
			}

		} catch(Exception e){
			e.printStackTrace();
		}

		postRepository.updateByPost_id(title,content,post_id);
		//제목과 내용은 수정되는데 파일은 수정이 안되고 처음에 올린 그대로 올라감
		if(uploadFile!=null) {
			File2 file=new File2();
			file.setFile_name(uploadFile);
			file.setPost(postRepository.findById(post_id).get());
			fileRepository.save(file);
		}
		System.out.println(newFileName);
		System.out.println(uploadFile);
		System.out.println("마지막");
		//return "redirect:/page/post/"+p.getPost_id();
		return "redirect:/page/post/"+post_id;

	}

	// 글 추가 메소드
	@RequestMapping(value = "postWrite/{board_id}", method = RequestMethod.GET)
	public String postWrite(@PathVariable("board_id") int board_id,Model model,final HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		User user = (User) session.getAttribute("user");
		Post post = new Post();
		File2 file = new File2();

		List<File2> filelist=null;

		List<Board> boards = boardRepository.findAll();
		List<User> users = userRepository.findAll();

		model.addAttribute("selectBoard", board_id);
		model.addAttribute("post", post);
		model.addAttribute("boards", boards);
		model.addAttribute("users", users);
		model.addAttribute("files", file);
		model.addAttribute("filelist", filelist);

		return "page/postWrite";
	}


	@RequestMapping(value = "postWrite/{board_id}", method = RequestMethod.POST)
	public String postWrite(final HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("postWrite");
		// 10Mbyte 제한
		//ServletContext ctx = request.getServletContext();
		// 10Mbyte 제한
		int maxSize  = 1024*1024*10;

		// 웹서버 컨테이너 경로
		String root = request.getSession().getServletContext().getRealPath("/");
		System.out.println("root:"+root);
		// 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
		String savePath = root + "upload/";

		// 업로드 파일명
		String uploadFile = "";

		// 실제 저장할 파일명
		String newFileName = "";

		int read = 0;
		byte[] buf = new byte[1024];
		FileInputStream fin = null;
		FileOutputStream fout = null;
		long currentTime = System.currentTimeMillis();
		SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
		String title="";
		String content="";
		int user_idx=0;
		int board_id=0;
		User user = (User) session.getAttribute("user");
		if(user==null)
			System.out.println("nulllll");
		else
			System.out.println("id입니다!!!:"+user.getUser_idx());
		Board board=null;
		try{
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			// 전송받은 parameter의 한글깨짐 방지
			title = multi.getParameter("title");
			content = multi.getParameter("content");
			System.out.println("title:"+title);


			//			user_idx = Integer.parseInt(multi.getParameter("user_idx"));
			System.out.println("user_idx:"+user_idx);

			//			Optional<User> optinalEntity = userRepository.findById(user_idx);
			//			user = optinalEntity.get();

			board_id = Integer.parseInt(multi.getParameter("board_id"));
			Optional<Board> optinalEntity2 = boardRepository.findById(board_id);
			board = optinalEntity2.get();

			//title = new String(title.getBytes("8859_1"), "UTF-8");

			//         System.out.println("board_id:"+board_id);
			Enumeration files = multi.getFileNames();

			while(files.hasMoreElements()){
				String file1 = (String)files.nextElement();

				uploadFile = multi.getOriginalFileName(file1);
				newFileName = multi.getFilesystemName(file1);

				File file = multi.getFile(file1);
			}

		} catch(Exception e){
			e.printStackTrace();
		}

		Post p=postRepository.save(new Post(user,board,title,content,0,new Date()));

		if(uploadFile!=null) {
			File2 file=new File2();
			file.setFile_name(uploadFile);
			file.setPost(p);
			fileRepository.save(file);
		}
		System.out.println(newFileName);
		System.out.println(uploadFile);
		System.out.println("마지막");
		return "redirect:/page/post/"+p.getPost_id();
	}



}

