<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<link href="<c:url value ="/resources/css/input_file.css"/>"
	rel="stylesheet">
</head>

<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
<div class="container-wrapper">
	<div class="container">
		<h1>글쓰기</h1>

		<sf:form id="writeArticle"
			action="${pageContext.request.contextPath}/board/write" method="post"
			modelAttribute="board" enctype="multipart/form-data">

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
				<label for="imageFile">이미지 업로드</label>
			</div>
			<sf:errors path="imageFile" cssStyle="color:#ff0000;" />
			<div>
				<div class="file_input_textbox">
					<input type="text" id="fileName" readonly="readonly" />
				</div>

				<div class="file_input_div">
					<input type="button" value="Search files" class="file_input_button" />
					<sf:input type="file" path="imageFile" id="imageFile"
						class="file_input_hidden" title="&nbsp;"
						onchange="javascript: document.getElementById('fileName').value = this.value" />
				</div>
			</div>

			<div style="clear: left;">
				<c:choose>
					<c:when test="${empty imageFile}">
						<div>
							<img id="profileImg"
								src="/springWebProject/displayFile?fileName=/tempImg.gif"
								style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
						</div>
					</c:when>
					<c:otherwise>
						<div>
							<img id="profileImg"
								src="/springWebProject/displayFile?fileName=${imageFile}"
								style="border-radius: 0%; padding-top: 10px; height: 100px; width: 100px;">
						</div>
					</c:otherwise>
				</c:choose>
			</div>



			<sf:button type="submit" class="btn btn-primary">완료</sf:button>
			<a href="<c:url value="/board/list"/>" class="btn btn-primary">취소</a>


		</sf:form>


	</div>
</div>
</main>



<script>
	$(document).ready(function() {
		$("#profileImg").click(function() {
			$("#imageFile").click();
		})
	})
</script>




<script>
	var sel_file;

	$(document).ready(function() {
		$("#imageFile").on("change", fileChange);
	});

	function fileChange(e) {
		e.preventDefault();

		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}

			sel_file = f;

			var reader = new FileReader();
			reader.onload = function(e) {
				$("#profileImg").attr("src", e.target.result);
				$("#profileImg").css("height", "100px")
			}
			reader.readAsDataURL(f);
		});

		var file = files[0]
		console.log(file)
		var formData = new FormData();

		formData.append("file", file);

		$.ajax({
			url : '/uploadAjax',
			data : formData,
			dataType : 'text',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {

				alert("프로필 이미지가 변경 되었습니다.")

			}
		})

		function checkImageType(fileName) {
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			return fileName.match(pattern);
		}

		function getOriginalName(fileName) {
			if (checkImageType(fileName)) {
				return;
			}

			var idx = fileName.indexOf("_") + 1;
			return fileName.substr(idx);

		}

		function getImageLink(fileName) {

			if (!checkImageType(fileName)) {
				return;
			}
			var front = fileName.substr(0, 12);
			var end = fileName.substr(14);

			return front + end;

		}

	}
</script>

