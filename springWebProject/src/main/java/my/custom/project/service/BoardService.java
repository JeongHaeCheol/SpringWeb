package my.custom.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.BoardDao;
import my.custom.project.model.Board;


@Service
public class BoardService {
	
	
	@Autowired
	private BoardDao boardDao;

	
	public Board getNextBoard(int bno) {
		return boardDao.getNextBoard(bno);
	}
	
	public Board getPreBoard(int bno) {
		return boardDao.getPreBoard(bno);
	}

	public List<Board> listAll() {
		return boardDao.listAll();
	}
	
	public List<Board> selectPage(int startPage, int pageSize) {
		return boardDao.selectPage(startPage, pageSize);
	}

	public void create(Board board) {
		convertToHTML(board);
		boardDao.create(board);
	}
	
	public Board read(int bno) {
		return boardDao.read(bno);
	}
	
	public Board readToReversedHTML(int bno) {
		Board board = this.read(bno);
		reverseToHTML(board);
		return board;
	}

	public void update(Board board) {
		Board originBoard = boardDao.read(board.getBno());
		originBoard.setTitle(board.getTitle());
		originBoard.setContent(board.getContent());
		convertToHTML(originBoard);

		boardDao.update(originBoard);
	}

	public void delete(int bno) {
		boardDao.delete(bno);
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


	
	
	public void convertToHTML(Board board) {
		String title = board.getTitle();
		String content = board.getContent();

		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");
		
		title = title.replace(" ", "&nbsp;&nbsp;");
		
		content = content.replace("\n", "<br>");
		board.setTitle(title);
		board.setContent(content);
	}
	
	public void reverseToHTML(Board board) {
		String title = board.getTitle();
		String content = board.getContent();
		
		title = title.replace("&lt", "<");
		title = title.replace("&gt", ">");
	
		title = title.replace("&nbsp;&nbsp;", " ");

		content = content.replace("<br>", "\n");
		board.setTitle(title);
		board.setContent(content);
	}

}
