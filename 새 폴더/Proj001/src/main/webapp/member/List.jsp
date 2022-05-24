<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset = "UTF-8">
<title>member</title>
<style>a{text-decoration:none;}</style>
</head>
<body>
    <h2>member</h2>

   
    <!-- 목록 테이블 -->
    <table border="1" width="90%">
        <tr>
            <th width="10%">아이디</th>
            <th width="*">이름</th>
            <th width="15%">이메일</th>
            <th width="10%">작성일</th>
            <th width="15%">삭제</th>
        </tr>
<c:choose>    
    <c:when test="${ empty boardLists }">  <!-- 게시물이 없을 때 -->
        <tr>
            <td colspan="6" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
    </c:when>
    <c:otherwise>  <!-- 게시물이 있을 때 -->
        <c:forEach items="${ boardLists }" var="row" varStatus="loop">    
        <tr align="center">
            
            <td align="left">  <!-- 아이디 -->
                <a href="../member/view.do?id=${ row.id }">${ row.id }</a> 
            </td> 
            <td>${ row.name }</td>  <!-- 작성자 -->
            <td>${ row.email}</td><!-- 이메일 -->
            <td>${ row.joinDate }</td>  <!-- 작성일 -->
            <td><button type = "button" onclick = "location.href='../member/pass.do?mode=delete&id=${row.id }';">삭제하기</button></td>
        </tr>
        </c:forEach>        
    </c:otherwise>    
</c:choose>
    </table>

    <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%">
        <tr align="center">
            <td width="100"><button type="button"
                onclick="location.href='./write.do';">글쓰기</button></td>
        </tr>
    </table>
</body>
</html>