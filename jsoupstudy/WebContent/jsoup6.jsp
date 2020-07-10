<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Json 데이터 처리하기</title>
</head>
<body>

<%
//kebhana : json 데이터 저장
	String kebhana = Jsoup.connect("http://fx.kebhana.com/FER1101M.web").get().select("body").text();
	String strJson=kebhana.replaceAll("}, ] }","} ]");
	strJson= strJson.substring(strJson.indexOf("["));		//indexof 이후 로 다가져와
	System.out.println(strJson);
	JSONParser jsonParser = new JSONParser();	//JSON 번역기
	JSONArray array = (JSONArray)jsonParser.parse(strJson);	//Json 객체 변경
	float usd = 0f;
	float jpy = 0f;
	
	for(int i=0; i<array.size(); i++){
		JSONObject obj =(JSONObject)array.get(i);	//array의 요소 1개 리턴    //JSONObject: json 형태의 객체.{"키": "value",....}
		if(obj.get("통화명").toString().equals("미국 USD")){	//obj.get("통화명"): json 형태의 key 값으로 value 리턴
			usd= Float.parseFloat(obj.get("매매기준율").toString());
			out.println("미국USD:"+usd+"<br>");		//out 이 jsp의 내장 객체
		}
		else if(obj.get("통화명").toString().equals("일본 JPY 100")){
			jpy= Float.parseFloat(obj.get("매매기준율").toString());
			out.println("일본 JPY 100:" +jpy+ "<br>");
		}
		else if(obj.get("통화명").toString().equals("유로 EUR")){
			usd =Float.parseFloat(obj.get("매매기준율").toString());
			out.println("유로 EUR:"+usd+"<br>");	
		}else if(obj.get("통화명").toString().equals("중국 CNY")){
			usd =Float.parseFloat(obj.get("매매기준율").toString());
			out.println("중국 CNY:"+usd+"<br>");
		}
	}
%>
<table width="50%" border="1" style="border-collapse:collapse; border:1px gray solid;">
	<tr><td rowspan="2">통화명</td><td rowspan="2">매매기준율</td>
	<td colspan="2">현찰</td><td colspan="2">전신한 송금</td></tr>
	<tr><td>파실 때</td><td>사실때</td><td>파실 때</td><td>사실 때</td></tr>
	<tr><td>   </td><td>   </td><td>   </td><td>   </td></tr>
		
</table>

</body>
</html>