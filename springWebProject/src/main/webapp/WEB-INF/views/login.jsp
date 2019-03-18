<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">
		<h2>Login with ID and Password</h2>
		<c:if test="${not empty errorMsg}">
			<div style="color: #ff0000">
				<h3>${errorMsg}</h3>
			</div>
		</c:if>
		<c:if test="${not empty logoutMsg}">
			<div style="color: #0000ff">
				<h3>${logoutMsg}</h3>
			</div>
		</c:if>


		<sf:form action="${pageContext.request.contextPath}/login"
			method="post" modelAttribute="user">
			<div class="form-group">
				<label for="username">ID:</label>
				<sf:input class="form-control" id="username" path="username"
					style="width: 50%" />
			</div>

			<div class="form-group">
				<label for="pwd">Password:</label>
				<sf:password class="form-control" id="password" path="password"
					style="width: 50%" />
			</div>


			<sf:button type="submit" class="btn btn-primary">로그인</sf:button>
			<a href="<c:url value="/register"/>" class="btn btn-primary">회원가입</a>
			<a href="<c:url value="/userHelp/findPassword"/>" class="btn btn-primary">비밀번호 찾기</a>
		</sf:form>

	</div>
</div>
</main>