package day03.edu.ssafy.cus;

import java.util.List;

public class CustomerTest {
	public static void main(String[] args) {
		DAO dao = new CustomerDAO();
//		dao.insertCustomer(10, "둘리", "쌍문동");
//		dao.insertCustomer(11, "마이콜", "쌍문동");
//		dao.insertCustomer(12, "도우너", "쌍문동");
//		dao.insertCustomer(13, "또치", "쌍문동");
		
		List<Customer> list = dao.allViewCustomer();
		for (Customer customer : list) {
			System.out.println(customer);
		}
	}
}
