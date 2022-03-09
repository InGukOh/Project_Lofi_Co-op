package pack_review;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReviewMgr {
	
	public DBConnectionMgr pool;
	private static final String SAVEFOLDER 
	 = "C:/Users/TridentK/git/Project_Lofi_Co-op/src/main/webapp/Resource/ReviewImg";
	//항상바꿔야함 커밋할때마다
	private static String encType = "UTF-8";
	private static int maxSize = 8*1024*1024;
	
	public ReviewMgr() {
		
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	// 리뷰 입력
	public void insertReview(HttpServletRequest req) {
		
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		MultipartRequest	multi = null;
		int fileSize = 0;
		String fileName = null;
		String uEmail = null;

		
		// String subject = null;
		
		try {
			objConn = pool.getConnection();
			sql = "select max(num) from tblReview";
			objPstmt = objConn.prepareStatement(sql);
			objRs = objPstmt.executeQuery();
			
			int ref = 1;
			if(objRs.next()) ref = objRs.getInt(1)+1;
			
			
			
			File file = new File(SAVEFOLDER);
			
			if (!file.exists())
				file.mkdirs();
			
			multi = new MultipartRequest(req, SAVEFOLDER, maxSize, encType, new DefaultFileRenamePolicy());
			
			
			if(multi.getFilesystemName("file") != null) {
				fileName = multi.getFilesystemName("file");
				fileSize = (int)multi.getFile("file").length();
			}
			String content = multi.getParameter("content");
			
			if(multi.getParameter("email") == null || multi.getParameter("email") == " ") {
				uEmail = null;
			}else {
			uEmail=	multi.getParameter("email");
			}
			
		
			
			sql = "insert into tblReview(uName, subject, content, uEmail, ref, pos, depth, regDate, pass, ip, count, fileName, fileSize)"
					+                " values (?, ?, ?, ?, ?, 0, 0, now(), ?, ?, 0, ?, ?)";
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1,  multi.getParameter("uName"));
			objPstmt.setString(2,  multi.getParameter("subject"));
			objPstmt.setString(3,  content);
			objPstmt.setString(4, uEmail);
			objPstmt.setInt(5,  ref);
			objPstmt.setString(6,  multi.getParameter("pass"));
			objPstmt.setString(7,  multi.getParameter("ip"));
		
			objPstmt.setString(8,  fileName);
			objPstmt.setInt(9,  fileSize);
			objPstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("SQL"+ e.getMessage());
		}catch (Exception e) {
			System.out.println("DB" + e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
	}
	
	// 리뷰 입력 끝
	
	// List 출력
	
	public Vector<ReviewBean> getReviewList(String keyField, String keyWord, int start, int end){
		
		Vector<ReviewBean> vList = new Vector<>();
		Connection objConn = null;
		PreparedStatement	objPstmt = null;
		ResultSet objRs = null;
		String sql	= null;
		
		
		
		try {
			objConn = pool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
			
			sql = "select*from tblReview order by num desc limit ?,?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, start);
			objPstmt.setInt(2, end);
						
			
			} else {
				sql = "select*from tblReview where "+keyField+" like ? order by num desc limit ?,?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%"+keyWord+"%");
				objPstmt.setInt(2, start);
				objPstmt.setInt(3, end);
								
			}
			
			objRs = objPstmt.executeQuery();
			
			while(objRs.next()) {
				ReviewBean bean = new ReviewBean();
				bean.setNum(objRs.getInt("num"));
				bean.setSubject(objRs.getString("subject"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setuName(objRs.getString("uName"));
				bean.setContent(objRs.getString("content"));
				bean.setFileName(objRs.getString("fileName"));
				
				
				vList.add(bean);
			}
			
			
		}catch (Exception e) {
			System.out.println("SQL : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return vList;
	}
	
	// List 출력 끝
	
	// Read 시작
	
	public ReviewBean getReview(int num) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		
		ReviewBean bean = new ReviewBean();
		try {
			objConn = pool.getConnection();
			sql = "select*from tblReview where num = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next()) {
				bean.setNum(objRs.getInt("num"));
				bean.setuName(objRs.getString("uName"));
				bean.setSubject(objRs.getString("subject"));
				bean.setContent(objRs.getString("content"));
				bean.setuEmail(objRs.getString("uEmail"));
				bean.setPos(objRs.getInt("pos"));
				bean.setDepth(objRs.getInt("depth"));
				bean.setRegDate(objRs.getString("regDate"));
				bean.setPass(objRs.getString("pass"));
				bean.setCount(objRs.getInt("count"));
				bean.setFileName(objRs.getString("fileName"));
				bean.setFileSize(objRs.getInt("fileSize"));
				bean.setIp(objRs.getString("ip"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("SQL : "+e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return bean;
	}
	// Read 끝
	
	// 페이지 출력
	
	public int getTotalCount(String keyField, String keyWord) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		int totalCnt = 0;
		
		try {
			objConn = pool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblReview";
				objPstmt = objConn.prepareStatement(sql);
			} else {
				sql = "select count(*) from tblReview ";
				sql += "where "+keyField+" like ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%" + keyWord + "%");
			}

			objRs = objPstmt.executeQuery();

			if (objRs.next()) {
				totalCnt = objRs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}

		return totalCnt;
	}
	
		
	// 페이지 출력 끝
	
	// 리뷰 수정
	
	public int updateReview(ReviewBean bean) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;

		
		int exeCnt = 0;
		
		try {
			

			
			objConn = pool.getConnection();
			sql = "update tblReview set uName=?, subject=?, content=?, uEmail=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuName());
			objPstmt.setString(2, bean.getSubject());
			objPstmt.setString(3, bean.getContent());
			objPstmt.setString(4, bean.getuEmail());
			objPstmt.setInt(5, bean.getNum());
			exeCnt = objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("SQL : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	
	}
	
	// 리뷰 수정 끝
	
	//Delete 시작
	
	public int deleteReview(int num) {
		
		Connection objConn = null;
		PreparedStatement objPstmt = null;
		ResultSet objRs = null;
		String sql = null;
		
		
		
		int exeCnt = 0;
		
		try {
			objConn = pool.getConnection();
			
			sql = "select fileName from tblReview where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1,  num);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next() && objRs.getString(1) != null) {
				if(!objRs.getString(1).equals("")) {
					String fName = objRs.getString(1);
					String fileSrc = SAVEFOLDER + "/1234" + fName;
					File file = new File(fileSrc);
					
					if(file.exists())
						file.delete();
				}
			}
			
			
			sql = "delete from tblReview where num = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("SQL : "+e.getMessage());
		}finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		
		return exeCnt;
		
		
	}
	
	
	//Delete 끝
	

}
