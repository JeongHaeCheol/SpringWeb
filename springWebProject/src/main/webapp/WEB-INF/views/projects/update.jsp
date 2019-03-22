<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<link href="<c:url value ="/resources/css/input_file.css"/>"
	rel="stylesheet">
</head>

<main role="main" class="main col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">

		<sf:form action="${pageContext.request.contextPath}/projects/update"
			method="post" modelAttribute="project" enctype="multipart/form-data">


			<sf:input type="hidden" path="projectNo" id="projectNo"
				class="form-control" />

			<sf:input type="hidden" path="writer" id="wrtier"
				class="form-control" />

			<div class="form-group">
				<label for="title">제목</label>
				<sf:errors path="title" cssStyle="color:#ff0000;" />
				<sf:input path="title" id="title" style="width:60%;"
					class="form-control" />
			</div>

			<div class="form-group">
				<label for="envOrTech">개발환경 및 기술</label>
				<sf:errors path="envOrTech" cssStyle="color:#ff0000;" />
				<sf:textarea path="envOrTech" id="envOrTech" cols="30" row="5"
					style="width:60%; height: 90px;" class="form-control" />
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
			<div>
				<div class="file_input_textbox">
					<input type="text" id="fileName" readonly="readonly"
						style="width: 300px;" />
				</div>

				<div class="file_input_div">
					<input type="button" value="Search files" class="file_input_button" />
					<sf:input multiple="multiple" path="imageFiles" id="imageFiles"
						type="file" class="file_input_hidden" title="&nbsp;" />
				</div>

			</div>



			<div id="imagesDiv" class="imagesDiv" style="clear: left; margin-bottom: 10px;"></div>


			<sf:button type="submit" class="btn btn-primary">완료</sf:button>
			<a href="<c:url value="/projects/list"/>" class="btn btn-primary">취소</a>

		</sf:form>

	</div>
</div>
</main>






<script>
	var sel_file;
	var appendHtml = "";

	$(document).ready(function() {
		$("#imageFiles").on("change", fileChange);
	});

	function fileChange(e) {
		e.preventDefault();
	
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		var names = "";
		
		filesArr
				.forEach(function(f) {
					if (!f.type.match("image.*")) {
						alert("확장자는 이미지 확장자만 가능합니다.");
						return;
					}
					if(appendHtml == ""){
						$("#imagesDiv").html("");
					}

					sel_file = f;
					
					var reader = new FileReader();
					reader.readAsDataURL(f);
					reader.onload = function(e) {

						appendHtml += "<img id='uploadImg' src='"
								+ e.target.result
								+ "' style='border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;'> ";
						$("#imagesDiv").append(appendHtml);
						appendHtml = "";
						names += "  " + f.name;
						$("#fileName").val(names);
					}
				});

	}
</script>