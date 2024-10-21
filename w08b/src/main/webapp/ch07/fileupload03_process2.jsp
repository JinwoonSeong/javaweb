<%@page contentType="text/html; charset=utf-8"%>
<%@page import="jakarta.servlet.http.Cookie" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.file.Path"%>
<%@page import="org.apache.commons.fileupload2.core.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload2.core.FileItem"%>
<%@page import="org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload"%>
<%@page import="jakarta.servlet.ServletException"%>
<%@page import="jakarta.servlet.annotation.WebServlet"%>
<%@page import="jakarta.servlet.http.HttpServlet"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if (JakartaServletFileUpload.isMultipartContent(request)) {
	DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
	
	JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);
	upload.setFileSizeMax(1024*1024);
	upload.setSizeMax(1024*1024);
	
	String uploadPath = "c:/upload";
	System.out.println("파일업로드 "+ uploadPath);
	File uploadDir = new File(uploadPath);
	if (!uploadDir.exists()) {
	uploadDir.mkdir();
	}
	
	try {
		List<FileItem> formItems = upload.parseRequest(request);
		if (formItems != null && formItems.size() > 0) {
			for (FileItem item : formItems) {
				if (!item.isFormField()) {
					String fileName = new File(item.getName()).getName();
					item.write(Path.of(uploadPath, fileName));
					
					response.getWriter().println(String.format(
						"Field Name = %s, File Name = %s, File Size = %s "
						, item.getFieldName()
						, item.getName()
						, item.getSize()
					));
				}
			}
		}
	} catch (Exception ex) {
		System.out.println("There was an error: " + ex.getMessage());
		}
	}
%>
</body>
</html>