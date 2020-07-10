<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">   
<title>항공기 도착정보</title>
<style type="text/css">
table,td,th{
	border: 2px solid grey;
	border-collapse : collapse;
	}
</style>
</head>
<body>
	<%
		String url = "http://openapi.airport.kr/openapi/service/StatusOfPassengerFlights/getPassengerArrivals?serviceKey=WTDMiC601etj7LYYVXJV6aTOgRN0wo7QxA%2Byr2NzVLKHfCwtgmCIbu9et%2BmOlDsvSpFW%2FJEYfkeSjcSZAxi0og%3D%3D";

		URL u = new URL(url);	//java.net 패키지의 클래스
		
		//URLConnection : 추상클래스
		//HttpURLConnection : URLConnection 클래스의 하위 클래스
		
		HttpURLConnection urlcon = (HttpURLConnection) u.openConnection();	//url에 접속객체 리턴
		//접속된 객체의 format 설정.
		urlcon.setRequestProperty("Accept", "application/xml");

		String line = "";
		String title = "";
		Document doc = null;
		
		//StringBuilder,StringBuffer : 동적 문자열   String class:정적 문자열
		
		StringBuilder sb = new StringBuilder();
		//urlcon.getInputStream(): 바이트형 입력스트림, url 로 부터 데이터 입력받음
		//InputStreamReader : InputStream 형태를 Reader 로 변환
		//						문자형 입력스트림 변경기 인코딩방식(UTF-8)
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "UTF-8"));
			int len = 0;
			char[] buf = new char[8096];
			while ((len = in.read(buf)) != -1) {
				sb.append(new String(buf, 0, len));
			}
			System.out.println(new String(sb.toString().getBytes(), "UTF-8"));
			doc = Jsoup.parse(sb.toString());	//xml 데이터 분석			Jsoup 는 문자열 파싱이 가능
			Elements items = doc.select("item");
			line = "<table><caption> 항공기 도착정보</caption>"
					+"<tr><th>항공사</th><th>출발공항</th>"
					+"<th>비행기코드</th><th>예정시간</th><th>변경시간</th><th>비고</th></tr>";
			System.out.println(items);
			for(Element src : items) {
				String airline = "&nbsp;";
				String airport = "&nbsp;";
				String flightid = "&nbsp;";
				String remark = "&nbsp;";
				String scheduleDateTime = "&nbsp;";
				String estimatedDateTime = "&nbsp;";
				try{airline= src.select("airline").get(0).text();}
				catch(IndexOutOfBoundsException e){}
				try{airport= src.select("airport").get(0).text();}
				catch(IndexOutOfBoundsException e){}
				try{flightid= src.select("flightid").get(0).text();}
				catch(IndexOutOfBoundsException e){}
				try{remark= src.select("remark").get(0).text();}
				catch(IndexOutOfBoundsException e){}
				try{scheduleDateTime= src.select("scheduleDateTime").get(0).text();}
				catch(IndexOutOfBoundsException e){}
				try{estimatedDateTime= src.select("estimatedDateTime").get(0).text();}
				catch(IndexOutOfBoundsException e){}
				line += "<tr><td>"+airline +"</td><td>"+airport +"</td><td>"+flightid +"</td><td>"
					+	scheduleDateTime +"</td><td>"+ estimatedDateTime +"</td><td>"+ remark + "</td></tr>";
			}
			
		} catch (IOException e) {
			e.printStackTrace();

		}
	%>
	<%=line %></table>
</body>
</html>