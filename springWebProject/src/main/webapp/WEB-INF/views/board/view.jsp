<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">

		<table  class="board_view">
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

			<tr>
				<th>내용</th>
			</tr>

			<tbody>
					<td class="view_text">
						<div>${board.content}</div>
					</td>
			</tbody>
		</table>










	</div>
</div>
</main>