<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<link href="<c:url value ='/resources/css/input_file.css'/>"
	rel="stylesheet">
</head>

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">
		<h1>프로젝트 추가</h1>

		<sf:form id="addProjectForm"
			action="${pageContext.request.contextPath}/projects/addProject"
			method="post" modelAttribute="project" enctype="multipart/form-data">

			<div class="form-group">
				<label for="title">제목</label>
				<sf:errors path="title" cssStyle="color:#ff0000;" />
				<sf:input path="title" id="title" style="width:60%;"
					class="form-control" />

			</div>

			<div class="form-group">
				<label for="content">내용</label>
				<sf:errors path="content" cssStyle="color:#ff0000;" />
				<sf:textarea path="content" id="content" cols="40" row="60"
					style="width:60%; height:260px;" class="form-control" />


			</div>


			<div class="form-group">
				<label for="imageFilenames">이미지 업로드</label>
			</div>
			<sf:errors path="imageFilenames" cssStyle="color:#ff0000;" />
			<div>
				<div class="file_input_textbox">
					<input type="text" id="fileName" readonly="readonly" />
				</div>

				<div class="file_input_div">
					<input type="button" value="Search files" class="file_input_button" />
					<sf:input multiple="multiple" path="imageFiles" id="imageFiles" type="file" class="file_input_hidden"
						title="&nbsp;"
						onchange="javascript: document.getElementById('fileName').value = this.value" />
				</div>

			</div>

			<div style="clear: left;">
				<c:choose>
					<c:when test="${empty imageFilenames}">
						<div>
							<img id="uploadImg"
								src="/springWebProject/displayFile?fileName=/tempImg.gif"
								style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
						</div>
					</c:when>
					<c:otherwise>
						<div>
							<img id="uploadImg"
								src="/springWebProject/displayFile?fileName=${imageFilenames}"
								style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
						</div>
					</c:otherwise>
				</c:choose>
			</div>



			<sf:button type="submit" class="btn btn-primary">완료</sf:button>
			<a href="<c:url value="/projects/projectList"/>"
				class="btn btn-primary">취소</a>

		</sf:form>

	</div>
</div>
</main>



