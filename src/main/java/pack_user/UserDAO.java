package pack_user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import pack_goods.DBConnectionMgr;

public class UserDAO {
	
	private DBConnectionMgr pool;
	
	public UserDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		}
	}
	
	//////////////////////////////// 로그인 ////////////////////////////////
	public int login(String uID, String uPw,String authority) {
		
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql_checkPw 		=		null;
		String						sql_chekAuth 	=		null;
		
		sql_chekAuth = "select authority from userInfo where uID = ?;";

		try {
			objConn = pool.getConnection();
			sql_checkPw = "select uPw from userInfo where uID = ?";
			objPstmt = objConn.prepareStatement(sql_checkPw); 
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next()) {
				if(objRs.getString(1).equals(uPw)) { // 아이디 / 비밀번호가 일치할때
					sql_chekAuth = "select authority from userInfo where uID = ?"; //사용자 권한 확인
					objPstmt = objConn.prepareStatement(sql_chekAuth);
					objPstmt.setString(1, uID);
					objRs = objPstmt.executeQuery();
					if(objRs.next()) {
						if(objRs.getString(1).equals("admin")) {//권한이 관리자일때
							authority = "admin"; //관리자 권한 부여
							return 2;
						} else {
							authority = "user"; //일반 사용자 권한 부여
							return 1;
						}
					}
				} else {
					return -1;
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return -2; //오류
	}
	
	//////////////////////////////// 회원가입 ////////////////////////////////
	public int join(User user) {
		Connection				objConn 			=		null;
		PreparedStatement	objPstmt 			=		null;
		ResultSet					objRs 				=		null;
		String						sql_join 		=		null;
		
		  try {
			  objConn = pool.getConnection();
			  sql_join  = "insert into userInfo values(?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			  objPstmt = objConn.prepareStatement(sql_join); //쿼리문1을 대기 시킨다
			  objPstmt.setString(1, user.getNationality());
			  objPstmt.setString(2, user.getCertify());
			  objPstmt.setString(3, user.getuID());
			  objPstmt.setString(4, user.getuPw());
			  objPstmt.setString(5, user.getuZip());
			  objPstmt.setString(6, user.getuAddr1());
			  objPstmt.setString(7, user.getuAddr2());
			  objPstmt.setString(8, user.getAuthority());
			  objPstmt.setString(9, user.getuEmail()); //이메일
			  objPstmt.setString(10, user.getPhoneNum1());//핸드폰번호1
			  objPstmt.setString(11, user.getPhoneNum2());//핸폰2
			  objPstmt.setString(12, user.getPhoneNum3());//핸폰3
			  objPstmt.setInt(13, user.getBirthYear());
			  objPstmt.setInt(14, user.getBirthMonth());
			  objPstmt.setInt(15, user.getBirthDay());
			  objPstmt.setString(16, user.getRecommend());
			  objPstmt.setString(17, user.getuName());
			  return objPstmt.executeUpdate();
		  } catch (SQLException e) {
				System.out.println("SQL 이슈 : " + e.getMessage());
			} catch (Exception e) {
				System.out.println("DB 접속이슈 : " + e.getMessage());
			} finally {
				pool.freeConnection(objConn, objPstmt, objRs);
			}
		  return -1;
		}
///////////////////////////////////////////////////////////////////	
/////// Member_Mod.jsp 회원정보 수정 입력폼 시작 /////////////
///////////////////////////////////////////////////////////////////

public Vector modifyMember(String uID) {

Vector<User> vList = new Vector<>();

Connection objConn = null;
PreparedStatement objPstmt = null;
ResultSet objRs = null;

String sql = null;

try {
objConn = pool.getConnection();
sql = "select * from userInfo where uID=?";
objPstmt = objConn.prepareStatement(sql);
objPstmt.setString(1, uID);

objRs = objPstmt.executeQuery();

if (objRs != null) {
while (objRs.next()) {

	User user = new User();
	  user.setuID(objRs.getString("uID"));
	  user.setuPw(objRs.getString("uPw"));
	  user.setuZip(objRs.getString("uZip"));
	  user.setuAddr1(objRs.getString("uAddr1"));
	  user.setuAddr2(objRs.getString("uAddr2"));
	  user.setuEmail(objRs.getString("uEmail"));
	
	user.setPhoneNum1(objRs.getString("PhoneNum1"));
	user.setPhoneNum2(objRs.getString("PhoneNum2"));
	user.setPhoneNum3(objRs.getString("PhoneNum3"));
		 
	  user.setuName(objRs.getString("uName"));


vList.add(user);

}
}

} catch (Exception e) {

System.out.println("SQL 이슈 : " + e.getMessage());

} finally {
pool.freeConnection(objConn, objPstmt, objRs);
}

return vList;
}

///////////////////////////////////////////////////////////////////	
/////// Member_Mod.jsp 회원정보 수정 입력폼 끝 /////////////
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////	
/////// Member_ModProc.jsp 회원정보 수정 시작 /////////////
///////////////////////////////////////////////////////////////////	
public boolean modifyMember(String uPw, String uName, String uZip,String uAddr1, String uAddr2,String uEmail,String uID) {

Connection objConn = null;
PreparedStatement objPstmt = null;
String sql = null;
boolean flag = false;

try {
objConn = pool.getConnection();

sql = "update userInfo set ";
sql += "uPw=?, uName=?, uZip=?,  uAddr1=?, uAddr2=?, uEmail=?"; 
sql += "where uID = ?";
objPstmt = objConn.prepareStatement(sql);
objPstmt.setString(1, uPw);
objPstmt.setString(2, uName);
objPstmt.setString(3, uZip);
objPstmt.setString(4, uAddr1);
objPstmt.setString(5, uAddr2);
objPstmt.setString(6, uEmail);
objPstmt.setString(7, uID);




int cnt = objPstmt.executeUpdate();
if (cnt > 0)
flag = true; // update가 정상실행되었음을 의미

} catch (Exception e) {

System.out.println("SQL 이슈 : " + e.getMessage());

} finally {
pool.freeConnection(objConn, objPstmt);
}

return flag;
}


///////////////////////////////////////////////////////////////////	
/////// Member_ModProc.jsp 회원정보 수정 끝 /////////////
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////	
//////////////Member_Del.jsp 회원탈퇴 시작 ////////////////////
///////////////////////////////////////////////////////////////////	
public boolean deleteMember(String uID) {

Connection objConn = null;
PreparedStatement objPstmt = null;
String sql = null;
boolean flag = false;

try {
objConn = pool.getConnection();

sql = "delete from userInfo where uID = ?";
objPstmt = objConn.prepareStatement(sql);
objPstmt.setString(1, uID);

int cnt = objPstmt.executeUpdate();
if (cnt > 0)
flag = true; // update가 정상실행되었음을 의미

} catch (Exception e) {

System.out.println("SQL 이슈 : " + e.getMessage());

} finally {
pool.freeConnection(objConn, objPstmt);
}

return flag;
}

///////////////////////////////////////////////////////////////////	
//////////////Member_Del.jsp 회원탈퇴 끝 ////////////////////
///////////////////////////////////////////////////////////////////
	
	//지갑 충전 시작
public int money(String uID, int Wallet) {
	Connection					objConn		=	null;
	PreparedStatement 		objPstmt 		= 	null;
	ResultSet						objRs			=	null;
	String							sql 				=	null;

	System.out.println("==== "+uID + " 가 " + Wallet +" 원 충전 ==== \n");
	System.out.println();
	try {
		objConn = pool.getConnection();
		sql= "update userInfo set wallet = wallet + ? where uID = ?";
		objPstmt = objConn.prepareStatement(sql);
		objPstmt.setInt(1, Wallet);
		objPstmt.setString(2,uID);
		return objPstmt.executeUpdate();
		
	} catch (SQLException e) {
		System.out.println("SQL 이슈 : " + e.getMessage());
	} catch (Exception e) {
		System.out.println("DB 접속이슈 : " + e.getMessage());
	} finally {
		pool.freeConnection(objConn, objPstmt, objRs);
	}
	return -1;
}
	//지갑확인 시작
	public int Wallet(String uID) {
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;
		
		
		try {
			objConn = pool.getConnection();
			
			sql= "select Wallet from userInfo where uID = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery();
			if(objRs.next()) {
				return objRs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return -1;
	}
	//지갑확인 끝
	
	//결제 시작 
	public int Pay(String uID, int pay) {
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;
		
		System.out.println("==== "+uID + " 가 " + pay +" 원 결제 ==== \n");
		System.out.println();
		try {
			objConn = pool.getConnection();
			sql= "update userInfo set wallet = wallet - ? where uID = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, pay);
			objPstmt.setString(2,uID);
			return objPstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return -1;
	}
	
	//결제 끝
	
	//유저정보 시작
	public User userInfo(String uID) {
		Connection					objConn		=	null;
		PreparedStatement 		objPstmt 		= 	null;
		ResultSet						objRs			=	null;
		String							sql 				=	null;
		
		
		User info = new User();
		try {
			objConn = pool.getConnection();
			
			sql= "select * from userInfo where uID = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uID);
			objRs = objPstmt.executeQuery();
			
			if(objRs.next()) {
				info.setuZip(objRs.getString("uZip"));
				info.setuAddr1(objRs.getString("uAddr1"));
				info.setuAddr2(objRs.getString("uAddr2"));
			}

			
		} catch (SQLException e) {
			System.out.println("SQL 이슈 : " + e.getMessage());
		} catch (Exception e) {
			System.out.println("DB 접속이슈 : " + e.getMessage());
		} finally {
			pool.freeConnection(objConn, objPstmt, objRs);
		}
		return info;
	}
}