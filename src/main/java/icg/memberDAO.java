package icg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;





public class memberDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs  = null;
	
	public Connection getConnection() {
		String Driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "ICG";
		String pass = "1234";
		
		try {
			Class.forName(Driver);
			 conn = DriverManager.getConnection(url, id, pass);
			//System.out.println("데이터베이스 연동에 성공하였습니다.");
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("데이터베이스 연동에 실패하였습니다.");
		}		
		return conn;		
	}
	
	// 회원가입 데이터 입력.
		public void insertmember(memberBean mBean) {
			System.out.println(mBean.getCitizennum());
			try {
					getConnection();
					
				String  sql = "insert into memberT(id,password,name,citizennum,tele,email) values (?,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, mBean.getId());//id value
				pstmt.setString(2, mBean.getPassword());
				pstmt.setString(3, mBean.getName());
				pstmt.setString(4, mBean.getCitizennum());
				pstmt.setString(5, mBean.getTele());
				pstmt.setString(6, mBean.getEmail());
				
				pstmt.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
				
				
			}
		}
		
		//올셀렉
		public Vector<memberBean> allselectmember() throws SQLException {
			
			Vector<memberBean> v= new Vector<memberBean>();
			
			String sql = "select id,name,tele,email from memberT";
			try {
				getConnection();
				
				pstmt = conn.prepareStatement(sql);
		
			
				rs = pstmt.executeQuery();
			
				 while(rs.next()) {
					 memberBean mBean = new memberBean();
					 mBean.setId(rs.getString(1));
					 mBean.setName(rs.getString(2));
					 mBean.setTele(rs.getString(3));
					 mBean.setEmail(rs.getString(4));
					 v.add(mBean);
				 }
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			return v;
		}
		
		//원셀렉
		public memberBean oneselectmember(String id){
			
			memberBean mBean = new memberBean();
			
			try {
				getConnection();
			
				String sql = "select * from memberT where id=?";
				pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
			 while(rs.next()) {
				 mBean.setId(rs.getString(1));
				 mBean.setPassword(rs.getString(2));
				 mBean.setName(rs.getString(3));
				 mBean.setCitizennum(rs.getString(4));
				 mBean.setTele(rs.getString(5));
				 mBean.setEmail(rs.getString(6));
				 mBean.setClassify(rs.getInt(7));
				 mBean.setJoinDate(rs.getTimestamp(8));
				 mBean.setLastLoginDate(rs.getTimestamp(9));
				 mBean.setLoginCount(rs.getInt(10));
				 
			 }
			conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
			
			return mBean;
			
		}
		public int userCheck(String id, String password) throws Exception {
		
			getConnection();
			String dbpassword="";
			Timestamp lastlogindate;
			int x=-1;
			
			try {
			conn = getConnection();
			memberDAO mdao = new memberDAO();
			pstmt = conn.prepareStatement("select password,lastLoginDate from memberT where id = ?");
			pstmt.setString(1, id);
			
			rs= pstmt.executeQuery();//select일때만 실행합니다.
			
			
			if(rs.next()){
				dbpassword= rs.getString("password");
				lastlogindate = rs.getTimestamp("lastLoginDate");
				if(dbpassword.equals(password)) {
					x= 1; //인증 성공
					if(lastlogindate != null) {
						mdao.logincount(id,lastlogindate);
						mdao.logindateupdate(id);
					}else if(lastlogindate == null) {
						mdao.defaultlogindateupdate(id);
					}
				}else
					x= 0; //비밀번호 틀림
			}else
				x= -1;//해당 아이디 없음
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) 
					try { rs.close(); } 
						catch(SQLException ex) {}
				if (pstmt != null) 
					try { pstmt.close(); } 
						catch(SQLException ex) {}
				if (conn != null) 
					try { conn.close(); } 
						catch(SQLException ex) {}
				}
			return x;
			}
		
		public void deldeteMember(memberBean mBean) {
			
			try {
				getConnection();
				
				String sql = "delete from memberT where id = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, mBean.getId());
				
				pstmt.executeQuery();
				
				if(conn != null) {
					conn.commit();
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		public void logindateupdate(String id) {
			getConnection();
			
			//count
			String sql = "update memberT set lastlogindate = systimestamp where id = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		}
		public void defaultlogindateupdate(String id) {
			getConnection();
			
			//count
			String sql = "update memberT set lastlogindate = systimestamp,logincount = 1 where id = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		public void logincount(String id,Timestamp lastlogindate) throws ParseException {
			getConnection();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			//count
			Long datetime = System.currentTimeMillis();
		    Timestamp now = new Timestamp(datetime);
			
			String date_str1 = lastlogindate.toString();
			String date_str2 = now.toString();
			
			
			String set1 = date_str1.substring(0,19);
			String set2 = date_str2.substring(0,19);
			Date date1 = transFormat.parse(set1);
			Date date2 = transFormat.parse(set2);
			
			long diffHor = (date2.getTime() - date1.getTime()) / 60000;
			
			if(diffHor >= 180) {
			String sql = "update memberT set logincount = logincount + 1 where id = ?";
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} catch (SQLException e) {
		
				e.printStackTrace();
			}
		}
		
	
			
		}
		
		public String getPassword(String id) {
			String dbpassword = null;
			try {
				getConnection();
				
				
				String sql="select password from memberT where id=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpassword = rs.getString(1);
					
				}
					
				if(conn !=null) {
					conn.close();
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			return dbpassword;
			
		}
		public void updatemember(memberBean mBean) {
			
			
			try{
				getConnection();
				
				String sql ="update memberT set email=?, tele=? where id=?";
				
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setString(1, mBean.getEmail());
				pstmt.setString(2, mBean.getTele());
				pstmt.setString(3, mBean.getId());
				
				pstmt.executeUpdate();
				if(conn !=null) {
					conn.commit();
					conn.close();
				}
				
			}catch(Exception e){
				e.printStackTrace();		
			}
			
		}
		//총 회원 수
				public int memberCount() {
					
					int count = 0;
					getConnection();
					
					try {
						
						String csql = "select count(id) from memberT";
						
						pstmt = conn.prepareStatement(csql);
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							
							count = rs.getInt(1);
						}
						
						
						if(conn !=null) {
							conn.commit();
							conn.close();
						}
						
					}catch(Exception e){
						e.printStackTrace();		
					}return count;
				} 
				
}
