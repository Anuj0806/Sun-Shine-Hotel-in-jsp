<%@include file="config.jsp" %>
<%
    if (session.getAttribute("employee") == null && session.getAttribute("admin_email") == null) {
        response.sendRedirect("employeelogin.html");
    }
    // Get the invoice number from the request parameter
    String invoice_no = decryptData(request.getParameter("invoice_no"), secretKey);
    String customerName = "";
    // Connect to the database
    Connection conn = null;
    Statement stmt = null;

    try {
        Class.forName(driver);
        Connection con = DriverManager.getConnection(url, user, password1);
        String sql = "select * from booking_details where invoice_no=?";
        PreparedStatement pst = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        pst.setString(1, invoice_no);
        ResultSet rs = pst.executeQuery();

        // Create a PDF document       
        // Create a PDF document using iText        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();
        PdfWriter.getInstance(document, baos);

        document.open();
        document.add(new Paragraph("\n")); // add a blank line to the top of the page       

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
        Paragraph invoiceTitle = new Paragraph("Hotel Invoice", time_new_roman_bold);
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

        // Add a box with a light blue background
        PdfPTable box = new PdfPTable(2);
        box.setWidthPercentage(100);

// Set the width of the columns
        float[] columnWidths = {78, 21};
        box.setWidths(columnWidths);

// Create the cells for the invoice details
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(new BaseColor(242, 242, 242));
        cell.setBorderWidth(1);
        cell.setPadding(10);
        String booking_price = "";
// Add the invoice details
        if (rs.first()) {
            String invoice_no_guest = rs.getString("invoice_no");
            customerName = rs.getString("guest_name");
            String address = rs.getString("guest_address");
            String paymentMode = rs.getString("payment_mode");
            String invoiceDate = rs.getString("date_time");
            booking_price = rs.getString("booking_price");

            Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
            Font regularFont = timesNewRomanFont;

            Paragraph InvoiceParagraph = new Paragraph("", regularFont);
            InvoiceParagraph.add(new Chunk("Invoice Number: ", boldFont));
            InvoiceParagraph.add(new Chunk(invoice_no_guest, regularFont));

            Paragraph customerNameParagraph = new Paragraph("", regularFont);
            customerNameParagraph.add(new Chunk("Customer Name: ", boldFont));
            customerNameParagraph.add(new Chunk(customerName, regularFont));

            Paragraph addressParagraph = new Paragraph("", regularFont);
            addressParagraph.add(new Chunk("Address: ", boldFont));
            addressParagraph.add(new Chunk(address, regularFont));

            Paragraph paymentModeParagraph = new Paragraph("", regularFont);
            paymentModeParagraph.add(new Chunk("Payment Mode: ", boldFont));
            paymentModeParagraph.add(new Chunk(paymentMode, regularFont));

            Paragraph invoiceDateParagraph = new Paragraph("", regularFont);
            invoiceDateParagraph.add(new Chunk("Invoice Date: ", boldFont));
            invoiceDateParagraph.add(new Chunk(invoiceDate, regularFont));

            // Add the invoice details to the first column
            cell.addElement(InvoiceParagraph);
            cell.addElement(customerNameParagraph);
            cell.addElement(addressParagraph);
            cell.addElement(paymentModeParagraph);
            cell.addElement(invoiceDateParagraph);

            box.addCell(cell);

            // Create QR code
            String qrCodeText = "http://192.168.1.41:8080/Sun_Shine_Hotel/";
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeText, BarcodeFormat.QR_CODE, 200, 200);
            ByteArrayOutputStream qrCodeOutputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "png", qrCodeOutputStream);

            // Add QR Code to PDF
            Image qrCodeImage = Image.getInstance(qrCodeOutputStream.toByteArray());
            qrCodeImage.scaleToFit(108, 200);

            // Create a new paragraph for the QR code
            Chunk qrCodeChunk = new Chunk(qrCodeImage, -9, -99);
            Paragraph paragraphqr = new Paragraph();
            paragraphqr.add(qrCodeChunk);
            paragraphqr.setAlignment(Element.ALIGN_RIGHT);

            // Add the QR code to the second column
            PdfPCell qrCodeCell = new PdfPCell(paragraphqr);
            qrCodeCell.setBackgroundColor(new BaseColor(242, 242, 242));
            qrCodeCell.setBorderWidth(1);
            qrCodeCell.setPadding(10);
            qrCodeCell.setRowspan(5);
            box.addCell(qrCodeCell);
        }

        document.add(box);

        // Add the room details table
        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(100); // Set table width to 100%
        table.setSpacingBefore(10); // Add space before the table

// Set padding for header cells
        Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.BOLD);
        PdfPCell headerCell = new PdfPCell();
        headerCell.setPadding(5); // Set padding to 5 points
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
        headerCell.setBorderWidth(0.5f); // Set border width

        headerCell.addElement(new Phrase("Room Number", boldFont));
        table.addCell(headerCell);

        headerCell = new PdfPCell();
        headerCell.setPadding(5); // Set padding to 5 points
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
        headerCell.setBorderWidth(0.5f); // Set border width
        headerCell.addElement(new Phrase("Room Type", boldFont));
        table.addCell(headerCell);

        headerCell = new PdfPCell();
        headerCell.setPadding(5); // Set padding to 5 points
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
        headerCell.setBorderWidth(0.5f); // Set border width
        headerCell.addElement(new Phrase("Check-in", boldFont));
        table.addCell(headerCell);

        headerCell = new PdfPCell();
        headerCell.setPadding(5); // Set padding to 5 points
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
        headerCell.setBorderWidth(0.5f); // Set border width
        headerCell.addElement(new Phrase("Check-out", boldFont));
        table.addCell(headerCell);

        headerCell = new PdfPCell();
        headerCell.setPadding(5); // Set padding to 5 points
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
        headerCell.setBorderWidth(0.5f); // Set border width
        headerCell.addElement(new Phrase("Price per Night", boldFont));
        table.addCell(headerCell);

        headerCell = new PdfPCell();
        headerCell.setPadding(5); // Set padding to 5 points
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY); // Set background color
        headerCell.setBorderWidth(0.5f); // Set border width
        headerCell.addElement(new Phrase("Status", boldFont));
        table.addCell(headerCell);

        rs.beforeFirst();
        while (rs.next()) {
            String roomNumber = rs.getString("room_no");
            String roomType = rs.getString("ac");
            String checkIn = rs.getString("check_in");
            String checkOut = rs.getString("check_out");
            String pricePerNight = rs.getString("room_prize");
            String status = "";

            if (rs.getString("approve_status").equals("A")) {
                status = "Confirmed.....";
            }
            if (rs.getString("approve_status").equals("DIS")) {
                status = "Cancel.....";
            }
            if (rs.getString("approve_status").equals("A") && rs.getString("reservation_status").equals("CO")) {
                status = "Check Out..";
            }

            // Set padding for data cells
            PdfPCell dataCell = new PdfPCell();
            dataCell.setPadding(5); // Set padding to 5 points
            dataCell.addElement(new Phrase(roomNumber, timesNewRomanFont));
            table.addCell(dataCell);

            dataCell = new PdfPCell();
            dataCell.setPadding(5); // Set padding to 5 points
            dataCell.addElement(new Phrase(roomType, timesNewRomanFont));
            table.addCell(dataCell);

            dataCell = new PdfPCell();
            dataCell.setPadding(5); // Set padding to 5 points
            dataCell.addElement(new Phrase(checkIn, timesNewRomanFont));
            table.addCell(dataCell);

            dataCell = new PdfPCell();
            dataCell.setPadding(5); // Set padding to 5 points
            dataCell.addElement(new Phrase(checkOut, timesNewRomanFont));
            table.addCell(dataCell);

            dataCell = new PdfPCell();
            dataCell.setPadding(5); // Set padding to 5 points
            dataCell.addElement(new Phrase(pricePerNight, timesNewRomanFont));
            table.addCell(dataCell);

            dataCell = new PdfPCell();
            dataCell.setPadding(5); // Set padding to 5 points
            dataCell.addElement(new Phrase(status, timesNewRomanFont));
            table.addCell(dataCell);
        }

        table.setSpacingBefore(30);
        document.add(table);

        // Add the total amount
        Font boldFontprice = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
        Paragraph totalAmount = new Paragraph("Total Amount: ", boldFontprice);
        totalAmount.add(new Chunk("\u20B9", boldFontprice));
        totalAmount.add(new Chunk(booking_price, boldFontprice));
        totalAmount.add(new Chunk("\u20B9", boldFontprice));
        totalAmount.setAlignment(Element.ALIGN_RIGHT);
        totalAmount.setSpacingBefore(20);
        document.add(totalAmount);

        document.add(new Paragraph("\n")); // add a blank line to the top of the page

        Phrase phrase = new Phrase();
        phrase.add(new Chunk("Cashier's Signature", timesNewRomanFont));
        phrase.add(new Chunk(String.format("%110s", " "), timesNewRomanFont)); // add 50 spaces
        phrase.add(new Chunk("Guest's Signature", timesNewRomanFont));
        document.add(phrase);

        Phrase phrase1 = new Phrase();
        phrase1.add(new Chunk("...................", timesNewRomanFont));
        phrase1.add(new Chunk(String.format("%130s", " "), timesNewRomanFont)); // add 50 spaces
        phrase1.add(new Chunk("...................", timesNewRomanFont));
        document.add(phrase1);

        // Add a footer
        Paragraph footer = new Paragraph("Thank you for using Our Hotel Service.", timesNewRomanFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(50);
        document.add(footer);
        footer = new Paragraph("(This is a computer-generated invoice, no signature required)", timesNewRomanFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);

        document.close();

        OutputStream oStream = response.getOutputStream();
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"" + customerName + "_" + invoice_no + ".pdf\"");
        baos.writeTo(oStream);
        oStream.flush();

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>