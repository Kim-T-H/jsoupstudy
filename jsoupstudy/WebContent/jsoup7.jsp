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
<title>Json ������ ó���ϱ�</title>
<Style type="text/css">
	table,td,th {border:1px solid grey; border-collapse:collapse;}
</Style>
</head>
<body>

<%
//kebhana : json ������ ����
	String kebhana = Jsoup.connect("http://fx.kebhana.com/FER1101M.web").get().select("body").text(); 
	
	String strJson= kebhana.substring(kebhana.indexOf("{"));		//indexof ���� �� �ٰ�����
	System.out.println(strJson);
	JSONParser jsonParser = new JSONParser();	//JSON ������
	JSONObject json= (JSONObject)jsonParser.parse(strJson.trim());
	String html= "<table><caption>"+json.get("��¥").toString()+"</caption>"
			+"<tr><td rowspan='2'>��ȭ��</td><td rowspan='2'>�Ÿű�����</td>"
			+"<td colspan='2'>����</td><td colspan='2'>������ �۱�</td></tr>"
			+"<tr><td>�Ľ� ��</td><td>��Ƕ�</td><td>�Ľ� ��</td><td>��� ��</td></tr>";
		
JSONArray array = (JSONArray)json.get("����Ʈ");
for(int i=0; i < array.size(); i++){
	JSONObject obj= (JSONObject)array.get(i);
	html+= "<tr><td>"+obj.get("��ȭ��")+"</td>"
		+"<td>"+obj.get("�Ÿű�����")+"</td>"
		+"<td>"+obj.get("�����ĽǶ�")+"</td>"
		+"<td>"+obj.get("������Ƕ�")+"</td>"
		+"<td>"+obj.get("�۱�_����ȯ�����Ƕ�")+"</td>"
		+"<td>"+obj.get("�۱�_����ȯ�����Ƕ�")+"</td></tr>";
}
	
html +="</table>";
%>

<%=html %>

</body>
</html>