<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
	MultipartRequest multi = new MultipartRequest(request, "C:\\upload", 5 * 1024 * 1024, "utf-8",
			new DefaultFileRenamePolicy());


	Enumeration params = multi.getParameterNames();

	while (params.hasMoreElements()) {
		String name = (String) params.nextElement();
		String value = multi.getParameter(name);
		out.println(name + " = " + value + "<br>");
	}
	out.println("-----------------------------------<br>");


	String name = multi.getParameter("name");
	String subject = multi.getParameter("subject");

	String name2 = multi.getParameter("name2");
	String subject2 = multi.getParameter("subject2");

	String name3 = multi.getParameter("name3");
	String subject3 = multi.getParameter("subject3");

	Enumeration files = multi.getFileNames();

	String file = (String) files.nextElement();
	String filename = multi.getFilesystemName(file);
	out.println("작성자1 : " + name + ", ");
	out.println("제목1 : " + subject + ", ");
	out.println("업로드 된 파일명1 : " + filename + "<br>");

	String file2 = (String) files.nextElement();
	String filename2 = multi.getFilesystemName(file2);
	out.println("작성자2 : " + name2 + ", ");
	out.println("제목2 : " + subject2 + ", ");
	out.println("업로드 된 파일명2 : " + filename2 + "<br>");

	String file3 = (String) files.nextElement();
	String filename3 = multi.getFilesystemName(file2);
	out.println("작성자3 : " + name3 + ", ");
	out.println("제목3 : " + subject3 + ", ");
	out.println("업로드 된 파일명3 : " + filename3 + "<br>");
%>