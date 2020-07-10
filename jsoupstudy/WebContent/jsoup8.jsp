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
<title>xml ������ ó���ϱ�: ���������Ϳ��� ������ ����</title>
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
			doc = Jsoup.parse(sb.toString());	//xml ������ �м�			Jsoup �� ���ڿ� �н��� ����
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