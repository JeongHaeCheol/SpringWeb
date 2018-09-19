package my.custom.project.service;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Service;

import my.custom.project.model.Board;


@Service
public class BoardService {

	public List<Board> listAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public void create(Board board) {
		// TODO Auto-generated method stub
		
	}

	public void increaseViewCnt(int bno, HttpSession session) {
		// TODO Auto-generated method stub
		
	}

	public Board read(int bno) {
		// TODO Auto-generated method stub
		return null;
	}

	public void update(@Valid Board board) {
		// TODO Auto-generated method stub
		
	}

	public void delete(int bno) {
		// TODO Auto-generated method stub
		
	}

}
