package util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public static String parseDateToString(Date date){
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdFormat.format(date);
	} 
	
	public static Date parseStringToDate(String todate){
		try {
			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdFormat.parse(todate);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}
}
