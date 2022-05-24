<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>   
    
<!DOCTYPE html>
<html>
<head>
	<script>
		function validateForm(form) {
			if (form.pass.value == "") {
				alert ("비밀번호를 입력하세요"); 
				form.pass.focus(); 
				return false; 
			}
		}	
	</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h2> 비밀번호 검증 (pwd)</h2>
 
 
 
 
 <form name = "writeFrm" method = "post" action = "../member/pass.do" onsubmit = "return validateForm(this);">
	<input type = "hidden" name = "id" value = "${param.id }"  />
	<input type = "hidden" name = "mode" value = "${param.mode }" /> 
	
	<table border = "1" width = "90%"> 
		<tr> 
			<td> 비밀번호 : </td>
			<td>
				<input type = "password" name = "pwd" style = "width:100px;" /> 
			 </td>		
		</tr>
		<tr> 
			<td colspan = "2" align = "center"> 
				<button type = "submit" > 검증하기 </button>
				<button type = "reset" > RESET </button>
				<button type = "button" onclick = "location.href = '../member/list.do';">
					목록 바로가기
				</button>
			</td>		
		</tr>
	
	
	
	</table>	
 
 </form>
</body>
</html>