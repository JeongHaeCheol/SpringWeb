<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<main role="main" class="main col-md-9 ml-sm-auto col-lg-10 pt-3 px-4"
	style="height:80%; width:70%;">
<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<c:if test="${fileListSize >= 0}">
		<ol class="carousel-indicators">

			<c:forEach begin="1" end="${fileListSize}" step="1"
				varStatus="status">

				<c:choose>
					<c:when test="${status.index == 0}">
						<li data-target="#myCarousel" data-slide-to="${status.index}"
							class="active"></li>
					</c:when>
					<c:otherwise>
						<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
					</c:otherwise>
				</c:choose>

			</c:forEach>

		</ol>

		<div class="carousel-inner"
			style="height: 50%; background-color: #777;">



			<c:forEach var="fileName" items="${fileNameList}" varStatus="status">

				<c:choose>
					<c:when test="${status.index == 0}">
						<div class="carousel-item active">

							<img
								src="/springWebProject/displayFile?fileName=${fileName}&sel=1"
								class="project-img">

						</div>
					</c:when>

					<c:otherwise>
						<div class="carousel-item">

							<img
								src="/springWebProject/displayFile?fileName=${fileName}&sel=1"
								class="project-img">

						</div>
					</c:otherwise>

				</c:choose>
			</c:forEach>
		</div>
	</c:if>

	<a class="carousel-control-prev" href="#myCarousel" role="button"
		data-slide="prev"> <span class="carousel-control-prev-icon"
		aria-hidden="true"></span> <span class="sr-only">Previous</span>
	</a> <a class="carousel-control-next" href="#myCarousel" role="button"
		data-slide="next"> <span class="carousel-control-next-icon"
		aria-hidden="true"></span> <span class="sr-only">Next</span>
	</a>
</div>


<!-- Marketing messaging and featurettes
  ================================================== --> <!-- Wrap the rest of the page in another container to center all the content. -->

<div class="container marketing" style="margin-top: 100px;">

	<!-- Three columns of text below the carousel -->
	<div class="row">
		<div class="col-lg-10">
			<h2>${project.title}</h2>
			<p>${project.content}</p>
		</div>
		<!-- /.col-lg-4 -->

	</div>
	<!-- /.row -->


	<!-- START THE FEATURETTES -->

	<hr class="featurette-divider">

	<div class="row featurette">
		<div class="col-md-7">
			<h2 class="featurette-heading">개발환경 및 기술</h2>
			<p class="lead">${project.envOrTech}
		</div>
		<div class="col-md-5">
			<svg
				class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
				width="500" height="500" xmlns="http://www.w3.org/2000/svg"
				preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
				aria-label="Placeholder: 500x500">
			<title>Placeholder</title>
			<rect fill="#eee" width="100%" height="100%" /> <text fill="#aaa"
				dy=".3em" x="50%" y="50%">500x500</text></svg>
		</div>
	</div>

	<hr class="featurette-divider">

	<!-- <div class="row featurette">
		<div class="col-md-7 order-md-2">
			<h2 class="featurette-heading">
				Oh yeah, it’s that good. <span class="text-muted">See for
					yourself.</span>
			</h2>
			<p class="lead">Donec ullamcorper nulla non metus auctor
				fringilla. Vestibulum id ligula porta felis euismod semper. Praesent
				commodo cursus magna, vel scelerisque nisl consectetur. Fusce
				dapibus, tellus ac cursus commodo.</p>
		</div>
		<div class="col-md-5 order-md-1">
			<svg
				class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
				width="500" height="500" xmlns="http://www.w3.org/2000/svg"
				preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
				aria-label="Placeholder: 500x500">
			<title>Placeholder</title>
			<rect fill="#eee" width="100%" height="100%" /> <text fill="#aaa"
				dy=".3em" x="50%" y="50%">500x500</text></svg>
		</div>
	</div>

	<hr class="featurette-divider">

	<div class="row featurette">
		<div class="col-md-7">
			<h2 class="featurette-heading">
				And lastly, this one. <span class="text-muted">Checkmate.</span>
			</h2>
			<p class="lead">Donec ullamcorper nulla non metus auctor
				fringilla. Vestibulum id ligula porta felis euismod semper. Praesent
				commodo cursus magna, vel scelerisque nisl consectetur. Fusce
				dapibus, tellus ac cursus commodo.</p>
		</div>
		<div class="col-md-5">
			<svg
				class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
				width="500" height="500" xmlns="http://www.w3.org/2000/svg"
				preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
				aria-label="Placeholder: 500x500">
			<title>Placeholder</title>
			<rect fill="#eee" width="100%" height="100%" /> <text fill="#aaa"
				dy=".3em" x="50%" y="50%">500x500</text></svg>
		</div>
	</div>

	<hr class="featurette-divider">

	/END THE FEATURETTES -->

</div>
<!-- /.container --> </main>
