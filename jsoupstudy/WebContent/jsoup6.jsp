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
<title>Json ������ ó���ϱ�</title>
</head>
<body>

<%
//kebhana : json ������ ����
	String kebhana = Jsoup.connect("http://fx.kebhana.com/FER1101M.web").get().select("body").text();
	String strJson=kebhana.replaceAll("}, ] }","} ]");
	strJson= strJson.substring(strJson.indexOf("["));		//indexof ���� �� �ٰ�����
	System.out.println(strJson);
	JSONParser jsonParser = new JSONParser();	//JSON ������
	JSONArray array = (JSONArray)jsonParser.parse(strJson);	//Json ��ü ����
	float usd = 0f;
	float jpy = 0f;
	
	for(int i=0; i<array.size(); i++){
		JSONObject obj =(JSONObject)array.get(i);	//array�� ��� 1�� ����    //JSONObject: json ������ ��ü.{"Ű": "value",....}
		if(obj.get("��ȭ��").toString().equals("�̱� USD")){	//obj.get("��ȭ��"): json ������ key ������ value ����
			usd= Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("�̱�USD:"+usd+"<br>");		//out �� jsp�� ���� ��ü
		}
		else if(obj.get("��ȭ��").toString().equals("�Ϻ� JPY 100")){
			jpy= Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("�Ϻ� JPY 100:" +jpy+ "<br>");
		}
		else if(obj.get("��ȭ��").toString().equals("���� EUR")){
			usd =Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("���� EUR:"+usd+"<br>");	
		}else if(obj.get("��ȭ��").toString().equals("�߱� CNY")){
			usd =Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("�߱� CNY:"+usd+"<br>");
		}
	}
%>
<table width="50%" border="1" style="border-collapse:collapse; border:1px gray solid;">
	<tr><td rowspan="2">��ȭ��</td><td rowspan="2">�Ÿű�����</td>
	<td colspan="2">����</td><td colspan="2">������ �۱�</td></tr>
	<tr><td>�Ľ� ��</td><td>��Ƕ�</td><td>�Ľ� ��</td><td>��� ��</td></tr>
	<tr><td>   </td><td>   </td><td>   </td><td>   </td></tr>
		
</table>

</body>
</html>