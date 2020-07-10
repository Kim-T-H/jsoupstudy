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
<title>�װ��� ��������</title>
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

		URL u = new URL(url);	//java.net ��Ű���� Ŭ����
		
		//URLConnection : �߻�Ŭ����
		//HttpURLConnection : URLConnection Ŭ������ ���� Ŭ����
		
		HttpURLConnection urlcon = (HttpURLConnection) u.openConnection();	//url�� ���Ӱ�ü ����
		//���ӵ� ��ü�� format ����.
		urlcon.setRequestProperty("Accept", "application/xml");

		String line = "";
		String title = "";
		Document doc = null;
		
		//StringBuilder,StringBuffer : ���� ���ڿ�   String class:���� ���ڿ�
		
		StringBuilder sb = new StringBuilder();
		//urlcon.getInputStream(): ����Ʈ�� �Է½�Ʈ��, url �� ���� ������ �Է¹���
		//InputStreamReader : InputStream ���¸� Reader �� ��ȯ
		//						������ �Է½�Ʈ�� ����� ���ڵ����(UTF-8)
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(urlcon.getInputStream(), "UTF-8"));
			int len = 0;
			char[] buf = new char[8096];
			while ((len = in.read(buf)) != -1) {
				sb.append(new String(buf, 0, len));
			}
			System.out.println(new String(sb.toString().getBytes(), "UTF-8"));
			doc = Jsoup.parse(sb.toString());	//xml ������ �м�			Jsoup �� ���ڿ� �Ľ��� ����
			Elements items = doc.select("item");
			line = "<table><caption> �װ��� ��������</caption>"
					+"<tr><th>�װ���</th><th>��߰���</th>"
					+"<th>������ڵ�</th><th>�����ð�</th><th>����ð�</th><th>���</th></tr>";
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