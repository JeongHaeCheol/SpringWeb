<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Hae Cheol's
		Web</a> <input class="form-control form-control-dark w-100" type="text"
		placeholder="Search" aria-label="Search">
	<ul class="navbar-nav px-3">
		<li class="nav-item text-nowrap">
		
			<c:if
				test="${pageContext.request.userPrincipal.name ==null }">
				<li class="nav-item"><a class="nav-link"
					href="<c:url value="/login"/> ">Login </a>
				</li>
			</c:if> 
			
			<c:if test="${pageContext.request.userPrincipal.name != null}">
				<c:if test="${pageContext.request.userPrincipal.name == 'admin'}">
					<li class="nav-item"><a class="nav-link"
						href="<c:url value="/admin"/>">AdminPage</a></li>
				</c:if>

				<li class="nav-item"><a class="nav-link"
					href="javascript:document.getElementById('logout').submit()">Logout</a></li>
				<form id="logout" action="<c:url value="/logout"/>" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
			</c:if>
			
		</li>
	</ul>
</nav>