package my.custom.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.BoardDao;
import my.custom.project.model.Board;


@Service
public class BoardService {
	
	
	@Autowired
	private BoardDao boardDao;
	

	public List<Board> listAll() {
		return boardDao.listAll();
	}
	
	public Board getArticle(int bno) {
		return boardDao.getArticle(bno);
	}

	public void create(Board board) {
		// 수정 필요 !!!!
		String title = board.getTitle();
		String content = board.getContent();
		String writer = board.getWriter();
		
		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");
		
		writer = writer.replace("<", "&lt");
		writer = writer.replace(">", "&gt");
		
		title = title.replace(" ", "&nbsp;&nbsp;");
		writer = writer.replace(" ", "&nbsp;&nbsp;");
		
		content = content.replace("\n", "<br>");
		board.setTitle(title);
		board.setContent(content);
		board.setWriter(writer);
		
		boardDao.create(board);
	}

	public void increaseViewCnt(int bno, HttpSession session) {
		long update_time = 0;
		
		if(session.getAttribute("update_time_"+ bno) != null) {
			update_time = (long)session.getAttribute("update_time_"+bno);
		}
		
		long current_time= System.currentTimeMillis();
		
		if(current_time - update_time > 5 * 1000) {
			boardDao.increaseViewcnt(bno);
			
			session.setAttribute("update_time_" + bno, current_time);
		}
		
	}

	public Board read(int bno) {
		return boardDao.read(bno);
	}

	public void update(Board board) {
		boardDao.update(board);
	}

	public void delete(int bno) {
		boardDao.delete(bno);
	}

}
