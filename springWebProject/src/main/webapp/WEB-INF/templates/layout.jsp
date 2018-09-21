<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Dashboard Template for Bootstrap</title>

<!-- Bootstrap core CSS -->
<link href="<c:url value ="/resources/css/bootstrap.min.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/css/dashboard.css"/>"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/mycustom.css"/>"
	rel="stylesheet">


</head>

<tiles:insertAttribute name="header" />
<tiles:insertAttribute name="menu" />

<body id="containerId">
	<div class="container-fluid">
		<div class="row">
	
			
			<tiles:insertAttribute name="body" />

		</div>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>

	<!-- Icons -->
	<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
	<script>
		feather.replace()

		const header = document.getElementById("headerId");
		if (header.style.position !== "fixed") {
			header.style.position = "fixed";
		}
		const sideBar = document.getElementById("menuId");

		const sideBarWidth = sideBar.clientWidth;
		console.log("width" + sideBarWidth);
		const headerHeight = header.clientHeight;

		document.getElementById("containerId").style.marginTop = headerHeight
				+ "px";
		document.getElementById("menuId").style.marginTop = headerHeight + "px";
	</script>


</body>
</html>
