package net.skhu.model;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class UserModel {
    @NotEmpty(message="필수항목입니다.")
    @Email(message="이메일 주소가 올바르지 않습니다")
    String email;

    @NotEmpty(message="필수항목입니다.")
    @Size(min=5, max=15, message="5자 이상 15자 이하이어야 합니다.")
    String password;

    @NotEmpty(message="필수항목입니다.")
    String password2;

    @NotEmpty(message="필수항목입니다.")
    @Size(min=2, max=5,message="2자 이상 5자 이하여야 합니다.")
    String nickname;

}