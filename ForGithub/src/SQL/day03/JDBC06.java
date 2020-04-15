package day03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.cj.jdbc.result.ResultSetMetaData;


public class JDBC06 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// 1. Driver Loading
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2. Connection	
		Connection con = 
		DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/scott?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8","ssafy","root");
		// 3. statement Create
		Statement st = con.createStatement();
		// 4. SQL Execute
		ResultSet rs = st.executeQuery("select * from emp");
		ResultSetMetaData metaData = (ResultSetMetaData) rs.getMetaData();
		int cnt = metaData.getColumnCount();
		System.out.println(cnt);
		for (int i = 1; i <= cnt; i++) {
			System.out.print(metaData.getColumnName(i) + " ");
		}
//		while(rs.next()) {
//			System.out.println(rs.getString("ename") + " : " + rs.getInt("sal"));			
//		}
		rs.close();
		st.close();
		con.close();
	}
}
