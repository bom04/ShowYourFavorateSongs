package net.skhu.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;
@Data
public class ProfileUserModel {

    @Size(min=0, max=100,message="100자 이하여야 합니다.")
    String message;

    @NotEmpty(message="필수항목입니다.")
    @Size(min=1, max=15, message="15자 이하이어야 합니다.")
    String password;

    @NotEmpty(message="필수항목입니다.")
    String password2;

    @NotEmpty(message="필수항목입니다.")
    @Size(min=2, max=5,message="2자 이상 5자 이하여야 합니다.")
    String nickname;

}
