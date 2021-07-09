package my.custom.project.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name="users")
public class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="userId")
	private int id;
	
	
	@Size(min=5, max=12, message="사용자 아이디는 5자리 이상 12자 이하만 가능 합니다.")
	@Pattern(regexp="^[0-9a-zA-Z]*$" , message="사용자 아이디는 영문자 숫자 조합만 가능 합니다.")
	@NotEmpty(message="Must not be null")
	private String username;
	

	@Pattern(regexp="^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&./])[A-Za-z0-9$@$!%*#?&./]{5,20}$" , message="최소 5자 최대 20자 숫자, 문자, 특수문자 각각 1개 이상 포함")
	@NotEmpty(message="Must not be null")
	private String password;
	
	
	@Pattern(regexp="^[a-z0-9_+.-]+@([a-z0-9-]+\\.)+[a-z0-9]{2,4}$")
	@NotEmpty(message="Must not be null")
	private String email;

	private boolean enabled=false;
	
	private String authority;
	
	
}
