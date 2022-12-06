package icg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Vector;



public class FAQboardDAO {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		public Connection getConnection() {
			
			String Driver = "oracle.jdbc.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "ICG"; 
			String pass = "1234";
			
			try {
				
				Class.forName(Driver);
				 conn = DriverManager.getConnection(url, id, pass);
				//System.out.println("DB 연동 성공");
				
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println("DB 연동 실패");
			}
			
			return conn;
		}
	
	
		public void insertBoard(FAQboardBean fbBean) {
			
			getConnection();
			
			try {						
											
				String sql = "insert into faqBoardT(fb_no,fb_title,fb_contents,fb_writer,fb_notice) values(fb_sq.nextval, ?, ?, ?,?)";
				pstmt = conn.prepareStatement(sql);
			
				
				pstmt.setString(1, fbBean.getFb_title());
				pstmt.setString(2, fbBean.getFb_contents());
				pstmt.setString(3, fbBean.getFb_writer());
				pstmt.setInt(4, fbBean.getFb_notice());
			
				
				pstmt.executeUpdate();
				
				if(conn != null) {
					conn.commit();
					conn.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}	
			
	public Vector<FAQboardBean> allselectboard(int startRow, int endRow) {
			
			getConnection();
			Vector<FAQboardBean> vec = new Vector<FAQboardBean>();
			try {
					String sql = "select * from (select A.*, Rownum Rnum from (select * from FAQboardT order by fb_no desc)A) where Rnum >=? and Rnum <= ?";
				
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startRow); 
					pstmt.setInt(2, endRow); 
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						
						FAQboardBean fbBean = new FAQboardBean();
						
						fbBean.setFb_no(rs.getInt(1));
						fbBean.setFb_reply(rs.getInt(2));
						fbBean.setFb_title(rs.getString(3));
						fbBean.setFb_contents(rs.getString(4));
						fbBean.setFb_writer(rs.getString(5));
						fbBean.setFb_writeDate(rs.getTimestamp(6));
						fbBean.setFb_rewriteDate(rs.getTimestamp(7));
						fbBean.setFb_viewCount(rs.getInt(8));
						fbBean.setFb_answered(rs.getInt(9));
						fbBean.setFb_notice(rs.getInt(10));
						vec.add(fbBean);
					}
					if(conn != null) {
						conn.commit();
						conn.close();
					}
			}catch(Exception e){
			e.printStackTrace();
		}
			return vec;
		}
		
	public Vector<FAQboardBean> noticeboardselect() {
		
		getConnection();
		Vector<FAQboardBean> Nvec = new Vector<FAQboardBean>();
		try {
				//String sql = "select * from faqBoardT where fb_notice = 1 order by nvl(fb_rewriteDate,fb_writeDate) desc";
				String sql = "select *\r\n"
						+ "        from   faqBoardT \r\n"
						+ "        where fb_no in (select b.fb_no from (select fb_no, rank()  over (order by nvl(fb_rewriteDate,fb_writeDate)desc) as rank\r\n"
						+ "                     from faqBoardT \r\n"
						+ "                     where fb_notice = 1\r\n"
						+ "                         ) a, faqBoardT b\r\n"
						+ "              where a.fb_no = b.fb_no\r\n"
						+ "              and rank <= 3)\r\n"
						+ "              order by fb_no desc";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					FAQboardBean fbBean = new FAQboardBean();
					
					fbBean.setFb_no(rs.getInt(1));
					fbBean.setFb_reply(rs.getInt(2));
					fbBean.setFb_title(rs.getString(3));
					fbBean.setFb_contents(rs.getString(4));
					fbBean.setFb_writer(rs.getString(5));
					fbBean.setFb_writeDate(rs.getTimestamp(6));
					fbBean.setFb_rewriteDate(rs.getTimestamp(7));
					fbBean.setFb_viewCount(rs.getInt(8));
					fbBean.setFb_answered(rs.getInt(9));
					fbBean.setFb_notice(rs.getInt(10));
					Nvec.add(fbBean);
				}
				if(conn != null) {
					conn.commit();
					conn.close();
				}
		}catch(Exception e){
		e.printStackTrace();
	}
		return Nvec;
	}
		
		
		
	public FAQboardBean oneselectboard(int num){
			
		FAQboardBean fbBean = new FAQboardBean();
		//sql문 수정아직안함
			try {
				getConnection();
				
				//count
				String readsql = "update faqBoardT set fb_viewCount = fb_viewCount+1 where fb_no = ?";
				pstmt = conn.prepareStatement(readsql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
				String sql = "select * from faqBoardT where fb_no =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
									
					fbBean.setFb_no(rs.getInt(1));
					fbBean.setFb_reply(rs.getInt(2));
					fbBean.setFb_title(rs.getString(3));
					fbBean.setFb_contents(rs.getString(4));
					fbBean.setFb_writer(rs.getString(5));
					fbBean.setFb_writeDate(rs.getTimestamp(6));
					fbBean.setFb_rewriteDate(rs.getTimestamp(7));
					fbBean.setFb_viewCount(rs.getInt(8));
					fbBean.setFb_answered(rs.getInt(9));
					fbBean.setFb_notice(rs.getInt(10));
									
				}
				if(conn != null) {
					conn.commit();
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return fbBean;
		}
	
	
	
	public void rewriteBoard(FAQboardBean fbBean) {
			
			//댓글쓰기 FAQ dao 수정필요함
		
			getConnection();			
			//sql문 수정아직안함
			try {
																		//두번째 물음표는 re_level
				
				String sql = "insert into faqBoardT(fb_no,fb_reply,fb_title,fb_contents,fb_writer) values(fb_sq.nextval,1,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fbBean.getFb_title());
				pstmt.setString(2, fbBean.getFb_contents());
				pstmt.setString(3, fbBean.getFb_writer());
				
				pstmt.executeUpdate();
				
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
	}
	
	//게시판 글 수정 반환 호출
	public FAQboardBean UpdateOneSelectBoard(int num){
	
		FAQboardBean fbBean = new FAQboardBean();
		//sql문 수정아직안함
		try {
			getConnection();
			
			String sql = "select * from faqBoardT where fb_no =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
								
				fbBean.setFb_no(rs.getInt(1));
				fbBean.setFb_reply(rs.getInt(2));
				fbBean.setFb_title(rs.getString(3));
				fbBean.setFb_contents(rs.getString(4));
				fbBean.setFb_writer(rs.getString(5));
				fbBean.setFb_writeDate(rs.getTimestamp(6));
				fbBean.setFb_rewriteDate(rs.getTimestamp(7));
				fbBean.setFb_viewCount(rs.getInt(8));
				fbBean.setFb_answered(rs.getInt(9));
				fbBean.setFb_notice(rs.getInt(10));
				
			}
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return fbBean;
	}
	
	
	
	public int getAllcount() {
			
			getConnection();
			
			int count = 0;
			//sql문 수정아직안함
			try {
				
				String sql = "select count(*) from faqBoardT";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				if(conn != null) {
					conn.commit();
					conn.close();
				}				
			}catch(Exception e) {
				e.printStackTrace();
			}		
			return count;
		}
	
	public int getSearchcount(String what,String WorT) {
		
		getConnection();
		
		int count = 0;
		String whats = "%"+what+"%";
		//sql문 수정아직안함
		try {
			
			String sql = "";
			if(WorT.equals("title")){
				sql = "select count(*) from faqBoardT where fb_title like ?";
				pstmt = conn.prepareStatement(sql);
			}else if(WorT.equals("writer")){
				sql = "select count(*) from faqBoardT where fb_writer like ?";
				pstmt = conn.prepareStatement(sql);
			};
			
			
			
			
			
			pstmt.setString(1, whats);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}				
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return count;
	}
	
	public void updateBoard(FAQboardBean fbBean) {
		
		try {
			getConnection();
			
			String sql = "update faqBoardT set fb_title =?,fb_contents= ?, fb_rewriteDate = systimestamp where fb_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fbBean.getFb_title());
			pstmt.setString(2, fbBean.getFb_contents());
			pstmt.setInt(3, fbBean.getFb_no());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void deldeteBoard(int num) {
		
		try {
			getConnection();
			
			String sql = "delete from faqBoardT where fb_no =? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			pstmt.executeQuery();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public Vector<FAQboardBean> searchboard(String what,String WorT,int startRow, int endRow) {
		
		getConnection();
		String sql = "";
		String whats = "%"+what+"%";
		Vector<FAQboardBean> Svec = new Vector<FAQboardBean>();
		try {
			
			if(WorT.equals("title")){
				//	sql = "select * from faqBoardT where fb_title like ?";
					sql = "select * from (select A.*, Rownum Rnum from (select * from FAQboardT where fb_title like ? order by fb_no desc)A) where Rnum >=? and Rnum <= ?";
					pstmt = conn.prepareStatement(sql);
				}else if(WorT.equals("writer")){
					//sql = "select * from faqBoardT where fb_writer like ?";
					sql = "select * from (select A.*, Rownum Rnum from (select * from FAQboardT where fb_writer like ? order by fb_no desc)A) where Rnum >=? and Rnum <= ?";
					pstmt = conn.prepareStatement(sql);
				};
				
				pstmt.setString(1, whats);
				pstmt.setInt(2, startRow); 
				pstmt.setInt(3, endRow);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					FAQboardBean fbBean = new FAQboardBean();
					
					fbBean.setFb_no(rs.getInt(1));
					fbBean.setFb_reply(rs.getInt(2));
					fbBean.setFb_title(rs.getString(3));
					fbBean.setFb_contents(rs.getString(4));
					fbBean.setFb_writer(rs.getString(5));
					fbBean.setFb_writeDate(rs.getTimestamp(6));
					fbBean.setFb_rewriteDate(rs.getTimestamp(7));
					fbBean.setFb_viewCount(rs.getInt(8));
					fbBean.setFb_answered(rs.getInt(9));
					fbBean.setFb_notice(rs.getInt(10));
					Svec.add(fbBean);
				}
				if(conn != null) {
					conn.commit();
					conn.close();
				}
		}catch(Exception e){
		e.printStackTrace();
	}
		return Svec;
	}
}
