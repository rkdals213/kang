package day03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class JDBC05 {

	public static void main(String[] args) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			// 1. Driver Loading
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 2. Connection	
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/scott?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8","ssafy","root");
			// 3. statement Create
			int empno = 8888;
			String ename = "도우너";
			int sal = 3000;
			int deptno = 30;
			String sql = "insert into emp(empno, ename, sal, deptno) values(?,?,?,?)";
			PreparedStatement pSt = con.prepareStatement(sql);
			pSt.setInt(1, empno);
			pSt.setString(2, ename);
			pSt.setInt(3, sal);
			pSt.setInt(4, deptno);
			// 4. SQL Execute
			pSt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			System.out.println("sql 실행 완료");
			try {
				if(rs!=null) rs.close();
				if(st!=null) st.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}		
	}
}
