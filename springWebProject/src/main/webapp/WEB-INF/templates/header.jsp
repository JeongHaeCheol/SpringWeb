<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav
	class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0"
		href="${pageContext.request.contextPath}/">Hae Cheol's Web</a> <input
		class="form-control form-control-dark col-md-8 w-100" type="text"
		placeholder="Search" aria-label="Search">

	<ul class="navbar-nav px-3 col-md-4">

		<c:if test="${pageContext.request.userPrincipal.name ==null }">
			
				<li style="float: left;"><a class="nav-link btn "
					href="<c:url value="/login"/> ">Login </a></li>
			
		</c:if>

		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<li><c:if
					test="${pageContext.request.userPrincipal.name == 'admin'}">
					
						<a class="nav-link btn " style="float: left; margin-right: 15px;"
							href="<c:url value="/admin"/>">AdminPage</a>
					
				</c:if>
				
					<a class="nav-link btn " style="float: left; margin-right: 15px;"
						href="javascript:document.getElementById('logout').submit()">Logout</a>
				
				<form id="logout" action="<c:url value="/logout"/>" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form></li>
		</c:if>
	</ul>
</nav>