package icg;

import java.sql.*;

public class replyBean {

	private int b_no;
	private int e_no;
	private int r_no;
	private int r_reNo;
	private String r_contents;
	private String r_writer;
	private Timestamp r_writeDate;
	private Timestamp r_rewriteDate;
	private double r_reviewScore;
	private String r_contents_up;
	
	
	
	public String getR_contents_up() {
		return r_contents_up;
	}
	public void setR_contents_up(String r_contents_up) {
		this.r_contents_up = r_contents_up;
	}
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public int getE_no() {
		return e_no;
	}
	public void setE_no(int e_no) {
		this.e_no = e_no;
	}
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public int getR_reNo() {
		return r_reNo;
	}
	public void setR_reNo(int r_reNo) {
		this.r_reNo = r_reNo;
	}
	public String getR_contents() {
		return r_contents;
	}
	public void setR_contents(String r_contents) {
		this.r_contents = r_contents;
	}
	public String getR_writer() {
		return r_writer;
	}
	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}
	public Timestamp getR_writeDate() {
		return r_writeDate;
	}
	public void setR_writeDate(Timestamp r_writeDate) {
		this.r_writeDate = r_writeDate;
	}
	public Timestamp getR_rewriteDate() {
		return r_rewriteDate;
	}
	public void setR_rewriteDate(Timestamp r_rewriteDate) {
		this.r_rewriteDate = r_rewriteDate;
	}
	public double getR_reviewScore() {
		return r_reviewScore;
	}
	public void setR_reviewScore(double r_reviewScore) {
		this.r_reviewScore = r_reviewScore;
	}
	


	
}
