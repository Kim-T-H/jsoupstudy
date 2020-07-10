<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>xml 데이터 처리하기: 공공데이터에서 데이터 수집</title>
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
			doc = Jsoup.parse(sb.toString());	//xml 데이터 분석			Jsoup 는 문자열 패싱이 가능
			Elements body = doc.select("item");
			for (Element src : body) {
				out.println(src.toString() + "<br>");
			}
		} catch (IOException e) {
			e.printStackTrace();

		}
	%>

</body>
</html>