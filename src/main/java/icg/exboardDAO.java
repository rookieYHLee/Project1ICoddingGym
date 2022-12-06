package icg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Vector;


public class exboardDAO {

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
	
	
		public void insertBoard(exboardBean bBean) {
			
			getConnection();
			
			try {						
											
				String sql = "insert into exBoardT(e_no, e_title, e_imageURL, e_contents, e_writer) values"
						+ "(e_sq.nextval, ?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, bBean.getE_title());
				pstmt.setString(2, bBean.getE_imageURL());
				pstmt.setString(3, bBean.getE_contents());
				pstmt.setString(4, bBean.getE_writer());			
				
				pstmt.executeUpdate();
				
				if(conn != null) {
					conn.commit();
					conn.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}	
			
	public Vector<exboardBean> allselectboard(int startRow, int endRow) {
			
			getConnection();
			Vector<exboardBean> vec = new Vector<exboardBean>();
					
			try {
					String sql = "select * from (select A.*, Rownum Rnum from (select * from exboardT order by e_no desc)A) where Rnum >=? and Rnum <= ?";
				
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startRow); 
					pstmt.setInt(2, endRow); 
					
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						
						exboardBean bBean = new exboardBean();
						
						bBean.setE_no(rs.getInt(1));
						bBean.setE_title(rs.getString(2));
						bBean.setE_contents(rs.getString(3));
						bBean.setE_writer(rs.getString(4));
						bBean.setE_writeDate(rs.getTimestamp(5));
						bBean.setE_rewriteDate(rs.getTimestamp(6));
						bBean.setE_viewCount(rs.getInt(7));
						bBean.setE_reviewCount(rs.getInt(8));
						bBean.setE_imageURL(rs.getString(9));
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
		
		
		
		
	public exboardBean oneselectboard(int e_no){
			
			exboardBean eBean = new exboardBean();
			
			try {
				getConnection();
				
				//count
				String readsql = "update exBoardT set e_viewCount = e_viewCount+1 where e_no = ?";
				pstmt = conn.prepareStatement(readsql);
				pstmt.setInt(1, e_no);
				pstmt.executeUpdate();
				
				String replysql = "update exboardt\r\n"
						+ "set e_reviewCount = (select count(distinct(er_no)) from exboardreplyt\r\n"
						+ "                        where exboardt.e_no = exboardreplyt.e_no) "
						+ "where e_no = ?";
						
				pstmt = conn.prepareStatement(replysql);
				pstmt.setInt(1, e_no); 
				pstmt.executeUpdate();
				
				
				String sql = "select * from exBoardT where e_no =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, e_no);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
									
					eBean.setE_no(rs.getInt(1));
					eBean.setE_title(rs.getString(2));
					eBean.setE_contents(rs.getString(3));
					eBean.setE_writer(rs.getString(4));
					eBean.setE_writeDate(rs.getTimestamp(5));
					eBean.setE_rewriteDate(rs.getTimestamp(6));
					eBean.setE_viewCount(rs.getInt(7));
					eBean.setE_reviewCount(rs.getInt(8));
					eBean.setE_imageURL(rs.getString(9));
									
				}
				if(conn != null) {
					conn.commit();
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return eBean;
		}
	
	
	
	public void rewriteBoard(exboardBean bBean) {
			
			getConnection();			
					
			try {
																		//두번째 물음표는 re_level
				
				
				String sql2 = "insert into exBoardReplyT(e_no,er_no,er_contents,er_writer) values(?,er_sq.nextval, ?, ?);";
				pstmt = conn.prepareStatement(sql2);
				
				//pstmt class가 set 처리를 하겠다
				pstmt.setInt(1, bBean.getE_no()); //boardBean -> setWriter(), getWriter() 메모리상의 데이터를 호출
				pstmt.setString(2, bBean.getE_contents());
				pstmt.setString(3, bBean.getE_writer());
				
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
		}
	
	//게시판 글 수정 반환 호출
	public exboardBean UpdateOneSelectBoard(int e_no){
	
		exboardBean eBean = new exboardBean();
		
		try {
			getConnection();
			
			String sql = "select * from exBoardT where e_no =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, e_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
								
				eBean.setE_no(rs.getInt(1));
				eBean.setE_title(rs.getString(2));
				eBean.setE_contents(rs.getString(3));
				eBean.setE_writer(rs.getString(4));
				eBean.setE_writeDate(rs.getTimestamp(5));
				eBean.setE_rewriteDate(rs.getTimestamp(6));
				eBean.setE_viewCount(rs.getInt(7));
				eBean.setE_reviewCount(rs.getInt(8));
				eBean.setE_imageURL(rs.getString(9));
				
			}
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return eBean;
	}
		
	
	
	public void updateBoard(exboardBean eBean){
		
		try {
			getConnection();
			
			String sql = "update exBoardT set e_title = ?, e_contents = ?, e_rewriteDate = systimestamp where e_no =?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, eBean.getE_title());
			pstmt.setString(2, eBean.getE_contents());
			pstmt.setInt(3, eBean.getE_no());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getAllcount() {
			
			getConnection();
			
			int count = 0;
			
			try {
				
				String sql = "select count(*) from exBoardT";
				
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
	
	
	public void delete(int e_no) {

		getConnection();
		
		try {
			String SQL = "DELETE FROM exBoardT WHERE e_no = ?";
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, e_no);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
			        if(pstmt != null) pstmt.close();
			        if(conn != null) conn.close();
				} catch (Exception e) {
					e.printStackTrace();
			}
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
					sql = "select count(*) from exBoardT where e_title like ?";
					pstmt = conn.prepareStatement(sql);
				}else if(WorT.equals("writer")){
					sql = "select count(*) from eBoardT where e_writer like ?";
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
	
	
	
	public Vector<exboardBean> searchboard(String what,String WorT,int startRow, int endRow) {
			
			getConnection();
			String sql = "";
			String whats = "%"+what+"%";
			Vector<exboardBean> Svec = new Vector<exboardBean>();
			try {
				
				if(WorT.equals("title")){
					//	sql = "select * from faqBoardT where fb_title like ?";
						sql = "select * from (select A.*, Rownum Rnum from (select * from exboardT where e_title like ? order by e_no desc)A) where Rnum >=? and Rnum <= ?";
						pstmt = conn.prepareStatement(sql);
					}else if(WorT.equals("writer")){
						//sql = "select * from faqBoardT where fb_writer like ?";
						sql = "select * from (select A.*, Rownum Rnum from (select * from exboardT where e_writer like ? order by e_no desc)A) where Rnum >=? and Rnum <= ?";
						pstmt = conn.prepareStatement(sql);
					};
					
					pstmt.setString(1, whats);
					pstmt.setInt(2, startRow); 
					pstmt.setInt(3, endRow);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						
						exboardBean eBean = new exboardBean();
						
						eBean.setE_no(rs.getInt(1));
						eBean.setE_title(rs.getString(2));
						eBean.setE_contents(rs.getString(3));
						eBean.setE_writer(rs.getString(4));
						eBean.setE_writeDate(rs.getTimestamp(5));
						eBean.setE_rewriteDate(rs.getTimestamp(6));
						eBean.setE_viewCount(rs.getInt(7));
						eBean.setE_reviewCount(rs.getInt(8));
						eBean.setE_imageURL(rs.getString(9));
						
						Svec.add(eBean);
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