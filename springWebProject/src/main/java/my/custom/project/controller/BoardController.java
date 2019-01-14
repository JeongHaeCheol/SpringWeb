package my.custom.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

import my.custom.project.commons.PageConfig;
import my.custom.project.model.Board;
import my.custom.project.model.Comment;
import my.custom.project.service.BoardService;
import my.custom.project.service.CommentService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	BoardService boardService;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@Autowired
	CommentService commentService;

	// 1. 게시글 목록
	@RequestMapping("list")
	public String list(Model model, @RequestParam(defaultValue = "1") int curPage) throws Exception {

		List<Board> list = boardService.listAll();
		int listCnt = list.size();
		PageConfig pageConfig = new PageConfig(listCnt, curPage);
		List<Board> curList = boardService.selectPage(pageConfig.getStartIndex(), pageConfig.getPageSize());

		logger.info("현재페이지, 페이지 사이즈 : " + pageConfig.getStartIndex() + " / " + pageConfig.getPageSize());
		model.addAttribute("curList", curList);
		model.addAttribute("listCnt", listCnt);
		model.addAttribute("pageConfig", pageConfig);

		return "board/list";
	}

	// 2. 게시글 작성
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write(Board board, Model model) {

		return "board/write"; // board 폴더 밑의 write.jsp
	}

	// 2.2 게시글 처리
	// Parameter순서 ! Multiple Model Attribute를 할 경우가 있기 때문에 BindingResult는 연결할 모델의
	// 바로 뒤에 와야한다.
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writePost(@Valid Board board, BindingResult result, Model model) {

		if (result.hasErrors()) {
			return "board/write";
		}

		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();
		board.setWriter(name);

		MultipartFile imageFile = board.getImageFile();

		String savedName = "temp";
		try {
			savedName = uploadFile(imageFile.getOriginalFilename(), imageFile.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		board.setImageFilename(savedName);

		boardService.create(board);

		return "redirect:list";
		// redirect를 걸어야 컨트롤러를 거치기 때문에 컨트롤러의 수행작업을 다시 수행할 수 있다.
	}

	private String uploadFile(String originalName, byte[] fileData) throws Exception {

		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;

		logger.info("Board 컨트롤러에서 파일 생성 출력2 " + savedName);
		File target = new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;

	}

	// 3. 글 상세내용 조회, 조회수 처리
	@RequestMapping(value = "view", method = RequestMethod.GET)
	public String view(@RequestParam int bno, HttpSession session, Model model) throws Exception {

		boardService.increaseViewCnt(bno, session);
		Board board = boardService.read(bno);
		Board nextBoard = boardService.getNextBoard(bno);
		Board preBoard = boardService.getPreBoard(bno);

		model.addAttribute("board", board);

		try {
			logger.info("nextBno, preBno in BoardController view method : " + nextBoard.getBno() + " / "
					+ preBoard.getBno());
		} catch (NullPointerException e) {
			logger.info("Next/Pre Board log error in BoardController view method");
		}

		if (nextBoard != null) {
			model.addAttribute("nextBoard", nextBoard);
		}

		if (preBoard != null) {
			model.addAttribute("preBoard", preBoard);
		}

		/*
		 * security에서 intercept 없이 구현할 경우 이 방법 사용 비회원은 authentication.getPrincipal()이
		 * "anonymousUser"를 리턴한다. login.jsp에서 modelAttribute로 user를 요구하기 때문에 user 추가
		 * 
		 * Authentication authentication =
		 * SecurityContextHolder.getContext().getAuthentication();
		 * 
		 * if(authentication.getPrincipal().equals("anonymousUser")) {
		 * model.addAttribute("user", new my.custom.project.model.User()); return
		 * "login"; }
		 */

		User securityUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = securityUser.getUsername();

		if (name.equals(board.getWriter())) {
			model.addAttribute("approval", "OK");
		}

		return "board/view";
	}

	// 4. 게시글 수정
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update(@RequestParam int bno, Model model) throws Exception {

		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();
		Board board = boardService.readToReversedHTML(bno);

		if (!name.equals(board.getWriter())) {
			return "redirect:list";
		}

		model.addAttribute("board", board);

		return "board/update";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updatePost(@Valid Board board, BindingResult result, HttpServletRequest request) throws Exception {

		if (result.hasErrors()) {
			logger.warn("Form data has some errors");
			List<ObjectError> errors = result.getAllErrors();
			for (ObjectError error : errors) {
				logger.warn(error.getDefaultMessage());
			}

			// jsp 뷰에서 modelAttribute에 설정된 "board"와 이메소드의 매개변수 board가 연결되어 입력값 유지가 가능
			// Parameter와 Attribute 값이 그대로 유지되기 때문에 board/update를 리턴하면 된다.
			// View 이름과 연결되기 때문에 "board/update" + ?bno=board.getBno(); 같은 실수는 하지 말자
			return "board/update";
		}

		MultipartFile imageFile = board.getImageFile();
		
		String tempName = board.getImageFile().getOriginalFilename();
		String[] array = tempName.split("\\\\");
		
		String fileName = array[array.length - 1];
		
		logger.info(" 파일명 결과 !!! : " + fileName );

		String savedName = "temp";
		try {
			savedName = uploadFile(fileName, imageFile.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		board.setImageFilename(savedName);
		
		logger.info("업데이트 전 결과 : "  + board.getImageFilename());

		boardService.update(board);

		return "redirect:view?bno=" + board.getBno();
	}

	// 5. 게시글 삭제
	@RequestMapping("delete")
	public String delete(@RequestParam int bno) throws Exception {

		Board board = boardService.read(bno);

		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();

		if (!name.equals(board.getWriter())) {
			return "redirect:list";
		}

		boardService.delete(bno);
		return "redirect:list";
	}

	@RequestMapping(value = "commentList", produces = "application/json; charset=utf8")
	@ResponseBody
	public ResponseEntity ajax_commentList(int bno, HttpServletRequest request) throws Exception {

		// logger.warn("test bno = " + bno);
		// 위의 로그 실행시 primitive타입을 형변환 하려 했다고 에러 발생

		HttpHeaders responseHeaders = new HttpHeaders();
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();

		// 해당 게시물 댓글
		List<Comment> commentList = commentService.getCommentListByBno(bno);

		if (commentList.size() > 0) {
			for (int i = 0; i < commentList.size(); i++) {
				HashMap hm = new HashMap();
				hm.put("c_code", commentList.get(i).getC_code());
				hm.put("comment", commentList.get(i).getComment());
				hm.put("regdate", commentList.get(i).getRegdate());
				hm.put("writer", commentList.get(i).getWriter());

				hmlist.add(hm);
			}

		}

		JSONArray json = new JSONArray(hmlist);
		return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);

	}

	@RequestMapping(value = "addComment", method = RequestMethod.POST)
	@ResponseBody
	public String ajax_addComment(String comment, int b_code) throws Exception {

		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();
		logger.info("comment check!! : " + comment);
		try {
			Comment cmt = new Comment();
			cmt.setWriter(name);
			cmt.setB_code(b_code);
			cmt.setComment(comment);
			commentService.create(cmt);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "success";
	}

}
