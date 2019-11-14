package net.skhu.domain;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@Entity
@EqualsAndHashCode(exclude = {"posts"})
@ToString(exclude = {"posts"})

public class Board {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int board_id;

    String board_name;

    @JsonIgnore
    @OneToMany(mappedBy="board")
    List<Post> posts;

}



