package icg;

import java.sql.Timestamp;

public class exboardBean {
	private int e_no;
	private String e_title;
	private String e_contents;
	private String e_writer;
	private Timestamp e_writeDate;
	private Timestamp e_rewriteDate;
	private int e_viewCount;
	private int e_reviewCount;
	private String e_imageURL;	
	
	
	public int getE_no() {
		return e_no;
	}
	public void setE_no(int e_no) {
		this.e_no = e_no;
	}
	public String getE_title() {
		return e_title;
	}
	public void setE_title(String e_title) {
		this.e_title = e_title;
	}
	public String getE_contents() {
		return e_contents;
	}
	public void setE_contents(String e_contents) {
		this.e_contents = e_contents;
	}
	public String getE_writer() {
		return e_writer;
	}
	public void setE_writer(String e_writer) {
		this.e_writer = e_writer;
	}
	public Timestamp getE_writeDate() {
		return e_writeDate;
	}
	public void setE_writeDate(Timestamp e_writeDate) {
		this.e_writeDate = e_writeDate;
	}
	public Timestamp getE_rewriteDate() {
		return e_rewriteDate;
	}
	public void setE_rewriteDate(Timestamp e_rewriteDate) {
		this.e_rewriteDate = e_rewriteDate;
	}
	public int getE_viewCount() {
		return e_viewCount;
	}
	public void setE_viewCount(int e_viewCount) {
		this.e_viewCount = e_viewCount;
	}
	public int getE_reviewCount() {
		return e_reviewCount;
	}
	public void setE_reviewCount(int e_reviewCount) {
		this.e_reviewCount = e_reviewCount;
	}
	public String getE_imageURL() {
		return e_imageURL;
	}
	public void setE_imageURL(String e_imageURL) {
		this.e_imageURL = e_imageURL;
	}

}
