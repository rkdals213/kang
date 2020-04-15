package day03.homework;

import java.util.List;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("전체 검색");
		selectAll();
		System.out.println("코드로 검색");
		selectByCode("10001");
		System.out.println("수정 후 조회");
		update(new Product("10001", "테스트", 3000));
		selectAll();
		System.out.println("삭제 후 조회");
		delete("10001");
		selectAll();
	}
	
	 static public void delete(String pattern) {
		 ProductDAO dao = ProductDAO.getDao();
			try {
				dao.delete(pattern);
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	static public void update(Product prod) {
		ProductDAO dao = ProductDAO.getDao();
		try {
			dao.update(prod);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	static public void selectByCode(String pattern) {
		ProductDAO dao = ProductDAO.getDao();
		try {
			List<Product> list = dao.selectBy(pattern);
			for (Product prod : list) {
				System.out.println(prod);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	static public void selectAll() {
		ProductDAO dao = ProductDAO.getDao();
		try {
			List<Product> list = dao.selectAll();
			for (Product prod : list) {
				System.out.println(prod);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
