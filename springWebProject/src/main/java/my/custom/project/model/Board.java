package my.custom.project.model;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name="tbl_board")
public class Board {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column
	private int bno;
	
	@NotEmpty(message="제목을 입력 해주세요")
	private String title;
	
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	
	
	private int originNo;
	
	private int groupOrd;
	
	private int groupLayer;
	
	private String imageFilename;
	
	
	private String writer;
	private Date regdate;
	private int viewcnt;
	
	@Transient
	private MultipartFile imageFile;
	


}
