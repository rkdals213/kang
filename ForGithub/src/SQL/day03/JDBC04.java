package day03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class JDBC04 {

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
			int sal = 2000;
			int deptno = 30;
			String sql = "select * from emp where sal > ? and deptno = ?";
			PreparedStatement pSt = con.prepareStatement(sql);
			pSt.setInt(1, sal);
			pSt.setInt(2, deptno);
			// 4. SQL Execute
			rs = pSt.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString("ename") + " : " + rs.getInt("sal"));				
			}	
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
