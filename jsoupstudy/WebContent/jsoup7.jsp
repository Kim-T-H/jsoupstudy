<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.jsoup.Jsoup"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Json 데이터 처리하기</title>
<Style type="text/css">
	table,td,th {border:1px solid grey; border-collapse:collapse;}
</Style>
</head>
<body>

<%
//kebhana : json 데이터 저장
	String kebhana = Jsoup.connect("http://fx.kebhana.com/FER1101M.web").get().select("body").text(); 
	
	String strJson= kebhana.substring(kebhana.indexOf("{"));		//indexof 이후 로 다가져와
	System.out.println(strJson);
	JSONParser jsonParser = new JSONParser();	//JSON 번역기
	JSONObject json= (JSONObject)jsonParser.parse(strJson.trim());
	String html= "<table><caption>"+json.get("날짜").toString()+"</caption>"
			+"<tr><td rowspan='2'>통화명</td><td rowspan='2'>매매기준율</td>"
			+"<td colspan='2'>현찰</td><td colspan='2'>전신한 송금</td></tr>"
			+"<tr><td>파실 때</td><td>사실때</td><td>파실 때</td><td>사실 때</td></tr>";
		
JSONArray array = (JSONArray)json.get("리스트");
for(int i=0; i < array.size(); i++){
	JSONObject obj= (JSONObject)array.get(i);
	html+= "<tr><td>"+obj.get("통화명")+"</td>"
		+"<td>"+obj.get("매매기준율")+"</td>"
		+"<td>"+obj.get("현찰파실때")+"</td>"
		+"<td>"+obj.get("현찰사실때")+"</td>"
		+"<td>"+obj.get("송금_전신환보내실때")+"</td>"
		+"<td>"+obj.get("송금_전신환받으실때")+"</td></tr>";
}
	
html +="</table>";
%>

<%=html %>

</body>
</html>