package my.custom.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.CommentDao;
import my.custom.project.model.Comment;


@Service
public class CommentService {

	@Autowired
	private CommentDao commentDao;
	
	public void create(Comment comment) {
		commentDao.create(comment);
	}
	
	public List<Comment> getCommentListByBno(int bno) {
		return commentDao.getCommentListByBno(bno);
	}

}
