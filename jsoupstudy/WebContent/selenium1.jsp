<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="org.openqa.selenium.chrome.ChromeDriver" %>
<%@page import="org.openqa.selenium.WebDriver" %>
<%-- /WebContent/selenium1.jsp --%>

<%
WebDriver driver=null;
final String WEB_DRIVER_ID = "webdriver.chrome.driver";
final String WEB_DRIVER_PATH ="C:/Users/GDJ24/Downloads/chromedriver_win32/chromedriver.exe";
String base_url=null;
System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
driver = new ChromeDriver();
base_url="https://www.naver.com";
try{
	driver.get(base_url);
	System.out.println(driver.getPageSource());
	out.println(driver.getPageSource());
	Thread.sleep(5000);
}catch(Exception e){
	e.printStackTrace();
}finally{
	driver.close();	//driver 가 제어중인 브라우저 닫기
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>