<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page isELIgnored="true" %>

<%
String n=request.getParameter("val");

if(n.length()>0){
try{
Class.forName("com.mysql.cj.jdbc.Driver");
 Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/payment","root","Anuj0806$");

PreparedStatement ps=con.prepareStatement("select * from student2 where name like '%"+n+"%'");
//ps.setString(1,n);
out.print("<br>");
ResultSet rs=ps.executeQuery();

out.print("<table border='5' cellspacing=5 cellpadding=2 width='100%' id='myTable'>");
out.print("<tr><td><B>ID</B></td><td><B>Name</B></td><td><B>Course</B></td><td><B>Mobile</B></td><td><B>Date Of Submission</B></td><td><B>Paid</B></td><td><B>Fee</B></td><td><B>Balance</B></td><td><B>Address</B></td><td><B>F. Name</B></td><td><B>M, Name</B></td><td><B>D.O.B</B></td><td><B>Qualification</B></td><td><B>Date Of Joining</B></td><td><B>Description</B></td><td><B>Trainer</B></td></tr>");
while(rs.next()){
String id=rs.getString(1);
out.print("<td>"+rs.getString(1)+"</td>");
out.print("<td>"+rs.getString(2)+"</td>");
out.print("<td>"+rs.getString(3)+"</td>");
out.print("<td>"+rs.getString(4)+"</td>");
out.print("<td>"+rs.getString(5)+"</td>");
out.print("<td>"+rs.getString(6)+"</td>");
out.print("<td>"+rs.getString(7)+"</td>");
out.print("<td>"+rs.getString(8)+"</td>");
out.print("<td>"+rs.getString(9)+"</td>");
out.print("<td>"+rs.getString(10)+"</td>");
out.print("<td>"+rs.getString(11)+"</td>");
out.print("<td>"+rs.getString(12)+"</td>");
out.print("<td>"+rs.getString(13)+"</td>");
out.print("<td>"+rs.getString(14)+"</td>");
out.print("<td>"+rs.getString(15)+"</td>");
out.print("<td>"+rs.getString(16)+"</td>");
out.print("<td><a  href=removestu.jsp?email="+id+">Delete Data</a></td>");
out.print("</tr>");
}
out.print("</table>");
con.close();
}catch(Exception e){e.printStackTrace();}
}//end of if
%>
