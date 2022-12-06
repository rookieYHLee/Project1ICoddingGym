package icg;

import java.sql.Timestamp;

public class boardBean {
	private int b_no;
	private String b_title;
	private String b_contents;
	private String b_writer;
	private Timestamp b_writeDate;
	private Timestamp b_rewriteDate;
	private int b_viewCount;
	private int b_recommCount;
	private String b_imageURL;
	private String b_notice;
	private int b_replyCount;
	
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_contents() {
		return b_contents;
	}
	public void setB_contents(String b_contents) {
		this.b_contents = b_contents;
	}
	public String getB_writer() {
		return b_writer;
	}
	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}
	public Timestamp getB_writeDate() {
		return b_writeDate;
	}
	public void setB_writeDate(Timestamp b_writeDate) {
		this.b_writeDate = b_writeDate;
	}
	public Timestamp getB_rewriteDate() {
		return b_rewriteDate;
	}
	public void setB_rewriteDate(Timestamp b_rewriteDate) {
		this.b_rewriteDate = b_rewriteDate;
	}
	public int getB_viewCount() {
		return b_viewCount;
	}
	public void setB_viewCount(int b_viewCount) {
		this.b_viewCount = b_viewCount;
	}
	public int getB_recommCount() {
		return b_recommCount;
	}
	public void setB_recommCount(int b_recommCount) {
		this.b_recommCount = b_recommCount;
	}
	public String getB_imageURL() {
		return b_imageURL;
	}
	public void setB_imageURL(String b_imageURL) {
		this.b_imageURL = b_imageURL;
	}
	public String getB_notice() {
		return b_notice;
	}
	public void setB_notice(String b_notice) {
		this.b_notice = b_notice;
	}
	
	public int getB_replyCount() {
		return b_replyCount;
	}
	public void setB_replyCount(int b_replyCount) {
		this.b_replyCount = b_replyCount;
	}
}
