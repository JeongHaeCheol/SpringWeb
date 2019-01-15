<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<header>
<nav  id="headerId"
	class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow w-100">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0"
		href="${pageContext.request.contextPath}/">Hae Cheol's Web</a> 
		<input id="searchBar"
		class="form-control form-control-dark col-md-8 w-100" type="text"
		placeholder="Search" aria-label="Search">



	<c:if test="${pageContext.request.userPrincipal.name ==null }">
		<div class="navbar-nav px-3 col-md-2">
			<a class="nav-link btn" style="text-align: left;"
				href="<c:url value="/login"/> ">Login </a>
		</div>
	</c:if>

	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<div class="navbar-nav px-3 col-md-2">
			<c:if test="${pageContext.request.userPrincipal.name == 'admin'}">

				<a class="nav-link btn button-1" href="<c:url value="/admin"/>">AdminPage</a>

			</c:if>

			<a class="nav-link btn button-1"
				href="javascript:document.getElementById('logout').submit()">Logout</a>

			<form id="logout" action="<c:url value="/logout"/>" method="post">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</c:if>

</nav>

</header>


<script>
	$("#searchBar").keydown(function(key){
		var word = $(this).val();
		if(key.keyCode == 13) {
			window.location.href = "${pageContext.request.contextPath}/board/search?curPage=1&word=" + word;
		}
	})


</script>