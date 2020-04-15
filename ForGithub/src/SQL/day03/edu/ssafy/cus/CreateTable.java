package day03.edu.ssafy.cus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class CreateTable {
	public static void main(String[] args) throws Exception {
		// 1. Driver Loading
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2. Connection	
		Connection con = 
				DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/scott?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8","ssafy","root");
		// 3. statement Create
		Statement st = con.createStatement();
		// 4. SQL Execute
		String sql = "create table customer(num int primary key, name varchar(20), address varchar(100) )";
		st.execute(sql);

		System.out.println("sql 실행 완료");
		st.close();
		con.close();
	}
}
