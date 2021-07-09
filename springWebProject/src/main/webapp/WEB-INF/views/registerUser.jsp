<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

		

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper" style="margin-bottom:20px;">
	<div class="container">
		<h1>회원가입</h1>
		<p class="lead">회원 가입을 위한 정보를 입력하세요.</p>

		<sf:form action="${pageContext.request.contextPath}/register"
			id="registerForm" method="post" modelAttribute="user">

			<h3>기본정보</h3>
			<div class="form-group">
				<label for="username">ID (사용자 아이디는 5자리 이상 12자 이하만 가능 합니다.)</label> 
				<sf:input path="username" id="username" class="form-control" />
				<sf:errors path="username" cssStyle="color : #ff0000" />
			</div>

			<div class="form-group">
				<label for="password">Password (최소 5자 최대 20자 숫자, 문자, 특수문자 각각 1개 이상 포함)</label>
				<sf:password path="password" id="password" class="form-control" />
				<sf:errors path="password" cssStyle="color:#ff0000" />
			</div>

			<div class="form-group">
				<label for="email">email</label>
				<sf:input type="email" path="email" id="email" class="form-control" />
				<sf:errors path="email" cssStyle="color:#ff0000" />
			</div>

			<input type="submit" value="submit" class="btn btn-primary">

			<a href="<c:url value="/login"/>" class="btn btn-primary" >Cancel</a>
		</sf:form>

	</div>


</div>
</main>