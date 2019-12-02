package net.skhu.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class CommentModel {
    @NotEmpty(message="내용을 입력해주세요.")
    @Size(min=1, max=200, message="200자 이하이어야 합니다.")
    String content22;
}
