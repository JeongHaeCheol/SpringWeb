<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<div class="container">
	<form id="commentForm" name="commentForm" method="post">
		<br> <br>
		<div>
			<div>
				<span><strong>Comments</strong></span> <span id="cCnt"></span>
			</div>
			<div>
				<table class="table">
					<tr>
						<td><textarea style="width: 500px" rows="3" cols="30"
								id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
							<br>
							<div>
								<a href='' onClick="fn_comment()"
									class="btn pull-right btn-success">등록</a>
							</div></td>
					</tr>
				</table>
			</div>
		</div>
		<input type="hidden" id="b_code" name="b_code" value="${board.bno}" />
	</form>
</div>

<div class="container">
	<form id="commentListForm" name="commentListForm" method="post">
		<input type="hidden" id="bno" name="bno" value="${board.bno}" />

	</form>
	<div id="commentList"></div>
</div>

<script>
	function fn_comment() {

		$.ajax({
			type : 'POST',
			url : "<c:url value='/board/addComment'/>",
			data : $("#commentForm").serialize(),
			success : function(data) {
				if (data == "success") {
					getCommentList();
					$("#comment").val("");
				}
			},
			error : function(request, status, error) {
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}

		});
	}

	function delete_comment(code) {
		$.ajax({
			type : 'POST',
			url : "<c:url value='/board/deleteComment'/>",
			data : {
				"c_code" : code
			},
			success : function(data) {
				if (data == "success") {
					getCommentList();
				}
				else if(data == "No permission"){
					alert("권한 없음");
				}
			},
			error : function(request, status, error) {
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}

		});
	}

	/**
	 * 초기 페이지 로딩시 댓글 불러오기
	 */
	$(function() {

		getCommentList();

	});

	/**
	 * 댓글 불러오기(Ajax)
	 */
	function getCommentList() {

		$
				.ajax({
					type : 'GET',
					url : "<c:url value='/board/commentList'/>",
					dataType : "json",
					data : $("#commentListForm").serialize(),
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(data) {
						var html = "";
						var cCnt = data.length;

						if (data.length > 0) {

							for (i = 0; i < data.length; i++) {
								html += "<div>";
								html += "<div><table class='table'><h6><strong>"
										+ data[i].writer
										+ "</strong>"
										+ "&nbsp&nbsp"
										+ data[i].regdate
										+ "<button type='button' class='comment-delete' onClick='delete_comment("
										+ data[i].c_code
										+ ")'>삭제</button>"
										+ "</h6>";
								html += data[i].comment + "<tr><td></td></tr>";
								html += "</table></div>";
								html += "</div>";
							}

						} else {

							html += "<div>";
							html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
							html += "</table></div>";
							html += "</div>";

						}

						$("#cCnt").html(cCnt);
						$("#commentList").html(html);
					},
					error : function(request, status, error) {

					}

				});

	}
</script>
