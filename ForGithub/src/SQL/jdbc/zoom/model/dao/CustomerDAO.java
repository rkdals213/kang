package jdbc.zoom.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jdbc.zoom.model.dto.Customer;
import jdbc.zoom.util.DBUtil;

public class CustomerDAO {
	DBUtil util = DBUtil.getUtil();
	// 기능만 -- singletone
	private static CustomerDAO dao = new CustomerDAO();

	public static CustomerDAO getDao() {
		return dao;
	}

	private CustomerDAO() {}
	
	public int update(Customer cust) throws Exception {
		StringBuilder sb = new StringBuilder("update customer");
		sb.append(" set first_name=?, last_name=?").append(" where customer_id=?");
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, cust.getFirstName());
			pstmt.setString(2, cust.getLastName());
			pstmt.setInt(3, cust.getCustomerId());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt);
		}
		return result;
	}
	
	public int insert(Customer cust) throws Exception {
		StringBuilder sb = new StringBuilder("insert into customer ");
		sb.append("(customer_id, store_id, first_name, last_name, address_id, active, create_date)")
		.append(" values(?,?,?,?,?,?,?)");
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setInt(1, cust.getCustomerId());
			pstmt.setInt(2, cust.getStoreId());
			pstmt.setString(3, cust.getFirstName());
			pstmt.setString(4, cust.getLastName());
			pstmt.setInt(5, cust.getAddressId());
			pstmt.setInt(6, cust.getActive());
			pstmt.setDate(7, cust.getCreateDate());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt);
		}
		return result;
	}
	
	
	// first_name이 S로 시작하는 사람의 목록을 반환하는 메서드를 작성 
	public List<Customer> selectbyNameLike(String pattern) throws Exception {
		String sql = "select * from customer where first_name like ?";

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Customer> list = new ArrayList<>();
		try {
			// 1. connection 획득
			con = util.getConnection();
			// 2. statement 획득
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + pattern + "%");
			// 4. 결과 확인
			rs = pstmt.executeQuery();

			while(rs.next()) {
				Integer customerId = rs.getInt(1);
				Integer storeId = rs.getInt(2);
				String firstName = rs.getString(3);
				String lastName = rs.getString(4);
				String email = rs.getString(5);
				Integer addressId = rs.getInt(6);
				Integer active = rs.getInt(7);
				Date createDate = rs.getDate(8);
				Date lastUpdate = rs.getDate(9);				

				list.add(new Customer(customerId, storeId, firstName, lastName, email, addressId, active, createDate, lastUpdate));
			}
		} catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt, rs);
		}
		return list;
	}

	public List<Customer> selectAll() throws Exception {
		String sql = "select * from customer";

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Customer> list = new ArrayList<>();
		try {
			// 1. connection 획득
			con = util.getConnection();
			// 2. statement 획득
			pstmt = con.prepareStatement(sql);
			// 4. 결과 확인
			rs = pstmt.executeQuery();

			while(rs.next()) {
				Integer customerId = rs.getInt(1);
				Integer storeId = rs.getInt(2);
				String firstName = rs.getString(3);
				String lastName = rs.getString(4);
				String email = rs.getString(5);
				Integer addressId = rs.getInt(6);
				Integer active = rs.getInt(7);
				Date createDate = rs.getDate(8);
				Date lastUpdate = rs.getDate(9);				

				list.add(new Customer(customerId, storeId, firstName, lastName, email, addressId, active, createDate, lastUpdate));
			}
		} catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt, rs);
		}
		return list;
	}

	public Customer selectById(int customerId) throws Exception{
		String sql = "select * from customer where customer_id=?";

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Customer customer = null;
		try {
			// 1. connection 획득
			con = util.getConnection();
			// 2. statement 획득
			pstmt = con.prepareStatement(sql);
			// 3. 파라미터 설정
			pstmt.setInt(1, customerId);
			// 4. 결과 확인
			rs = pstmt.executeQuery();

			if(rs.next()) {
				Integer storeId = rs.getInt(2);
				String firstName = rs.getString(3);
				String lastName = rs.getString(4);
				String email = rs.getString(5);
				Integer addressId = rs.getInt(6);
				Integer active = rs.getInt(7);
				Date createDate = rs.getDate(8);
				Date lastUpdate = rs.getDate(9);				

				customer = new Customer(customerId, storeId, firstName, lastName, email, addressId, active, createDate, lastUpdate);

			}
		} catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt, rs);
		}
		return customer;
	}

}
