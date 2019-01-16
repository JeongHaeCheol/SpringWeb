<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<header>
	<nav id="headerId"
		class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow w-100">
		<a class="navbar-brand col-sm-3 col-md-2 mr-0"
			href="${pageContext.request.contextPath}/">Hae Cheol's Web</a>
		<button class="dropdown nav-link btn col-sm-1 col-md-1 mr-0">
			<a class="dropdown-toggle" id="current-filter" data-toggle="dropdown">
				<c:choose>
					<c:when test="${filter == null}">제목</c:when>
					<c:when test="${filter == 'title'}">제목</c:when>
					<c:when test="${filter == 'content'}">내용</c:when>
					<c:when test="${filter == 'writer'}">작성자</c:when>
					<c:otherwise>제목</c:otherwise>
				</c:choose>
			</a>
			<ul class="dropdown-menu" id="dropdown-menu">
				<li class="dropdown-item active" id="item-title">제목</li>
				<li class="dropdown-item" id="item-content">내용</li>
				<li class="dropdown-item" id="item-writer">작성자</li>
			</ul>
		</button>
		<input id="searchBar"
			class="form-control form-control-dark col-md-7 w-100" type="text"
			placeholder="Search" aria-label="Search" value="${word}">



		<c:if test="${pageContext.request.userPrincipal.name ==null }">
			<div class="navbar-nav px-3 col-md-4">
				<a class="nav-link btn" style="text-align: left;"
					href="<c:url value="/login"/> ">Login </a>
			</div>
		</c:if>

		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<div class="navbar-nav px-3 col-md-4">
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
	
	$("#dropdown-menu li").mouseenter(function() {
		$(this).addClass("active");
	}).mouseleave(function() {
		$(this).removeClass("active");
	})

	$("#dropdown-menu li").click(function() {
		$("#current-filter").html($(this).text());
	})

	$("#searchBar")
			.keydown(
					function(key) {
						var word = $(this).val();
						var filter;
						if (key.keyCode == 13) {
							
								switch ($("#current-filter").text().trim()) {
								case "제목":
									filter = "title";
									break;
								case "내용":
									filter = "content";
									break;
								case "작성자":
									filter = "writer";
									break;
								default:
									filter = "title";
								}
							window.location.href = "${pageContext.request.contextPath}/board/search?curPage=1&word="
									+ word + "&filter=" + filter;
						}
					})
</script>