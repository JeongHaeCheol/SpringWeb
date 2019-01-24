<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper" style="margin-bottom:70px;">
	<div class="container">
		<h2>게시글 목록</h2>
		<div style="float: right;">
			<a href="<c:url value="/board/write"/>" class="btn btn-primary myButton">글쓰기</a>
		</div>
		<table class="table table-hover" boarder="1" width="600px">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>

			<c:forEach var="board" items="${curList}">
				<tr>
					<td>${board.bno}</td>
					<td><a href="<c:url value="/board/view?bno=${board.bno}"/>">${board.title}</a></td>
					<td>${board.writer}</td>
					<td><fmt:formatDate value="${board.regdate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${board.viewcnt}</td>
				</tr>
			</c:forEach>
		</table>


		<div>
			<c:if test="${pageConfig.curRange ne 1 }">
				<a href="<c:url value="/board/list?curPage=1"/>">[처음]</a>
			</c:if>
			<c:if test="${pageConfig.curPage ne 1}">
				<a
					href="<c:url value="/board/list?curPage=${pageConfig.prevPage }"/>">[이전]</a>
			</c:if>
			<c:forEach var="pageNum" begin="${pageConfig.startPage}"
				end="${pageConfig.endPage }">
				<c:choose>
					<c:when test="${pageNum eq  pageConfig.curPage}">
						<span style="font-weight: bold;"><a
							href="<c:url value="/board/list?curPage=${pageNum}"/>">${pageNum }</a></span>
					</c:when>
					<c:otherwise>
						<a href="<c:url value="/board/list?curPage=${pageNum}"/>">${pageNum }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if
				test="${pageConfig.curPage ne pageConfig.pageCnt && pageConfig.pageCnt > 0}">
				<a
					href="<c:url value="/board/list?curPage=${pageConfig.nextPage}"/>">[다음]</a>
			</c:if>
			<c:if
				test="${pageConfig.curRange ne pageConfig.rangeCnt && pageConfig.rangeCnt > 0}">
				<a href="<c:url value="/board/list?curPage=${pageConfig.pageCnt}"/>">[끝]</a>
			</c:if>
		</div>

		<div>총 게시글 수 : ${pageConfig.listCnt } / 총 페이지 수 :
			${pageConfig.pageCnt } / 현재 페이지 : ${pageConfig.curPage }</div>


	</div>
</div>
</main>
