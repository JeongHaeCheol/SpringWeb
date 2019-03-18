<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

<script type="text/javascript"> 

$(function() {
	$.validator.addMethod("regx", function(value, element, regexpr){
		return regexpr.test(value);
	});
	
	$("#registerForm").validate({
		
		rules: {
				username: {required: true, minlength: 5, maxlength:10},
				password: {required: true, regx:/^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z0-9$@$!%*#?&]{5,20}$/ }
		},
		messages: { 
			username: "5~10자로 입력해주세요",
			password: "최소 5자리에 숫자, 문자, 특수문자 각각 1개 이상 포함  최대 20자",
			required: "필수 항목입니다.", 
			remote: "항목을 수정하세요.", 
			email: "유효하지 않은 E-Mail주소입니다.", 
			url: "유효하지 않은 URL입니다.", 
			date: "올바른 날짜를 입력하세요.", 
			dateISO: "올바른 날짜(ISO)를 입력하세요.", 
			number: "유효한 숫자가 아닙니다.", 
			digits: "숫자만 입력 가능합니다.", 
			creditcard: "신용카드 번호가 바르지 않습니다.", 
			equalTo: "같은 값을 다시 입력하세요.", 
			extension: "올바른 확장자가 아닙니다.", 
			maxlength: $.validator.format( "{0}자를 넘을 수 없습니다. " ), 
			minlength: $.validator.format( "{0}자 이상 입력하세요." ), 
			rangelength: $.validator.format( "문자 길이가 {0} 에서 {1} 사이의 값을 입력하세요." ), 
			range: $.validator.format( "{0} 에서 {1} 사이의 값을 입력하세요." ), 
			max: $.validator.format( "{0} 이하의 값을 입력하세요." ), 
			min: $.validator.format( "{0} 이상의 값을 입력하세요." ) 
		}} ); 
});

		
</script>


<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper" style="margin-bottom:20px;">
	<div class="container">
		<h1>회원가입</h1>
		<p class="lead">회원 가입을 위한 정보를 입력하세요.</p>

		<sf:form action="${pageContext.request.contextPath}/register"
			id="registerForm" method="post" modelAttribute="user">

			<h3>기본정보</h3>
			<div class="form-group">
				<label for="username">ID</label> <span style="color: #ff0000">${usernameMsg}</span>
				<sf:input path="username" id="username" class="form-control" />
				<sf:errors path="username" cssStyle="color : #ff0000" />
			</div>

			<div class="form-group">
				<label for="password">Password</label>
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