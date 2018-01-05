// package crux.mydiff;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class MyDiff {

	public static void main(String args[]) throws IOException {

		InputStream inputStream = new FileInputStream(new File(args[0]));
		InputStream inputStream2 = new FileInputStream(new File(args[1]));

		BufferedReader ins = new BufferedReader(new InputStreamReader(inputStream));
		BufferedReader ins2 = new BufferedReader(new InputStreamReader(inputStream2));

		String ln;

		ArrayList<String> actual = new ArrayList<String>();
		ArrayList<String> student = new ArrayList<String>();

		while ((ln = ins.readLine()) != null) {
			ln.trim();
			if (ln.compareTo("") != 0) {
				actual.add(ln);
//				System.out.println(ln);
			}
		}
//		System.out.println(actual.size());

		while ((ln = ins2.readLine()) != null) {
			ln.trim();
			if (ln.compareTo("") != 0) {
				student.add(ln);
//				System.out.println(ln);
			}
		}
//		System.out.println(student.size());
		
		if (actual.size()!=student.size()){
			System.out.println("Different.");
		}
		else {
			for (int i=0;i<actual.size();i++){
				if (actual.get(i).compareTo(student.get(i))!=0){
					System.out.println(actual.get(i));
					System.out.println(student.get(i));
					System.out.println("Different.");
					break;
				}
			}
		}

	}

}
