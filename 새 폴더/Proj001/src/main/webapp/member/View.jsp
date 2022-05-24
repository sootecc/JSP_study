<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>  
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 정보 보기</title>
</head>
<body>
<h2> 파일 첨부형 게시판 - 상세보기 (View)</h2>

<table border = "1" width = "90%">
	<colgroup>
		<col width = "15%"/> <col width ="35%"/>
		<col width = "15%"/> <col width ="*"/>
	</colgroup>
	
	<!--  게시글 정보 출력 	 -->
	<tr> 
		<td>아이디 </td>	<td> ${dto.id }</td>
		<td>이름 </td>	<td>${dto.name} </td>
	</tr>
	
	<tr> 
		<td>작성일 </td>	<td> ${dto.joinDate }</td>
	</tr>
	
	
	
	<!--  하단 메뉴 버튼  -->
	<tr>
		<td colspan = "4" align ="center"> 
			<button type = "button" onclick = "location.href='../member/list.do';">목록 바로가기</button>					
		</td> 	
	</tr>
	

</table>











</body>
</html>