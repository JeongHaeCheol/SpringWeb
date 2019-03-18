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
@Table(name="project")
public class Project {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column
	private int projectNo;
	
	@NotEmpty(message="제목을 입력 해주세요")
	private String title;
	
	@NotEmpty(message="내용을 입력해주세요")
	private String content;

	@NotEmpty(message="환경 및 기술을 입력해주세요")
	private String envOrTech;
	
	private String imageFileNames;
	private String sumnailFileName;
	
	private String writer;
	private Date regdate;
	
	@Transient
	private MultipartFile imageFiles;
	
}
