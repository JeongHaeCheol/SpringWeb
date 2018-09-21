package my.custom.project.dao;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import javax.validation.Valid;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import my.custom.project.model.Board;

@Repository
@Transactional
public class BoardDao {
	
	@Autowired
	private SessionFactory sessionFactory;
	

	public void create(Board board) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(board);
		session.flush();	
	}

	public void increaseViewcnt(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board board = (Board) session.get(Board.class, bno);
		board.setViewcnt(board.getViewcnt() + 1);
		session.saveOrUpdate(board);
		session.flush();
	}

	public List<Board> listAll() {
		Session session = sessionFactory.getCurrentSession();
		List<Board> boardList = session.createQuery("from Board").list();
		return boardList;
	}

	public void update(Board board) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(board);
		session.flush();
		
	}

	public Board read(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board board = (Board)session.get(Board.class, bno);
		return board;
	}

	public void delete(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board board = session.get(Board.class, bno);
		session.delete(board);
		session.flush();
	}


}
