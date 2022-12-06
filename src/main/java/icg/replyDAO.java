package icg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

	//데이터 베이스 연동
public class replyDAO {
	
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
	//강의 게시판 게시글 댓글 작성
	public void exboardReplyWrite(replyBean rBean) {
		getConnection();
		
		try {
			
						
			String sql = "insert into exBoardReplyT(e_no,er_no,er_contents,er_writer,er_reviewScore) values(?,er_sq.nextval,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getE_no()); //boardBean -> setWriter(), getWriter() 메모리상의 데이터를 호출
			pstmt.setString(2, rBean.getR_contents());
			pstmt.setString(3, rBean.getR_writer());
			pstmt.setDouble(4, rBean.getR_reviewScore());
			
			pstmt.executeUpdate();
			
			
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//강의 게시판 게시글 리뷰 조회(작성자)
	public Vector<replyBean> my_exboardReplyAllSelect(int e_no, String id) {
		
		getConnection();
		Vector<replyBean> vec = new Vector<>();
		
		try {
			String sql = "Select * from exBoardReplyT "
					+ "where e_no=? and er_no in (select er_no from exBoardReplyT where e_no=? and er_writer=? and er_reNo=0) "
					+ "order by er_no, er_reNo";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, e_no);
			pstmt.setInt(2, e_no);
			pstmt.setString(3, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				replyBean rBean = new replyBean();
				
				rBean.setE_no(rs.getInt(1));
				rBean.setR_no(rs.getInt(2));
				rBean.setR_reNo(rs.getInt(3));
				rBean.setR_contents(rs.getString(4));
				rBean.setR_writer(rs.getString(5));
				rBean.setR_writeDate(rs.getTimestamp(6));
				rBean.setR_rewriteDate(rs.getTimestamp(7));
				rBean.setR_reviewScore(rs.getDouble(8));
				
				
				vec.add(rBean);
			}
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return vec;
		
	}
	//강의 게시판 게시글 리뷰 조회(비작성자)
	public Vector<replyBean> exboardReplyAllSelect(int e_no, String id) {
		
		getConnection();
		Vector<replyBean> vec = new Vector<>();
		
		try {
			String sql = "Select * from exBoardReplyT "
					+ "where e_no=? and er_no in (select er_no from exBoardReplyT where e_no=? and er_writer!=? and er_reNo=0) "
					+ "order by er_no, er_reNo";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, e_no);
			pstmt.setInt(2, e_no);
			pstmt.setString(3, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				replyBean rBean = new replyBean();
				
				rBean.setE_no(rs.getInt(1));
				rBean.setR_no(rs.getInt(2));
				rBean.setR_reNo(rs.getInt(3));
				rBean.setR_contents(rs.getString(4));
				rBean.setR_writer(rs.getString(5));
				rBean.setR_writeDate(rs.getTimestamp(6));
				rBean.setR_rewriteDate(rs.getTimestamp(7));
				rBean.setR_reviewScore(rs.getDouble(8));
				
				
				vec.add(rBean);
			}
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return vec;
		
	}
	
	public void ex_rereplyConfirm(replyBean rBean) {
		
		getConnection();
		
		try {
			
			String sql = "Select max(er_reNo) from exBoardReplyT where e_no=? and er_no=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getE_no());
			pstmt.setInt(2, rBean.getR_no());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			if(rs.getString(1) != null) {
				rBean.setR_reNo(rs.getInt(1)+1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	public void exboardRereplyWrite(replyBean rBean) {
		getConnection();
		
		try {
			
						
			String sql = "insert into exBoardReplyT(e_no,er_no,er_contents,er_writer,er_reNo) values(?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getE_no()); //boardBean -> setWriter(), getWriter() 메모리상의 데이터를 호출
			pstmt.setInt(2, rBean.getR_no());
			pstmt.setString(3, rBean.getR_contents());
			pstmt.setString(4, rBean.getR_writer());
			pstmt.setInt(5, rBean.getR_reNo());
			
			pstmt.executeUpdate();
			
			
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void exboardRereplyUpdate(replyBean rBean) {
		
		try {
			getConnection();
			
			String sql = "update exBoardReplyT set er_contents = ?, er_rewriteDate = systimestamp "
					+ "where e_no = ? and er_no=? and er_reNo=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rBean.getR_contents_up());
			pstmt.setInt(2, rBean.getE_no());
			pstmt.setInt(3, rBean.getR_no());
			pstmt.setInt(4, rBean.getR_reNo());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean ex_reReplyIs(replyBean rBean) {
		boolean r_is = false;
		
		getConnection();
		
		try {
			
			String sql = "Select max(er_reNo) from exBoardReplyT where e_no=? and er_no=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getE_no());
			pstmt.setInt(2, rBean.getR_no());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			if(rs.getInt(1) != 0) {
				r_is = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}	
		
		return r_is;
	}
	
	public void exboardRereplyDeleteUpdate(replyBean rBean) {

		try {
			getConnection();
			
			String sql = "update exBoardReplyT set er_contents = ?, er_rewriteDate = systimestamp "
					+ "where e_no = ? and er_no=? and er_reNo=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "삭제된 댓글입니다.");
			pstmt.setInt(2, rBean.getE_no());
			pstmt.setInt(3, rBean.getR_no());
			pstmt.setInt(4, rBean.getR_reNo());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void exboardRereplyDelete(replyBean rBean) {
		try {
			getConnection();
			
			String sql = "delete from exBoardReplyT where e_no = ? and er_no=? and er_reNo=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, rBean.getE_no());
			pstmt.setInt(2, rBean.getR_no());
			pstmt.setInt(3, rBean.getR_reNo());
			
			pstmt.executeQuery();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Vector<replyBean> boardReplyAllSelect(int b_no) {

		getConnection();
		Vector<replyBean> vec = new Vector<>();
		
		try {
			String sql = "Select * from boardReplyT where b_no=? order by br_no, br_reNo";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				replyBean rBean = new replyBean();
				
				rBean.setB_no(rs.getInt(1));
				rBean.setR_no(rs.getInt(2));
				rBean.setR_reNo(rs.getInt(3));
				rBean.setR_contents(rs.getString(4));
				rBean.setR_writer(rs.getString(5));
				rBean.setR_writeDate(rs.getTimestamp(6));
				rBean.setR_rewriteDate(rs.getTimestamp(7));
				
				
				vec.add(rBean);
			}
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return vec;
	}
	
	public void rereplyConfirm(replyBean rBean) {
		
		getConnection();
		
		try {
			
			String sql = "Select max(br_reNo) from boardReplyT where b_no=? and br_no=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getB_no());
			pstmt.setInt(2, rBean.getR_no());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			if(rs.getString(1) != null) {
				rBean.setR_reNo(rs.getInt(1)+1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	
	public void boardReplyWrite(replyBean rBean) {
		getConnection();
		
		try {
			
						
			String sql = "insert into boardReplyT(b_no,br_no,br_contents,br_writer) values(?,br_sq.nextval,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getB_no()); //boardBean -> setWriter(), getWriter() 메모리상의 데이터를 호출
			pstmt.setString(2, rBean.getR_contents());
			pstmt.setString(3, rBean.getR_writer());
			
			pstmt.executeUpdate();
			
			
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void boardRereplyWrite(replyBean rBean) {
		getConnection();
		
		try {
			
						
			String sql = "insert into boardReplyT(b_no,br_no,br_contents,br_writer,br_reNo) values(?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getB_no()); //boardBean -> setWriter(), getWriter() 메모리상의 데이터를 호출
			pstmt.setInt(2, rBean.getR_no());
			pstmt.setString(3, rBean.getR_contents());
			pstmt.setString(4, rBean.getR_writer());
			pstmt.setInt(5, rBean.getR_reNo());
			
			pstmt.executeUpdate();
			
			
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void boardRereplyUpdate(replyBean rBean) {
		
		try {
			getConnection();
			
			String sql = "update boardReplyT set br_contents = ?, br_rewriteDate = systimestamp "
					+ "where b_no = ? and br_no=? and br_reNo=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rBean.getR_contents_up());
			pstmt.setInt(2, rBean.getB_no());
			pstmt.setInt(3, rBean.getR_no());
			pstmt.setInt(4, rBean.getR_reNo());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean reReplyIs(replyBean rBean) {
		boolean r_is = false;
		
		getConnection();
		
		try {
			
			String sql = "Select max(br_reNo) from boardReplyT where b_no=? and br_no=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rBean.getB_no());
			pstmt.setInt(2, rBean.getR_no());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			if(rs.getInt(1) != 0) {
				r_is = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}	
		
		return r_is;
	}
	
	public void boardRereplyDeleteUpdate(replyBean rBean) {

		try {
			getConnection();
			
			String sql = "update boardReplyT set br_contents = ?, br_rewriteDate = systimestamp "
					+ "where b_no = ? and br_no=? and br_reNo=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "삭제된 댓글입니다.");
			pstmt.setInt(2, rBean.getB_no());
			pstmt.setInt(3, rBean.getR_no());
			pstmt.setInt(4, rBean.getR_reNo());
			
			pstmt.executeUpdate();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void boardRereplyDelete(replyBean rBean) {
		try {
			getConnection();
			
			String sql = "delete from boardReplyT where b_no = ? and br_no=? and br_reNo=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, rBean.getB_no());
			pstmt.setInt(2, rBean.getR_no());
			pstmt.setInt(3, rBean.getR_reNo());
			
			pstmt.executeQuery();
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void boardRereplyAllDelete(int b_no) {
		try {
			getConnection();
			
			String deletesql = "delete from boardReplyT where b_no =?";
			pstmt = conn.prepareStatement(deletesql);
			pstmt.setInt(1, b_no);
			
			pstmt.executeUpdate();

			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void exboardRereplyAllDelete(int e_no) {
		try {
			getConnection();
			
			String deletesql = "delete from exboardReplyT where e_no =?";
			pstmt = conn.prepareStatement(deletesql);
			pstmt.setInt(1, e_no);
			
			pstmt.executeUpdate();

			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//리뷰 평점 구하기
	public double boardReplyScore(int e_no) {
				
		double avg = 0;
		
		try {			
			getConnection();			
						
			String sql = "select trunc(avg(er_reviewscore), 1)\r\n"
					+ "from exboardreplyt\r\n"
					+ "where e_no = ? and er_reno = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, e_no);			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				avg = rs.getDouble(1);
			}	
			
			if(conn != null) {
				conn.commit();
				conn.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return avg;
	}
	
}
