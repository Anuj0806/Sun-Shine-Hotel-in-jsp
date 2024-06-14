<%@page import="com.itextpdf.text.Font"%>
<%@page import="com.itextpdf.text.BaseColor"%>
<%@page import="com.itextpdf.text.Phrase"%>
<%@page import="com.itextpdf.text.pdf.PdfPCell"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.Chunk"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="com.google.zxing.client.j2se.MatrixToImageWriter"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.itextpdf.text.Document" %>
<%@ page import="com.itextpdf.text.Paragraph" %>
<%@ page import="com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.WriterException" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@include file="config.jsp" %>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Food Order Receipt</title>
        <link rel="icon" href="./image/hotel-sign.png">
    </head>
    <body>
        <%
            if (session.getAttribute("employee") == null && session.getAttribute("admin_email") == null) {
                response.sendRedirect("employeelogin.html");
            }
        %>
        <%
            String filePath = "";
            int orderId = 0;

            int orderId_confirm = 0;         
            if (request.getParameter("orderIdEmp") != null) {
                orderId_confirm = Integer.parseInt(decryptData(request.getParameter("orderIdEmp"), secretKey));               
            }
            if (request.getParameter("orderId") != null) {
                orderId = Integer.parseInt(decryptData(request.getParameter("orderId"), secretKey));
            }
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement itemsPstmt = null;
            PreparedStatement updatePstmt = null;
            ResultSet rs = null;
            ResultSet rsItems = null;
            ResultSet rsItemsTotal = null;
            if (request.getParameter("orderIdEmp") != null) {

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password1);
                    String sql = "SELECT o.*, g.name AS guest_name, DATE(order_date) AS order_date, TIME(order_date) AS order_time FROM orders o JOIN guest g ON o.guest_id = g.guest_id WHERE o.order_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, orderId_confirm);
                    rs = pstmt.executeQuery();

                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    Document document = new Document();
                    PdfWriter.getInstance(document, baos);

                    document.open();

                    // Create a font object for Times New Roman
                    Font timesNewRomanFont = new Font(Font.FontFamily.TIMES_ROMAN, 12);
                    Font time_new_roman_bold = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
                    // Add the hotel logo
                    ServletContext context = getServletContext();
                    String imagePath = context.getRealPath("/image/hotel-sign.png");
                    Image logo = Image.getInstance(imagePath);
                    logo.setAlignment(Image.ALIGN_CENTER);
                    logo.scaleAbsolute(50, 50);

                    // Add the hotel name and invoice title
                    Paragraph hotelName = new Paragraph("Sun Shine Hotel", time_new_roman_bold);
                    hotelName.setAlignment(Element.ALIGN_CENTER);
                    Paragraph invoiceTitle = new Paragraph("Food Recipt", time_new_roman_bold);
                    invoiceTitle.setAlignment(Element.ALIGN_CENTER);

                    // Create a box to hold the logo, hotel name, and invoice title
                    PdfPTable box1 = new PdfPTable(1);
                    box1.setWidthPercentage(100); // Set table width to 100%
                    box1.setSpacingBefore(10); // Add space before the table
                    PdfPCell cell1 = new PdfPCell();
                    cell1.setBackgroundColor(new BaseColor(209, 245, 251));
                    cell1.setBorderWidth(1);
                    cell1.setPadding(10);

                    // Add the logo, hotel name, and invoice title to the box
                    cell1.addElement(logo);
                    cell1.addElement(hotelName);
                    cell1.addElement(invoiceTitle);
                    box1.addCell(cell1);
                    document.add(box1);

                    PdfPTable box = new PdfPTable(2);
                    box.setWidthPercentage(100);

// Set the width of the columns
                    float[] columnWidths = {86, 18};
                    box.setWidths(columnWidths);

// Create the cells for the invoice details
                    PdfPCell cell = new PdfPCell();
                    cell.setBackgroundColor(new BaseColor(242, 242, 242));
                    cell.setBorderWidth(1);
                    cell.setPadding(10);

// Add the invoice details
                    Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
                    Font regularFont = timesNewRomanFont;

                    Paragraph InvoiceParagraph = new Paragraph("", regularFont);
                    InvoiceParagraph.add(new Chunk("SUN SHINE HOTEL ", boldFont));

                    Paragraph customerNameParagraph = new Paragraph("", regularFont);
                    customerNameParagraph.add(new Chunk("2000, BULL PARK AVE", boldFont));

                    Paragraph addressParagraph = new Paragraph("", regularFont);
                    addressParagraph.add(new Chunk("NEW HILLS, NC, 27154-8908", boldFont));

                    Paragraph paymentModeParagraph = new Paragraph("", regularFont);
                    paymentModeParagraph.add(new Chunk("919-888-8888", boldFont));

                    // Add the invoice details to the first column
                    cell.addElement(InvoiceParagraph);
                    cell.addElement(customerNameParagraph);
                    cell.addElement(addressParagraph);
                    cell.addElement(paymentModeParagraph);

                    box.addCell(cell);

                    // Create QR code
                    String qrCodeText = "http://192.168.1.41:8080/Sun_Shine_Hotel/download_recipt.jsp?orderId=" + encryptData(String.valueOf(orderId_confirm), secretKey);
                    QRCodeWriter qrCodeWriter = new QRCodeWriter();
                    BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeText, BarcodeFormat.QR_CODE, 200, 200);
                    ByteArrayOutputStream qrCodeOutputStream = new ByteArrayOutputStream();
                    MatrixToImageWriter.writeToStream(bitMatrix, "png", qrCodeOutputStream);

                    // Add QR Code to PDF
                    Image qrCodeImage = Image.getInstance(qrCodeOutputStream.toByteArray());
                    qrCodeImage.scaleToFit(89, 180);

                    // Create a new paragraph for the QR code
                    Chunk qrCodeChunk = new Chunk(qrCodeImage, -9, -80);
                    Paragraph paragraphqr = new Paragraph();
                    paragraphqr.add(qrCodeChunk);
                    paragraphqr.setAlignment(Element.ALIGN_RIGHT);
                    // Add the QR code to the second column
                    PdfPCell qrCodeCell = new PdfPCell(paragraphqr);
                    qrCodeCell.setBackgroundColor(new BaseColor(242, 242, 242));
                    qrCodeCell.setBorderWidth(1);
                    qrCodeCell.setPadding(10);
                    qrCodeCell.setRowspan(4);
                    box.addCell(qrCodeCell);
                    document.add(box);

                    // Create a box to hold the logo, hotel name, and invoice title
                    PdfPTable box2 = new PdfPTable(1);
                    box2.setWidthPercentage(100); // Set table width to 100%
                    box2.setSpacingBefore(10); // Add space before the table
                    PdfPCell third = new PdfPCell();
                    third.setBackgroundColor(new BaseColor(242, 242, 242));
                    third.setBorderWidth(1);
                    third.setPadding(10);

                    String guestName = "";
                    Date order_date = null;
                    Time order_time = null;
                    if (rs.next()) {
                        guestName = rs.getString("guest_name");
                        order_date = rs.getDate("order_date");
                        order_time = rs.getTime("order_time");
                    }// Add the invoice details                

                    Paragraph guestthird = new Paragraph("", regularFont);
                    guestthird.add(new Chunk("Guest Name: ", boldFont));
                    guestthird.add(new Chunk(guestName, regularFont));

                    Paragraph orderidthird = new Paragraph("", regularFont);
                    orderidthird.add(new Chunk("Order-ID: ", boldFont));
                    orderidthird.add(new Chunk(String.valueOf(orderId_confirm), regularFont));

                    Paragraph hostthird = new Paragraph("", regularFont);
                    hostthird.add(new Chunk("Hotel Name: ", boldFont));
                    hostthird.add(new Chunk("SUN SHINE HOTEL", regularFont));

                    Paragraph Datethird = new Paragraph("", regularFont);
                    Datethird.add(new Chunk("Date: ", boldFont));
                    Datethird.add(new Chunk(String.valueOf(order_date), regularFont));

                    Paragraph Timethird = new Paragraph("", regularFont);
                    Timethird.add(new Chunk("Time: ", boldFont));
                    Timethird.add(new Chunk(String.valueOf(order_time), regularFont));

                    // Add the invoice details to the first column
                    third.addElement(guestthird);
                    third.addElement(orderidthird);
                    third.addElement(hostthird);
                    third.addElement(Datethird);
                    third.addElement(Timethird);
                    box2.addCell(third);
                    document.add(box2);

                    // Add the room details table
                    PdfPTable table = new PdfPTable(4);
                    table.setWidthPercentage(100); // Set table width to 100%
                    table.setSpacingBefore(10); // Add space before the table

// Set padding for header cells
//        Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.BOLD);
                    PdfPCell headerCell = new PdfPCell();
                    headerCell.setPadding(5); // Set padding to 5 points
                    headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
                    headerCell.setBorderWidth(0.5f); // Set border width

                    headerCell.addElement(new Phrase("Item ID", boldFont));
                    table.addCell(headerCell);

                    headerCell = new PdfPCell();
                    headerCell.setPadding(5); // Set padding to 5 points
                    headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
                    headerCell.setBorderWidth(0.5f); // Set border width
                    headerCell.addElement(new Phrase("Item Name", boldFont));
                    table.addCell(headerCell);

                    headerCell = new PdfPCell();
                    headerCell.setPadding(5); // Set padding to 5 points
                    headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
                    headerCell.setBorderWidth(0.5f); // Set border width
                    headerCell.addElement(new Phrase("Quantity", boldFont));
                    table.addCell(headerCell);

                    headerCell = new PdfPCell();
                    headerCell.setPadding(5); // Set padding to 5 points
                    headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
                    headerCell.setBorderWidth(0.5f); // Set border width
                    headerCell.addElement(new Phrase("Price", boldFont));
                    table.addCell(headerCell);

                    String itemsSql = "SELECT oi.item_id, m.item_name, oi.quantity, (oi.quantity * m.price) AS price FROM order_items oi JOIN menu m ON oi.item_id = m.item_id WHERE oi.order_id = ?";
                    itemsPstmt = conn.prepareStatement(itemsSql);
                    itemsPstmt.setInt(1, orderId_confirm);
                    rsItems = itemsPstmt.executeQuery();
                    while (rsItems.next()) {
                        int itemId = rsItems.getInt("item_id");
                        String itemName = rsItems.getString("item_name");
                        int quantity = rsItems.getInt("quantity");
                        double price = rsItems.getDouble("price");

                        // Set padding for data cells
                        PdfPCell dataCell = new PdfPCell();
                        dataCell.setPadding(5); // Set padding to 5 points
                        dataCell.addElement(new Phrase(String.valueOf(itemId), timesNewRomanFont));
                        table.addCell(dataCell);

                        dataCell = new PdfPCell();
                        dataCell.setPadding(5); // Set padding to 5 points
                        dataCell.addElement(new Phrase(itemName, timesNewRomanFont));
                        table.addCell(dataCell);

                        dataCell = new PdfPCell();
                        dataCell.setPadding(5); // Set padding to 5 points
                        dataCell.addElement(new Phrase(String.valueOf(quantity), timesNewRomanFont));
                        table.addCell(dataCell);

                        dataCell = new PdfPCell();
                        dataCell.setPadding(5); // Set padding to 5 points
                        dataCell.addElement(new Phrase(String.valueOf(price), timesNewRomanFont));
                        table.addCell(dataCell);
                    }

                    table.setSpacingBefore(10);
                    document.add(table);

                    // Fetch and display food items
                    // Calculate and display subtotal, tax, and total
                    String itemsSqlTotal = "SELECT SUM(oi.quantity * m.price) AS total FROM order_items oi JOIN menu m ON oi.item_id = m.item_id WHERE oi.order_id = ?";
                    itemsPstmt = conn.prepareStatement(itemsSqlTotal);
                    itemsPstmt.setInt(1, orderId_confirm);
                    rsItemsTotal = itemsPstmt.executeQuery();
                    rsItemsTotal.next();
                    double subTotal = rsItemsTotal.getDouble("total");
                    double tax = 0.05 * subTotal; // Assuming 2% tax
                    double total = subTotal + tax;

                    // Add the total amount
                    Font boldFontprice = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
                    Paragraph totalAmount = new Paragraph("Subtotal:         $", boldFontprice);
                    totalAmount.add(new Chunk("\u20B9", boldFontprice));
                    totalAmount.add(new Chunk(String.format("%.2f", subTotal), boldFontprice));
                    totalAmount.add(new Chunk("\u20B9", boldFontprice));
                    totalAmount.setAlignment(Element.ALIGN_RIGHT);

                    Paragraph taxamount = new Paragraph("+    Tax:                   $", boldFontprice);
                    taxamount.add(new Chunk("\u20B9", boldFontprice));
                    taxamount.add(new Chunk(String.format("%.2f", tax), boldFontprice));
                    taxamount.add(new Chunk("\u20B9", boldFontprice));
                    taxamount.setAlignment(Element.ALIGN_RIGHT);

                    Paragraph underline = new Paragraph("-----------------------------", boldFontprice);
                    underline.add(new Chunk("\u20B9", boldFontprice));
                    underline.add(new Chunk("\u20B9", boldFontprice));
                    underline.setAlignment(Element.ALIGN_RIGHT);

                    Font boldFontpricegrand_total = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
                    Paragraph grand_total = new Paragraph("Total:         $", boldFontpricegrand_total);
                    grand_total.add(new Chunk("\u20B9", boldFontprice));
                    grand_total.add(new Chunk(String.format("%.2f", total), boldFontpricegrand_total));
                    grand_total.add(new Chunk("\u20B9", boldFontprice));
                    grand_total.setAlignment(Element.ALIGN_RIGHT);
                    totalAmount.setSpacingBefore(10);
                    document.add(totalAmount);
                    document.add(taxamount);
                    document.add(underline);
                    document.add(grand_total);

                    document.add(new Paragraph("\n"));                

                    Paragraph footer = new Paragraph("(This is a computer-generated invoice, no signature required)", timesNewRomanFont);
                    footer.setAlignment(Element.ALIGN_CENTER);
                    document.add(footer);
                    document.close();

                    OutputStream oStream = response.getOutputStream();
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "inline; filename=\"" + guestName + "_" + orderId_confirm + ".pdf\"");
                    baos.writeTo(oStream);
                    oStream.flush();

                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Error: " + e.getMessage());
                }
            }

            if (request.getParameter("orderId") != null) {

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password1);
                    String sql = "SELECT o.*, g.name AS guest_name, DATE(order_date) AS order_date, TIME(order_date) AS order_time FROM orders o JOIN guest g ON o.guest_id = g.guest_id WHERE o.order_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, orderId);
                    rs = pstmt.executeQuery();

                    // Update order status to "Confirmed"
                    String updateSql = "UPDATE orders SET status = 'Confirmed' WHERE order_id = ?";
                    updatePstmt = conn.prepareStatement(updateSql);
                    updatePstmt.setInt(1, orderId);
                    int rowsAffected = updatePstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        ByteArrayOutputStream baos = new ByteArrayOutputStream();
                        Document document = new Document();
                        PdfWriter.getInstance(document, baos);
                        document.open();

                        // Add company logo
                        ServletContext context = getServletContext();
                        String imagePath = context.getRealPath("/image/hotel-sign.png");
                        Image logo = Image.getInstance(imagePath);
                        logo.setAlignment(Image.ALIGN_CENTER);
                        logo.scaleAbsolute(50, 50);
                        document.add(logo);
                        String guestName = "";
                        if (rs.next()) {
                            guestName = rs.getString("guest_name");
                        }
                        // Create QR Code
                        String qrCodeText = "http://192.168.1.41:8080/Sun_Shine_Hotel/download_recipt.jsp?orderId=" + encryptData(String.valueOf(orderId), secretKey);
                        QRCodeWriter qrCodeWriter = new QRCodeWriter();
                        BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeText, BarcodeFormat.QR_CODE, 200, 200);
                        ByteArrayOutputStream qrCodeOutputStream = new ByteArrayOutputStream();
                        MatrixToImageWriter.writeToStream(bitMatrix, "png", qrCodeOutputStream);

                        // Add QR Code to PDF
                        Image qrCodeImage = Image.getInstance(qrCodeOutputStream.toByteArray());
                        qrCodeImage.scaleAbsolute(100, 100);

                        Paragraph qrCodeParagraph = new Paragraph();
                        qrCodeParagraph.setAlignment(Element.ALIGN_LEFT);
                        qrCodeParagraph.add(qrCodeImage);
                        document.add(qrCodeParagraph);

                        // Bull Bar & Restaurant Details
                        document.add(new Paragraph("SUN SHINE HOTEL"));
                        document.add(new Paragraph("2000, BULL PARK AVE"));
                        document.add(new Paragraph("NEW HILLS, NC, 27154-8908"));
                        document.add(new Paragraph("919-888-8888"));
                        document.add(new Paragraph("--------------------------------"));

                        // Guest details                      
                        document.add(new Paragraph("Guest Name: " + guestName));

                        // Order details
                        document.add(new Paragraph("Order-ID: " + orderId));
                        document.add(new Paragraph("Host: SUN SHINE HOTEL"));
                        document.add(new Paragraph("Date: " + rs.getDate("order_date")));
                        document.add(new Paragraph("Time: " + rs.getTime("order_time")));
                        document.add(new Paragraph("--------------------------------"));

                        // Table for food items
                        PdfPTable table = new PdfPTable(4); // 4 columns: Item ID, Item Name, Quantity, Price
                        table.setWidthPercentage(100);


                              
                        
                        // Column headers
                        table.addCell("Item ID");
                        table.addCell("Item Name");
                        table.addCell("Quantity");
                        table.addCell("Price");

                        // Fetch and display food items
                        String itemsSql = "SELECT oi.item_id, m.item_name, oi.quantity, (oi.quantity * m.price) AS price FROM order_items oi JOIN menu m ON oi.item_id = m.item_id WHERE oi.order_id = ?";
                        itemsPstmt = conn.prepareStatement(itemsSql);
                        itemsPstmt.setInt(1, orderId);
                        rsItems = itemsPstmt.executeQuery();
                        while (rsItems.next()) {
                            int itemId = rsItems.getInt("item_id");
                            String itemName = rsItems.getString("item_name");
                            int quantity = rsItems.getInt("quantity");
                            double price = rsItems.getDouble("price");

                            table.addCell(String.valueOf(itemId));
                            table.addCell(itemName);
                            table.addCell(String.valueOf(quantity));
                            table.addCell("$" + String.valueOf(price));
                        }

                        document.add(table);
                        document.add(new Paragraph("--------------------------------"));

                        // Calculate and display subtotal, tax, and total
                        String itemsSqlTotal = "SELECT SUM(oi.quantity * m.price) AS total FROM order_items oi JOIN menu m ON oi.item_id = m.item_id WHERE oi.order_id = ?";
                        itemsPstmt = conn.prepareStatement(itemsSqlTotal);
                        itemsPstmt.setInt(1, orderId);
                        rsItemsTotal = itemsPstmt.executeQuery();
                        rsItemsTotal.next();
                        double subTotal = rsItemsTotal.getDouble("total");
                        double tax = 0.05 * subTotal; // Assuming 2% tax
                        double total = subTotal + tax;

                        document.add(new Paragraph("Subtotal: $" + String.format("%.2f", subTotal)));
                        document.add(new Paragraph("Tax: $" + String.format("%.2f", tax)));
                        document.add(new Paragraph("Total: $" + String.format("%.2f", total)));

                        document.add(new Paragraph("--------------------------------"));

                        // Payment details
                        document.add(new Paragraph("Payment Type: VISA"));
                        document.add(new Paragraph("Authorization: APPROVED"));
                        document.add(new Paragraph("Payment Code: 75590544432297"));
                        document.add(new Paragraph("Payment ID: 786995403425400"));
                        document.add(new Paragraph("Card Reader: SWIPED/CHIP"));

                        document.close();

                        OutputStream oStream = response.getOutputStream();
                        response.setContentType("application/pdf");
                        response.setHeader("Content-Disposition", "inline; filename=\"" + guestName + "_" + orderId + ".pdf\"");
                        baos.writeTo(oStream);
                        oStream.flush();

                    } else {
                        response.getWriter().println("Order " + orderId + " not found or already confirmed.");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Error: " + e.getMessage());
                }

            }


        %>

    </body>
</html>
