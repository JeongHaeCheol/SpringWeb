package my.custom.project.dao;

import java.util.List;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import javax.validation.Valid;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import my.custom.project.controller.LoginController;
import my.custom.project.model.Board;

@Repository
@Transactional
public class BoardDao {

	private static final Logger logger = LoggerFactory.getLogger(BoardDao.class);

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
		List<Board> boardList = session.createQuery("from Board order by bno DESC,  regdate DESC").list();
		return boardList;
	}
	
	public List<Board> selectPage(int startPage, int pageSize) {
		Session session = sessionFactory.getCurrentSession();
		List<Board> boardList = session.createQuery("from Board order by bno DESC,  regdate DESC").setFirstResult(startPage).setMaxResults(pageSize).list();
		return boardList;
	}
	
	

	public void update(Board board) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(board);
		session.flush();

	}

	public Board read(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board board = (Board) session.get(Board.class, bno);
		return board;
	}

	public void delete(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board board = session.get(Board.class, bno);
		session.delete(board);
		session.flush();
	}
	
	
	public Board getNextBoard(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board nextBoard = null;

		try {
			nextBoard = (Board) session.createQuery("from Board where  bno > " + bno + " order by bno ASC")
					.setMaxResults(1).getSingleResult();
		} catch (NoResultException noResult) {
			logger.info("Query getNextBoard in BoardDao : no result");
		} 
			return nextBoard;
		
	}

	public Board getPreBoard(int bno) {
		Session session = sessionFactory.getCurrentSession();
		Board preBoard = null;

		try {
			preBoard = (Board) session.createQuery("from Board where  bno < " + bno + " order by bno DESC")
					.setMaxResults(1).getSingleResult();
		} catch (NoResultException noResult) {
			logger.info("Query getPreBno in BoardDao : no result");
		} 
			return preBoard;
		
	}

}
