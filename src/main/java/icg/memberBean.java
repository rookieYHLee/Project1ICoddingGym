package icg;

import java.sql.Timestamp;

public class memberBean {
	
	private String id;
	private String password;
	private String name;
	private String citizennum1;
	private String citizennum2;
	private String citizennum;
	private String tele;
	private String email;
	private int classify;
	private Timestamp joinDate;
	private Timestamp lastLoginDate;
	private int loginCount;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCitizennum1() {
		return citizennum1;
	}
	public void setCitizennum1(String citizennum1) {
		this.citizennum1 = citizennum1;
	}
	public String getCitizennum2() {
		return citizennum2;
	}
	public void setCitizennum2(String citizennum2) {
		this.citizennum2 = citizennum2;
	}
	public String getCitizennum() {
		return citizennum;
	}
	public void setCitizennum(String citizennum1, String citizennum2) {
		this.citizennum = citizennum1 + citizennum2;
	}
	public void setCitizennum(String citizennum) {
		this.citizennum = citizennum;
	}
	public String getTele() {
		return tele;
	}
	public void setTele(String tele) {
		this.tele = tele;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getClassify() {
		return classify;
	}
	public void setClassify(int classify) {
		this.classify = classify;
	}
	public Timestamp getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Timestamp joinDate) {
		this.joinDate = joinDate;
	}
	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public int getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

}
