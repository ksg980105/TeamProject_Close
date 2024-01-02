package report.model;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class ReportBean {
	private int report_number;
	
	@NotNull(message = "문의유형을 선택하세요.")
	private String report_category;
	
	
	@NotBlank(message = "내용을 입력하세요.")
	private String content;
	private String image;
	private String reporter_id;
	private String reported_user_id;
	private int style_number;
	private Timestamp write_date;
	
	private MultipartFile upload;
	
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
		if(this.upload != null) {
			image = upload.getOriginalFilename();
		}
	}
	
	public ReportBean() {
		super();
	}
	
	public ReportBean(int report_number, String report_category, String content, String image, String reporter_id,
			String reported_user_id, int style_number, Timestamp write_date) {
		super();
		this.report_number = report_number;
		this.report_category = report_category;
		this.content = content;
		this.image = image;
		this.reporter_id = reporter_id;
		this.reported_user_id = reported_user_id;
		this.style_number = style_number;
		this.write_date = write_date;
	}

	public int getReport_number() {
		return report_number;
	}

	public void setReport_number(int report_number) {
		this.report_number = report_number;
	}

	public String getReport_category() {
		return report_category;
	}

	public void setReport_category(String report_category) {
		this.report_category = report_category;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getReporter_id() {
		return reporter_id;
	}

	public void setReporter_id(String reporter_id) {
		this.reporter_id = reporter_id;
	}

	public String getReported_user_id() {
		return reported_user_id;
	}

	public void setReported_user_id(String reported_user_id) {
		this.reported_user_id = reported_user_id;
	}

	public int getStyle_number() {
		return style_number;
	}

	public void setStyle_number(int style_number) {
		this.style_number = style_number;
	}

	public Timestamp getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	
	
	
}
