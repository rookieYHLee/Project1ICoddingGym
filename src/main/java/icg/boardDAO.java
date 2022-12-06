package icg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class boardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	//데이터 베이스 연동
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

	//게시글 작성
	public void insertBoard(boardBean bBean) {
		
		getConnection();
		
		try {						
										
			String sql = "insert into boardT(b_no,b_title,b_contents,b_writer) "
					+ "values(b_sq.nextval, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
		
		
			pstmt.setString(1, bBean.getB_title());
			pstmt.setString(2, bBean.getB_contents());
			pstmt.setString(3, bBean.getB_writer());
			
		
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}	
	//게시판 글 출력		
	public Vector<boardBean> allselectboard(int startRow, int endRow) {
			
			getConnection();
			Vector<boardBean> vec = new Vector<boardBean>();
					
			try {
					String sql = "select * from (select A.*, Rownum Rnum from (select * from boardT order by b_no desc)A) where Rnum >=? and Rnum <= ?";
				
					pstmt = conn.prepareStatement(sql);
					
					
					pstmt.setInt(1, startRow); 
					pstmt.setInt(2, endRow);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						
						boardBean bBean = new boardBean();
						
						bBean.setB_no(rs.getInt(1));
						bBean.setB_title(rs.getString(2));
						bBean.setB_contents(rs.getString(3));
						bBean.setB_writer(rs.getString(4));
						bBean.setB_writeDate(rs.getTimestamp(5));
						bBean.setB_rewriteDate(rs.getTimestamp(6));
						bBean.setB_viewCount(rs.getInt(7));						
						bBean.setB_imageURL(rs.getString(8));
						bBean.setB_notice(rs.getString(9));
						bBean.setB_replyCount(rs.getInt(10));
						vec.add(bBean);
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
		
		
	//게시글 상세보기	
	public boardBean oneselectboard(int b_no){
			
			boardBean bBean = new boardBean();
			
			try {
				getConnection();
				
				//count
				String readsql = "update BoardT set b_viewCount = b_viewCount+1 where b_no = ?";
				pstmt = conn.prepareStatement(readsql);
				pstmt.setInt(1, b_no);
				pstmt.executeUpdate();
				
				
				String replysql = "update BoardT\r\n"
						+ "set b_replyCount = (select count(distinct(br_no)) from boardReplyT\r\n"
						+ "                        where BoardT.b_no = boardReplyT.b_no) "
						+ "where b_no = ?";
						
				pstmt = conn.prepareStatement(replysql);
				pstmt.setInt(1, b_no); 
				pstmt.executeUpdate();
				
				
				
				
				String sql = "select * from BoardT where b_no =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_no);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
									
					bBean.setB_no(rs.getInt(1));
					bBean.setB_title(rs.getString(2));
					bBean.setB_contents(rs.getString(3));
					bBean.setB_writer(rs.getString(4));
					bBean.setB_writeDate(rs.getTimestamp(5));
					bBean.setB_rewriteDate(rs.getTimestamp(6));
					bBean.setB_viewCount(rs.getInt(7));
					bBean.setB_imageURL(rs.getString(8));
					bBean.setB_notice(rs.getString(9));	
					bBean.setB_replyCount(rs.getInt(10));
				}
				if(conn != null) {
					conn.commit();
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return bBean;
		}
	
	
	

	//게시판 글 수정 반환 호출
	public boardBean UpdateOneSelectBoard(int b_no){
	
		boardBean bBean = new boardBean();
		
		try {
			getConnection();
			
			String sql = "select * from BoardT where b_no =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
								
				bBean.setB_no(rs.getInt(1));
				bBean.setB_title(rs.getString(2));
				bBean.setB_contents(rs.getString(3));
				bBean.setB_writer(rs.getString(4));
				bBean.setB_writeDate(rs.getTimestamp(5));
				bBean.setB_rewriteDate(rs.getTimestamp(6));
				bBean.setB_viewCount(rs.getInt(7));
				bBean.setB_imageURL(rs.getString(8));
				bBean.setB_notice(rs.getString(9));	
				bBean.setB_replyCount(rs.getInt(10));
			}
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return bBean;
	}
	
	
	//게시글 전체 수
	public int getAllcount() {
			
			getConnection();
			
			int count = 0;
			
			try {
				
				String sql = "select count(*) from BoardT";
				
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
	//게시글 수정	
public void updateBoard(boardBean bBean) {
		
		try {
			getConnection();
			
			String sql = "update boardT set b_title= ?, b_contents= ?, b_rewriteDate = systimestamp where b_no = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bBean.getB_title());
			pstmt.setString(2, bBean.getB_contents());
			pstmt.setInt(3, bBean.getB_no());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//게시글 삭제
	public void deldeteBoard(int b_no) {
		
		try {
			getConnection();
			
			String sql = "delete from BoardT where b_no =? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, b_no);
			
			pstmt.executeQuery();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//검색 기능
		public int getSearchcount(String what,String WorT) {
				
				getConnection();
				
				int count = 0;
				String whats = "%"+what+"%";
				
				//sql문 수정아직안함
				try {
					
					String sql = "";
					if(WorT.equals("title")){
						sql = "select count(*) from BoardT where b_title like ?";
						pstmt = conn.prepareStatement(sql);
					}else if(WorT.equals("writer")){
						sql = "select count(*) from BoardT where b_writer like ?";
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
	//게시글 검색화면 게시글 조회	
	public Vector<boardBean> searchboard(String what,String WorT,int startRow, int endRow) {
		
		getConnection();
		String sql = "";
		String whats = "%"+what+"%";
		Vector<boardBean> Svec = new Vector<boardBean>();
		try {
			
			if(WorT.equals("title")){
				//	sql = "select * from faqBoardT where fb_title like ?";
					sql = "select * from (select A.*, Rownum Rnum from (select * from boardT where b_title like ? order by b_no desc)A) where Rnum >=? and Rnum <= ?";
					pstmt = conn.prepareStatement(sql);
				}else if(WorT.equals("writer")){
					//sql = "select * from faqBoardT where fb_writer like ?";
					sql = "select * from (select A.*, Rownum Rnum from (select * from boardT where b_writer like ? order by b_no desc)A) where Rnum >=? and Rnum <= ?";
					pstmt = conn.prepareStatement(sql);
				};
				
				pstmt.setString(1, whats);
				pstmt.setInt(2, startRow); 
				pstmt.setInt(3, endRow);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					boardBean bBean = new boardBean();
					
					bBean.setB_no(rs.getInt(1));
					bBean.setB_title(rs.getString(2));
					bBean.setB_contents(rs.getString(3));
					bBean.setB_writer(rs.getString(4));
					bBean.setB_writeDate(rs.getTimestamp(5));
					bBean.setB_rewriteDate(rs.getTimestamp(6));
					bBean.setB_viewCount(rs.getInt(7));
					bBean.setB_imageURL(rs.getString(8));
					bBean.setB_notice(rs.getString(9));	
					bBean.setB_replyCount(rs.getInt(10));
					Svec.add(bBean);
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
	//전체 글
		public int bsCount() {
			
			int count = 0;
			getConnection();
			
			try {
				
				String csql = "select count(*) from BoardT";
				
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
