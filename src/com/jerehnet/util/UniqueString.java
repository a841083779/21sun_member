package com.jerehnet.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class UniqueString {

	private final static int _SIZE = 500;
	
	
	 /** 
     * 生成唯一字符串  
     * 作者:解镭 Email:xielei@live.com  
     * 创建日期：May 14, 2008  
     * 创建时间: 5:07:39 PM 
     * @param length 需要长度 
     * @param symbol 是否允许出现特殊字符 -- !@#$%^&*() 
     * @return 
     */  
    public static String getUniqueString(int length, boolean symbol)  
            throws Exception {  
        Random ran = new Random();  
        int num = ran.nextInt(61);  
        String returnString = "";  
        String str = "";  
        for (int i = 0; i < length;) {  
            if (symbol)  
                num = ran.nextInt(70);  
            else  
                num = ran.nextInt(61);  
            str = strArray[num];  
            if (!(returnString.indexOf(str) >= 0)) {  
                returnString += str;  
                i++;  
            }  
        }  
        return returnString;  
    }  
  
    /** 
     * 生成唯一字符串 会已时间 加上你需要数量的随机字母  
     * 如:getUniqueString(6,true,"yyyyMMddHHmmss") 
     * 返回:20080512191554juHkn4  
     * 作者:解镭 Email:xielei@live.com  
     * 创建日期：May 14, 2008 
     * 创建时间: 5:07:39 PM 
     * @param length 需要长度 
     * @param symbol 是否允许出现特殊字符 -- !@#$%^&*() 
     * @param dateformat 时间格式字符串 
     * @return  
     */  
    public static String getUniqueString(int length, boolean symbol,  
            String dateformat) throws Exception {  
        Random ran = new Random();  
        int num = ran.nextInt(61);  
        Calendar d = Calendar.getInstance();  
        Date nowTime = d.getTime();  
        SimpleDateFormat sf = new SimpleDateFormat(dateformat);  
        String returnString = sf.format(nowTime);  
        String str = "";  
        for (int i = 0; i < length;) {  
            if (symbol)  
                num = ran.nextInt(70);  
            else  
                num = ran.nextInt(61);  
            str = strArray[num];  
            if (!(returnString.indexOf(str) >= 0)) {  
                returnString += str;  
                i++;  
            }  
        }  
        return returnString;  
    }  
    
    public static String getUniqueString(int count,int flag){
    	String uniqueStr="";
    	try{
    		if(flag==1){
    			uniqueStr = getUniqueString(count,false,"yyMMdd").toUpperCase();
    		}else{
    			uniqueStr = getUniqueString(count,false).toUpperCase();
    		}    	
    	}catch(Exception e){
    		Common.println(e);
    	}
    	return uniqueStr;
    }
  
    /** 
     * 给生成唯一字符串使用 
     */  
    private static String[] strArray = new String[] { "a", "b", "c", "d", "e",  
            "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",  
            "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E",  
            "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",  
            "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4",  
            "5", "6", "7", "8", "9", "!", "@", "#", "$", "%", "^", "&", "(",  
            ")" }; 

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		try{
			for(int i=0;i<100;i++){
//		System.out.println(getUniqueString(20,false).toUpperCase());
		//System.out.println(getUniqueString(16,false,"yyMMdd").toUpperCase());
			}
		}catch(Exception e){
			e.printStackTrace();
		}

	}



}
