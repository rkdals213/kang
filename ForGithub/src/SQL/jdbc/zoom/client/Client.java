package jdbc.zoom.client;

import java.sql.Connection;
import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import jdbc.zoom.model.dao.CustomerDAO;
import jdbc.zoom.model.dto.Customer;
import jdbc.zoom.util.DBUtil;

public class Client {
	public static void main(String[] args) {
//		ConnectionTest();
//		selectTest();
//		selectAllTest();
//		selectByNameLike("ED");
//		insertTest();
//		selectTest();
		updateTest();
		selectTest();
	}
	
	private static void updateTest() {
		CustomerDAO dao = CustomerDAO.getDao();
		try {
			Date cDate = new Date(Calendar.getInstance().getTimeInMillis());
			Customer customer = new Customer(9999, 1, "꺽정", "임", "abc@def.net", 5, 1, cDate, null);
			int result = dao.update(customer);
			System.out.println(result + "개의 데이터가 영향을 받음");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static void insertTest() {
		CustomerDAO dao = CustomerDAO.getDao();
		try {
			Date cDate = new Date(Calendar.getInstance().getTimeInMillis());
			Customer customer = new Customer(9999, 1, "길동", "고", "abc@def.net", 5, 1, cDate, null);
			int result = dao.insert(customer);
			System.out.println(result + "개의 데이터가 영향을 받음");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static void selectByNameLike(String pattern) {
		CustomerDAO dao = CustomerDAO.getDao();
		try {
			List<Customer> list = dao.selectbyNameLike(pattern);
			for (Customer customer : list) {
				System.out.println(customer);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static void selectAllTest() {
		CustomerDAO dao = CustomerDAO.getDao();
		try {
			List<Customer> list = dao.selectAll();
			for (Customer customer : list) {
				System.out.println(customer);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static void selectTest() {
		CustomerDAO dao = CustomerDAO.getDao();
		Customer cust;
		try {
			cust = dao.selectById(9999);
			System.out.println(cust);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	private static void ConnectionTest() {
		DBUtil util = DBUtil.getUtil();
		try {
			// connection 얻기
			Connection con = util.getConnection();
			// 사용
			System.out.println(con);
			// 반납
			util.close(con);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
