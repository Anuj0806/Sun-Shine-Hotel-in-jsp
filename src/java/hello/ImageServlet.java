package hello;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/imageServlet")
public class ImageServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jdbcUrl = "jdbc:mysql://localhost:3306/hotel_management";
        String dbUser = "root";
        String dbPassword = "";

        try {
             Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            int imageId = Integer.parseInt(request.getParameter("id"));
            String sql = "SELECT * FROM room WHERE room_no=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, imageId);
            ResultSet result = statement.executeQuery();

            if (result.next()) {
                response.setContentType("image/png"); // Set the content type as appropriate (e.g., image/jpeg)

                OutputStream oStream = response.getOutputStream();
                byte[] imageBytes = result.getBytes("photo");
                oStream.write(imageBytes);            
                oStream.flush();
                oStream.close();
             
            }
               String message = "Error to find the Image";
                request.setAttribute("error", message); // Set message which you display in ${error}
                request.getRequestDispatcher("getimage.jsp").forward(request, response);
            result.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ImageServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
           
    }
}
