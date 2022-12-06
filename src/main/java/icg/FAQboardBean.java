package icg;

import java.sql.Timestamp;

public class FAQboardBean {
	
private int fb_no;
private int fb_reply;
private String fb_title;
private String fb_contents;
private String fb_writer;
private Timestamp fb_writeDate;
private Timestamp fb_rewriteDate;
private int fb_viewCount;
private int  fb_answered;
private int fb_notice;
public int getFb_notice() {
	return fb_notice;
}
public void setFb_notice(int fb_notice) {
	this.fb_notice = fb_notice;
}
public int getFb_no() {
	return fb_no;
}
public void setFb_no(int fb_no) {
	this.fb_no = fb_no;
}
public int getFb_reply() {
	return fb_reply;
}
public void setFb_reply(int fb_reply) {
	this.fb_reply = fb_reply;
}
public String getFb_title() {
	return fb_title;
}
public void setFb_title(String fb_title) {
	this.fb_title = fb_title;
}
public String getFb_contents() {
	return fb_contents;
}
public void setFb_contents(String fb_contents) {
	this.fb_contents = fb_contents;
}
public String getFb_writer() {
	return fb_writer;
}
public void setFb_writer(String fb_writer) {
	this.fb_writer = fb_writer;
}

public int getFb_viewCount() {
	return fb_viewCount;
}
public Timestamp getFb_writeDate() {
	return fb_writeDate;
}
public void setFb_writeDate(Timestamp fb_writeDate) {
	this.fb_writeDate = fb_writeDate;
}
public Timestamp getFb_rewriteDate() {
	return fb_rewriteDate;
}
public void setFb_rewriteDate(Timestamp fb_rewriteDate) {
	this.fb_rewriteDate = fb_rewriteDate;
}
public void setFb_viewCount(int fb_viewCount) {
	this.fb_viewCount = fb_viewCount;
}
public int getFb_answered() {
	return fb_answered;
}
public void setFb_answered(int fb_answered) {
	this.fb_answered = fb_answered;
}

}