<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@page import="java.io.*"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
   String url = "jdbc:mysql://localhost:3306/student?serverTimezone=Asia/Seoul&useSSL=false";
   String user = "root";
   String password = "0729";
   String sql = null;
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
   try{
      Class.forName("org.gjt.mm.mysql.Driver");
      System.out.println("드라이버 로딩 성공");
      conn = DriverManager.getConnection(url,user,password);
      System.out.println("접속 성공");
      sql = "SELECT * FROM STUDENT";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      
      JSONObject jsonMain = new JSONObject();
      JSONArray jArray = new JSONArray();
      
      int count = 0;
      while(rs.next())
      {
    	JSONObject jsonObject = new JSONObject();
    	 
		jsonObject.put("Grade",rs.getString("Grade"));
		jsonObject.put("Cclass",rs.getString("Cclass"));
		jsonObject.put("No",rs.getString("No"));
		jsonObject.put("Name",rs.getString("Name"));
		jsonObject.put("Score",rs.getString("Score"));
		
		jArray.add(count, jsonObject);
		count++;
      }
      jsonMain.put("Student",jArray);
      out.clear();
      out.println(jsonMain);
      out.flush();
      
      }catch(Exception e){
         System.out.println("접속실패");
         e.printStackTrace();
      }finally{
    	  try{
    	  if(rs!=null)rs.close();
    	  if(pstmt!=null)pstmt.close();
    	  if(conn!=null)conn.close();
    	  }catch(Exception ex){
    		  ex.getStackTrace();
    	  }
      }
%>