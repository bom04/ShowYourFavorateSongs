package net.skhu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import net.skhu.domain.User;

public interface UserRepository extends JpaRepository<User, Integer>  {
	@Query("select u from User u where u.email=:email")
	User findByEmail(@RequestParam("email") String email);

	@Query("select u from User u where u.nickname=:nickname")
	User findByNickname(@RequestParam("nickname") String nickname);

	@Query("select max(u.user_idx) from User u")
	int findMaxUser_idx();

	@Transactional
	@Modifying
	@Query(value="update User u set u.user_auth=true where u.email=:email",nativeQuery=true)
	void updateAuth_key(@RequestParam("email") String email);

	@Query("select u from User u where u.auth_key=:auth_key")
	User findByAuth_key(@RequestParam("auth_key") String auth_key);

	@Transactional
	@Modifying
	@Query(value="update User u set u.password=:password where u.email=:email",nativeQuery=true)
	void updatePassword(@RequestParam("email") String email,@RequestParam("password") String password);

	@Transactional
	@Modifying
	@Query(value="update User u set u.password=:password,u.message=:message,u.nickname=:nickname where u.user_idx=:user_idx",nativeQuery=true)
	void updateProfile(@RequestParam("user_idx") int user_idx,@RequestParam("message") String message,@RequestParam("nickname") String nickname,@RequestParam("password") String password);


}

