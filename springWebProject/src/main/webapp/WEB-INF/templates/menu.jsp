<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<nav id="menuId" class="col-md-2 d-none d-md-block bg-light sidebar">
	<div class="sidebar-sticky">
		<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link" href="<c:url value="/"/>"> <span
					data-feather="home">
					</span>HOME</a> 
			</li>
			<li class="nav-item"><a class="nav-link" href="<c:url value="/board/list"/>"> <span
					data-feather="file">
					</span>Board</a> 
			</li>
			<li class="nav-item"><a class="nav-link" href="<c:url value="/projects/list"/>"> <span
					data-feather="bar-chart-2"></span> Projects
			</a></li>
		
		</ul>
	</div>
</nav>