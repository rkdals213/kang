package algorithm_study;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class BAEK_17136_G3_색종이붙이기 {
	static int [] papersize = {1,2,3,4,5};
	static int count = Integer.MAX_VALUE;
	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StringTokenizer temp;
		int [] paper = {5,5,5,5,5}; // 색종이의 종류별 갯수를 저장하는 배열
		int [][] map = new int [10][10]; 

		for (int i = 0; i < 10; i++) {
			temp = new StringTokenizer(br.readLine());
			for (int j = 0; j < 10; j++) {
				map[i][j] = Integer.parseInt(temp.nextToken());
			}
		}
		DFS(paper, map, 0, 0);
		if(count == Integer.MAX_VALUE) {
			System.out.println(-1);
		}else {
			System.out.println(count);
		}
		

	}

	static void DFS(int [] paper, int map [][], int c, int x) {	
		/* 현재 색종이의 갯수, map, 색종이를 붙인 횟수,
		 x 시작 좌표(연산을 빠르게 하기 위함 : 위쪽 왼족부터 오른쪽으로 탐색을 진행하므로 색종이를 붙인 위치의 이전 위치들은 탐색할 필요가 없음)*/
		if(c > count)return;
		boolean flag = false;
		outer : for (int i = 0; i < 10; i++) {
			for (int j = 0; j < 10; j++) {
				if(map[i][j] == 1) {
					flag = true;
					break outer;
				}
			}		
		}
		if(!flag) {
			count = Math.min(count, c);
			return;
		}
		for (int i = x; i < 10; i++) {
			for (int j = 0; j < 10; j++) {
				if(map[i][j] == 1) {
					for (int k = 4; k >= 0; k--) {
						if(paperOK(i,j,map,papersize[k])) {
							if(paper[k]-1 >= 0) {
								map = change(i, j, map, papersize[k], 0);
								paper[k]--;
								DFS(paper, map, c+1, i);
								map = change(i, j, map, papersize[k], 1);
								paper[k]++;
							}						
						}
					}	
					return;
				}
			}
		}
	}
	
	static int [][] change(int x, int y, int [][] map, int size, int c){
		for (int i = x; i < x+size; i++) {
			for (int j = y; j < y+size; j++) {
				map[i][j] = c;
			}
		}
		return map;
	}
	
	static boolean paperOK(int x, int y, int [][] map, int size) {
		if(isIn(x+size-1, y+size-1)) {
			for (int i = x; i < x+size; i++) {
				for (int j = y; j < y+size; j++) {
					if(map[i][j] == 0) {
						return false;
					}
				}
			}
		}else {
			return false;
		}
		return true;
	}

	static boolean isIn(int x, int y) {
		return x < 10 && y < 10;
	}
}
