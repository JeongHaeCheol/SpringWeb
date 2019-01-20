<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">

<h1 class="projectlist-h1">Project List</h1>


<c:if test="${pageContext.request.userPrincipal.name != null}">
	<div>
		<c:if test="${pageContext.request.userPrincipal.name == 'admin'}">
			<a class="btn btn-primary" style="float: right;"
				href="<c:url value="/projects/addProject"/>">프로젝트 추가</a>
		</c:if>
	</div>
</c:if>

<div class="album py-5 bg-light" style="margin-top: 80px;">
	<div class="container">
		<div class="row">
			<c:forEach var="project" items="${projectList}">
				<div class="col-md-3">

					<div class="card mb-3 shadow-sm">
						<img src="/springWebProject/displayFile?fileName=/tempImg.gif"
							class="card-img">

						<div class="card-body">
							<p class="card-text">${project.title}</p>
							<div class="d-flex justify-content-between align-items-center">
								<div class="btn-group">
									<button type="button" class="btn btn0sm btn-outline-secondary">View</button>
									<c:if
										test="${pageContext.request.userPrincipal.name != '${project.writer}'}">
										<button type="button" class="btn btn0sm btn-outline-secondary">Edit</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>



		</div>
	</div>

</div>
</main>
