package net.skhu.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class PostWriteModel {
	@NotEmpty(message="제목을 입력해주세요.")
	@Size(min=1, max=45, message="45자 이하이어야 합니다.")
	String title;

	@Size(min=0, max=1000, message="1000자 이하이어야 합니다.")
	String content;
}
