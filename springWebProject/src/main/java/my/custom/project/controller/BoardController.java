package my.custom.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import my.custom.project.model.Board;

import my.custom.project.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	BoardService boardService;

	// 1. 게시글 목록
	@RequestMapping("list")
	public String list(Model model) throws Exception {
		List<Board> list = boardService.listAll();
		model.addAttribute("list", list);
		return "board/list";
	}

	// 2. 게시글 작성
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write(Model model, Board board) {
		if(board == null) {
		board = new Board();
		}
		model.addAttribute("board",board);
		return "board/write"; // board 폴더 밑의 write.jsp
	}

	// 2.2 게시글 처리
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public RedirectView insert(Board board) throws Exception {
		
		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();
		board.setWriter(name);
		boardService.create(board);
		return new RedirectView("list"); // return "redirect:list";
		// redirect를 걸어야 컨트롤러를 거치기 때문에 컨트롤러의 수행작업을 다시 수행할 수 있다.
	}

	// 3. 글 상세내용 조회, 조회수 처리
	@RequestMapping(value = "view", method = RequestMethod.GET)
	public String view(@RequestParam int bno, HttpSession session, Model model) throws Exception {

		boardService.increaseViewCnt(bno, session);
		Board board = boardService.read(bno);
		model.addAttribute("board", board);

		return "board/view";
	}

	// 4. 게시글 수정
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public RedirectView update(@Valid Board board, BindingResult result, HttpServletRequest request) throws Exception {

		if (result.hasErrors()) {
			logger.info("Form data has some errors");
			List<ObjectError> errors = result.getAllErrors();
			for (ObjectError error : errors) {
				logger.info(error.getDefaultMessage());
			}
			
			//jsp 뷰에서 modelAttribute에 설정된 "board"와 이메소드의 매개변수 board가 연결되어 입력값 유지가 가능
			return new RedirectView("update");
		}

		boardService.update(board);

		return new RedirectView("view");
	}
	
	//5. 게시글 삭제
	@RequestMapping("delete")
	public RedirectView delete(@RequestParam int bno)throws Exception {
		boardService.delete(bno);
		return new RedirectView("list");
	}
}
