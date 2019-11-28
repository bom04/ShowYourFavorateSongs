package net.skhu.model;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class LoginUserModel {
    @NotEmpty(message="이메일을 입력해주세요.")
    @Email(message="이메일 형식이 올바르지 않습니다")
    String email;

    @NotEmpty(message="비밀번호를 입력해주세요.")
    String password;


}