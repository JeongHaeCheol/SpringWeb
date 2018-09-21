<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">
		<h2>게시글 목록</h2>
		<div style="float: right;">
			<a href="<c:url value="/board/write"/>" class="btn btn-primary">글쓰기</a>
		</div>
		<table class="table table-hover" boarder="1" width="600px">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>이름</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>

			<c:forEach var="board" items="${list}">
				<tr>
					<td>${board.bno}</td>
					<td><a href="<c:url value="/board/view?bno=${board.bno}"/>">${board.title}</a></td>
					<td>${board.writer}</td>
					<td><fmt:formatDate value="${row.regdate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${board.viewcnt}</td>
				</tr>
			</c:forEach>
		</table>


	</div>
</div>
</main>
