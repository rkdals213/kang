package day03.homework;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
	DBUtil util = DBUtil.getUtil();
	// 기능만 -- singletone
	private static ProductDAO dao = new ProductDAO();

	public static ProductDAO getDao() {
		return dao;
	}

	private ProductDAO() {}

	public int insert(Product prod) throws Exception {
		int result = 0;
		StringBuilder sb = new StringBuilder("insert into product ");
		sb.append("(product_code, product_name, product_price)")
		.append(" values(?,?,?)");
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, prod.getProductCode());
			pstmt.setString(2, prod.getProductName());
			pstmt.setInt(3, prod.getProductPrice());		
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt);
		}
		return result;
	}

	public List<Product> selectAll() throws Exception {
		List<Product> list = new ArrayList<>();
		StringBuilder sb = new StringBuilder("select * from product");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String code = rs.getString(1);
				String name = rs.getString(2);
				int price = rs.getInt(3);
				list.add(new Product(code, name, price));
			}
			
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt, rs);
		}
		return list;		
	}

	public List<Product> selectBy(String pattern) throws Exception{
		List<Product> list = new ArrayList<>();
		StringBuilder sb = new StringBuilder("select * from product where product_code=?");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, pattern);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String code = rs.getString(1);
				String name = rs.getString(2);
				int price = rs.getInt(3);
				list.add(new Product(code, name, price));
			}
			
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt, rs);
		}
		return list;	
	}
	
	public int update(Product prod) throws Exception {
		int result = 0;
		StringBuilder sb = new StringBuilder("update product");
		sb.append(" set product_name=?, product_price=?").append(" where product_code=?");
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, prod.getProductName());
			pstmt.setInt(2, prod.getProductPrice());
			pstmt.setString(3, prod.getProductCode());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt);
		}
		return result;
	}
	
	public int delete(String pattern) throws Exception {
		int result = 0;
		StringBuilder sb = new StringBuilder("delete from product where product_code=?");
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = util.getConnection();
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, pattern);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace(); // 로깅용 catch
			throw e;
		} finally {
			util.close(con, pstmt);
		}
		return result;
	}
}
