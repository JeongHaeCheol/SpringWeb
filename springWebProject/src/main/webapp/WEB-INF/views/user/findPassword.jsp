<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">
		<h1>비빌번호 찾기</h1>
		<p class="lead">비빌번호 찾기 위해 정보를 입력하세요.</p>

		<form
			action="${pageContext.request.contextPath}/userHelp/sendPassword"
			method="post">

			<h3>기본정보</h3>
			<div class="form-group">
				<label for="username">ID</label> <input name="username"
					id="username" class="form-control" />
			</div>

			<div class="form-group">
				<label for="email">email</label>
				<input name="email" id="email" class="form-control" />
			</div>

			<input type="submit" value="submit" class="btn btn-primary">

			<a href="<c:url value="/login"/>" class="btn btn-primary">Cancel</a>
		</form>

	</div>


</div>
</main>