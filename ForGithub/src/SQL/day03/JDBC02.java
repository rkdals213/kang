package day03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class JDBC02 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// 1. Driver Loading
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2. Connection	
		Connection con = 
		DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/scott?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8","ssafy","root");
		// 3. statement Create
		Statement st = con.createStatement();
		// 4. SQL Execute
		String sql = "insert into emp(empno, ename, sal) values(9999, '또치', 3000)";
		st.execute(sql);
		
		System.out.println("sql 실행 완료");
		st.close();
		con.close();
	}
}
