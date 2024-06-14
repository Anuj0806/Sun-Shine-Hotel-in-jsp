<%@page import="java.sql.Statement"%>
<%@page import="org.json.JSONObject"%>
<%@ include file="../config.jsp" %>
<%
    if (session.getAttribute("employee") == null && session.getAttribute("admin_email") == null) {
        response.sendRedirect("employeelogin.html");
    }
    String mail = request.getParameter("mail");
    JSONObject jsonResponse = new JSONObject();
        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, user, password1);
            Statement stm1;
            stm1 = conn.createStatement();
            ResultSet rs;
            String sql = "select * from guest where email='" + mail + "'";
            rs = stm1.executeQuery(sql);
            if (rs.next()) {
                String name = rs.getString("Name");
                String address = rs.getString("address");
                jsonResponse.put("name", name);
                jsonResponse.put("address", address);
            }else{
                 jsonResponse.put("found", "");
            }
        } catch (Exception e) {
            jsonResponse.put("error", e);
        }


    response.setContentType("application/json");
    response.getWriter().write(jsonResponse.toString());
%>

