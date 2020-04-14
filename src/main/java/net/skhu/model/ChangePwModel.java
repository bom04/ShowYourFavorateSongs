package net.skhu.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class ChangePwModel {
    @NotEmpty(message="비밀번호를 입력해주세요.")
    @Size(min=1, max=15, message="15자 이하이어야 합니다.")
    String password;

    @NotEmpty(message="다시한번 비밀번호을 입력해주세요.")
    String password2;
}
