<%@ page import="db.beans.*,java.sql.*,java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean" />
<jsp:setProperty name="QueryBean" property="*" />

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	request.setCharacterEncoding("UTF-8");
	
	String user_id = request.getParameter("user_id") == null ? "hkd" :  request.getParameter("user_id").trim();

	QueryBean.getConnection(); 

	ArrayList resArr = new ArrayList();

	try {
		resArr = QueryBean.getUserInfo(user_id); 

	} catch (SQLException e) {
		out.print(e.toString());
	} finally {
		QueryBean.closeConnection();
	}
	
	out.println("{");
	out.println("\"datas\":[");

	if (resArr.size() == 0) {
		out.println("]");
		out.println("}");
	}else {
		out.println("{ ");
		out.println("\"ID\": \""             + (String)resArr.get(0) + "\", ");
		out.println("\"NAME\": \""             + (String)resArr.get(1) + "\", ");
		out.println("\"PHONE\": \""             + (String)resArr.get(2) + "\", ");
		out.println("\"GRADE\": \""             + (String)resArr.get(3) + "\", ");
		out.println("\"WRITE_TIME\": \""             + (String)resArr.get(4) + "\" ");
		out.println("} ");
		
		for (int i = 5; i <resArr.size(); i+=5){
			out.println(",");
			out.println("{ ");
			out.println("     \"ID\": \""            + (String)resArr.get(i) + "\", ");
			out.println("     \"NAME\": \""             + (String)resArr.get(i+1) + "\", ");
			out.println("     \"PHONE\": \""             + (String)resArr.get(i+2) + "\", ");
			out.println("     \"GRADE\": \""             + (String)resArr.get(i+3) + "\", ");
			out.println("     \"WRITE_TIME\": \""             + (String)resArr.get(i+4) + "\" ");
			
			out.println("} ");
		}
		out.println("] ");
		out.println("} ");
	}
%>