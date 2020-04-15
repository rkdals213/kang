package day03.edu.ssafy.cus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO implements DAO {

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("class loading failure");
		}	
	}
	
	private Connection getConnection() throws SQLException {
		Connection con = 
				DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/scott?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8","ssafy","root");
		return con;		
	}

	public void insertCustomer(int num, String name, String address) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "insert into customer(num, name, address) values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, name);
			pstmt.setString(3, address);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			System.out.println("sql 실행 완료");
			try {
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
	}

	public void deleteCustomer(int num) {

	}

	public void updateCustomer(int num, String name, String address) {

	}

	public List<Customer> allViewCustomer() {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		ArrayList<Customer> list = new ArrayList<>();
		try {
			con = getConnection();
			String sql = "select * from customer";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new Customer(rs.getInt("num"), rs.getString("name"), rs.getString("address")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			System.out.println("sql 실행 완료");
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public Customer findCustomer(int num) {
		return null;
	}

}
