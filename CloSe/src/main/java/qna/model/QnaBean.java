package qna.model;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class QnaBean {
	private int qna_number;
	
	private String image;
	
	@NotBlank(message = "제목을 입력하세요.")
	private String title;
	
	@NotBlank(message = "내용을 입력하세요.")
	private String content;
	
	private Timestamp write_date;
	private String secret;
	private int ref;
	private int re_level;
	
	private int answer;
	
	@NotNull(message = "문의유형을 선택하세요.")
	private String qna_category;
	private String member_id;
	private String nickname;
	
	private MultipartFile upload;
	private String upload2;
	
	
	
	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
		if(this.upload != null) {
			image = upload.getOriginalFilename();
		}
	}

	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}

	public QnaBean() {
		super();
	}
	
	public QnaBean(int qna_number, String image, String title, String content, Timestamp write_date, String secret,
			int ref, int re_level, int answer, String qna_category, String member_id, String nickname,
			MultipartFile upload, String upload2) {
		super();
		this.qna_number = qna_number;
		this.image = image;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.secret = secret;
		this.ref = ref;
		this.re_level = re_level;
		this.answer = answer;
		this.qna_category = qna_category;
		this.member_id = member_id;
		this.nickname = nickname;
		this.upload = upload;
		this.upload2 = upload2;
	}

	public int getQna_number() {
		return qna_number;
	}

	public void setQna_number(int qna_number) {
		this.qna_number = qna_number;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}

	public String getQna_category() {
		return qna_category;
	}

	public void setQna_category(String qna_category) {
		this.qna_category = qna_category;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	
}
