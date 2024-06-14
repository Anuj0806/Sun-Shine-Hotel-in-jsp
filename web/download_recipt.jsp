<%@page import="java.io.IOException"%>
<%@page import="java.io.OutputStream"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
               int orderId_confirm = Integer.valueOf(decryptData(request.getParameter("orderId"), secretKey));
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                 Connection   conn = DriverManager.getConnection(url, user, password1);
                    String sql = "SELECT o.*, g.name AS guest_name, DATE(order_date) AS order_date, TIME(order_date) AS order_time FROM orders o JOIN guest g ON o.guest_id = g.guest_id WHERE o.order_id = ?";
                  PreparedStatement  pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, orderId_confirm);
                   ResultSet rs = pstmt.executeQuery();

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
                    hostthird.add(new Chunk("Hotel Name:", boldFont));
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
                     PreparedStatement  itemsPstmt = conn.prepareStatement(itemsSql);
                    itemsPstmt.setInt(1, orderId_confirm);
                    ResultSet rsItems = itemsPstmt.executeQuery();
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
                   ResultSet rsItemsTotal = itemsPstmt.executeQuery();
                    rsItemsTotal.next();
                    double subTotal = rsItemsTotal.getDouble("total");
                    double tax = 0.05 * subTotal; // Assuming 2% tax
                    double total = subTotal + tax;

                    // Add the total amount
                    Font boldFontprice = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
                    Paragraph totalAmount = new Paragraph("Subtotal:    $", boldFontprice);
                    totalAmount.add(new Chunk("\u20B9", boldFontprice));
                    totalAmount.add(new Chunk(String.format("%.2f", subTotal), boldFontprice));
                    totalAmount.add(new Chunk("\u20B9", boldFontprice));
                    totalAmount.setAlignment(Element.ALIGN_RIGHT);

                    Paragraph taxamount = new Paragraph("+    Tax:              $", boldFontprice);
                    taxamount.add(new Chunk("\u20B9", boldFontprice));
                    taxamount.add(new Chunk(String.format("%.2f",tax), boldFontprice));
                    taxamount.add(new Chunk("\u20B9", boldFontprice));
                    taxamount.setAlignment(Element.ALIGN_RIGHT);

                    Paragraph underline = new Paragraph("-----------------------", boldFontprice);
                    underline.add(new Chunk("\u20B9", boldFontprice));
                    underline.add(new Chunk("\u20B9", boldFontprice));
                    underline.setAlignment(Element.ALIGN_RIGHT);

                    Font boldFontpricegrand_total = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
                    Paragraph grand_total = new Paragraph("Total:     $", boldFontpricegrand_total);
                    grand_total.add(new Chunk("\u20B9", boldFontprice));
                    grand_total.add(new Chunk(String.format("%.2f", total), boldFontpricegrand_total));
                    grand_total.add(new Chunk("\u20B9", boldFontprice));
                    grand_total.setAlignment(Element.ALIGN_RIGHT);
                    totalAmount.setSpacingBefore(20);
                    document.add(totalAmount);
                    document.add(taxamount);
                    document.add(underline);
                    document.add(grand_total);

                    document.add(new Paragraph("\n"));
                   
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
        %>
    </body>
</html>
