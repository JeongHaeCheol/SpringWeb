<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">
		<h1>글쓰기</h1>

		<sf:form
			action="${pageContext.request.contextPath}/board/insert?${_csrf.parameterName}=${_csrf.token}"
			method="post" modelAttribute="board" >
			<div class="form-group">
				<label for="title">제목</label>
				<sf:input path="title" id="title" style="width:60%;" class="form-control" />
				<sf:errors path="title" cssStyle="color:#ff0000;" />
			</div>

			<div class="form-group" >
				<label for="content">내용</label>
				<sf:textarea path="content" id="content" cols="40" row="60" style="width:60%; height:260px;" class="form-control" />
				<sf:errors path="content" cssStyle="color:#ff0000;" />
			</div>
			
			<input type="submit" value="submit" class="btn btn-primary">
			<a href="<c:url value="/board/list"/>" class="btn btn-primary">취소</a>

		</sf:form>
	</div>
</div>
</main>