<%@ page contentType = "text/html;charset =utf-8"%>
<%@ page import = "com.oreilly.servlet.*"%>
<%@ page import = "com.oreilly.servlet.multipart.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*"%>
<%
    MultipartRequest multi = new MultipartRequest(request, "C:\\upload", 5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());

    String title = multi.getParameter("title");
    out.println("<h3>" + title + "</h3>");

    Enumeration files = multi.getFileNames();
    String name = (String) files.nextElement();

    String filename = multi.getFilesystemName(name);
    String original = multi.getOriginalFileName(name);

    out.println("실제 파일 이름 : " + original + "<br>");
    out.println("저장 파일 이름 : " + filename + "<br>");
%>