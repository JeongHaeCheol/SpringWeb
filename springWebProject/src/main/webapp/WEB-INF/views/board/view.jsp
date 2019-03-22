<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<script>
	function deleteConfirm() {
		if (confirm("게시물을 삭제 하시겠습니까?")) {
			location.href = "${pageContext.request.contextPath}/board/delete?bno=${board.bno}";
		} else {
			return false;
		}
	}
</script>

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">

		<table class="board_view">
			<tr>
				<th><h4>제목</h4></th>
				<td><h4>${board.title}</h4></td>
			</tr>

			<tr>
				<th>글번호</th>
				<td>${board.bno}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><fmt:formatDate value="${board.regdate}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${board.writer}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${board.viewcnt}</td>
			</tr>


		</table>



		<div style=" margin-top:20px; border:1px gray solid; padding: 10px; width: 500px;">${board.content}</div>


		<div>
			<c:if test="${not empty board.imageFileName}">
				<img id="uploadedImg"
					src="/springWebProject/displayFile?fileName=${board.imageFileName}&sel=0"
					style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
			</c:if>
		</div>


		<c:if test="${approval == 'OK'}">
			<div style="position: relative; top: 10px; left: 400px;">
				<a href="<c:url value="/board/update?bno=${board.bno}"/>"
					class="btn btn-primary">수정</a> <a onclick="deleteConfirm();"
					class="btn btn-primary" style="color: white">삭제</a>
			</div>
		</c:if>


		<div style="position: relative; top: 10px; bottom: 20px;">
			<table>
				<tr>
					<c:if test="${nextBoard != null}">
						<th>다음글
						<td><a
							href="<c:url value="/board/view?bno=${nextBoard.bno}"/>">${nextBoard.title}</a></td>
					</c:if>
				</tr>

				<tr>
					<c:if test="${preBoard != null}">
						<th>이전글
						<td><a
							href="<c:url value="/board/view?bno=${preBoard.bno}"/>">${preBoard.title}</a></td>
					</c:if>
				</tr>
			</table>
		</div>
	</div>
</div>

<%@ include file="comment.jsp"%> </main>

