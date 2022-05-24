<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>	파일 첨부형 게시판 </title>
</head>
<body>
		
<h2>파일 첨부형 게시판 - 글쓰기(Write)</h2>

<script type="text/javascript">
	function validateForm(form){
		if(form.name.value =="" || form.name.value == 0 ){
			alert("이름을 입력하세요");
			form.name.value.focus();
			return false;
		}
		if(form.id.value =="" || form.id.value == 0 ){
			alert("아이디를 입력하세요");
			form.id.value.focus();
			return false;
		}
		if(form.email.value =="" || form.email.value == 0 ){
			alert("이메일을 입력하세요");
			form.email.value.focus();
			return false;
		}
		if(form.pwd.value =="" || form.pwd.value == 0 ){
			alert("비밀번호를 입력하세요");
			form.pwd.value.focus();
			return false;
		}
			
	}
	
</script>





<form name = "writeFrm" method ="post"  action = "../member/write.do" onsubmit = "return validateForm(this)">		
	<table border = "1" width ="90%" >
		<tr>
			<td> 아이디 :	</td>
			<td> <input type = "text" name = "id" style = "width: 150px;"></td>
		</tr>
		<tr>
			<td> 이름 :	</td>
			<td> <input type = "text" name = "name" style = "width: 150px;"></td>
		</tr>
		<tr>
			<td> 이메일 :		</td>
			<td> <input type = "text" name = "email" style = "width: 90%;"></td>
		</tr>

		<tr>
			<td> 비밀번호 :	</td>
			<td> <input type = "password" name = "pwd" style = "width: 100px;"></td>
		</tr>	
		<tr>
			<td colspan = "2" align = "center">
				<button type = "submit">작성완료</button>
				<button type = "reset">RESET</button>
				<button type = "button" onclick = "loaction.href ='../member/list.do'">목록 바로가기</button>
			</td>
		</tr>
		
		
		</table>
	
</form>		
		
		
</body>
</html>