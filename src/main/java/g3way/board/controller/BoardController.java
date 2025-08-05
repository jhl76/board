package g3way.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import g3way.board.service.BoardService;
import g3way.board.vo.BoardVo;
import g3way.board.vo.CmntVo;
import g3way.board.vo.PageVo;
import g3way.board.vo.UserVo;

@Controller("BoardController")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/loginPage.do")
	public String showLoginPage() {
		return "loginPage";
	}
	
	/*
	@RequestMapping(value = "/login.do", method = RequestMethod.POST) 
	public String login(UserVo userVo, Model model, HttpSession session) throws Exception {
		UserVo user = boardService.validateUser(userVo);
		if (user != null) 
		{		  
			session.setAttribute("user", user);
			return "redirect:/home.do";
		}
		else 
		{
			model.addAttribute("errorMessage", "사용자 정보가 일치하지 않습니다.");
			return "sample/loginPage";
		}
		 
	}
	*/
	 
	/*
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/loginPage.do";
	}
	*/
	
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Model model, HttpSession session
										, @RequestParam(value = "page" , required = false, defaultValue = "1") int page
										, @RequestParam(value = "searchBy", required = false) String searchBy
										, @RequestParam(value = "searchCn", required = false) String searchCn
										, @RequestParam(value = "pageLimit", required = false, defaultValue = "9") int pageLimit
										, @RequestParam(value = "filter", required = false, defaultValue = "fast") String filter) throws Exception
	{
		System.out.println("searchBy : " + searchBy);
		System.out.println("searchCn : " + searchCn);
		UserVo user = (UserVo) session.getAttribute("user");
		System.out.println(" user.getAuthrtCd(): " + user.getAuthrtCd());
	    List<BoardVo> boardList = null;
		if (user != null) {
			PageVo pageVo;
			if (searchBy != null && searchCn != null && !searchCn.trim().isEmpty()) {
				boardList = boardService.searchBoardList(searchBy, searchCn, page, pageLimit, filter);
				pageVo = boardService.searchPagingParam(searchBy, searchCn,page, pageLimit);
				int searchBoardCount = boardService.searchBoardCount(searchBy, searchCn);
				model.addAttribute("paging", pageVo);
				model.addAttribute("searchBy", searchBy);
			    model.addAttribute("searchCn", searchCn);
			    model.addAttribute("searchBoardCount", searchBoardCount);
			} else {
				boardList = boardService.boardList(page, pageLimit, filter);
				pageVo = boardService.pagingParam(page, pageLimit);
				int boardCount = boardService.boardCount();
				model.addAttribute("paging", pageVo);
				model.addAttribute("boardCount", boardCount);
			}
		}
		model.addAttribute("pageLimit", pageLimit);
		model.addAttribute("boardList", boardList);
		model.addAttribute("user", user);
		model.addAttribute("filter", filter);
		return "home";
	}
	
	@RequestMapping(value = "/boardDetailPage.do", method = RequestMethod.GET)
	public String boardDeatilPage(@RequestParam int bbsSn, Model model, HttpSession session) throws Exception {
		UserVo user = (UserVo) session.getAttribute("user");
		BoardVo boardVo = boardService.getBoardInfo(bbsSn);
		String bbsCn = boardVo.getBbsCn().replaceAll("\n","<br/>");
		boardVo.setBbsCn(bbsCn);
		boardService.updateBbsInqCnt(bbsSn);
		List<CmntVo> commentList = boardService.commentList(bbsSn);
		model.addAttribute("user", user);
		model.addAttribute("boardVo", boardVo);
		model.addAttribute("commentList", commentList);
		return "boardDetailPage";
	}
	
	
	@RequestMapping(value = "/insertComment.do", method = RequestMethod.POST) 
	public String insertComment(CmntVo commentVo) throws Exception {
		int result = boardService.insertComment(commentVo); 
		if (result>0) {
			return "redirect:/boardDetailPage.do?bbsSn="+Integer.parseInt(commentVo.getBbsSn());
		}else {
			return "errorPage";
		}
		
	}
	
	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.GET) 
	public String deleteComment(String cmntNo, int bbsSn) throws Exception {
		int result = boardService.deleteComment(cmntNo);
		if (result>0) {
			return "redirect:/boardDetailPage.do?bbsSn="+bbsSn;
		}else {
			return "errorPage";
		}
	}
	
	@RequestMapping(value = "/updateUserComment.do", method = RequestMethod.POST)
	public ModelAndView updateUserComment(@RequestParam("cmntNo")String cmntNo, 
																						  @RequestParam("cmntCn")String cmntCn
																						  ) throws Exception
	{
		System.out.println("cmntNo : " + cmntNo);
		System.out.println("cmntCn : " + cmntCn);
		HashMap<String, String> resultMap = new HashMap<String, String>();
		try {
			int result = boardService.updateComment(cmntNo, cmntCn);
			CmntVo commentVo = boardService.getCommentInfo(cmntNo);
			if (result > 0) {
				resultMap.put("status", "success");
	            resultMap.put("cmntCn", cmntCn);  
	            resultMap.put("updtDt", commentVo.getUpdtDt());  
			}else {
				resultMap.put("status", "error");
			}
		} catch (Exception e) {
			 e.printStackTrace();
			 resultMap.put("status", "error");
		}
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("resultMap", resultMap);
		return mav;
	}
	
	@RequestMapping(value = "/insertUpCmnt.do", method = RequestMethod.GET)
	public String insertUpCmnt(@ModelAttribute CmntVo commentVo) throws Exception 
	{
		String cmntNo = commentVo.getCmntNo();
		String cmntCn = commentVo.getCmntCn();
		String bbsSn = commentVo.getBbsSn();
		String userId = commentVo.getUserId();
		System.out.println("cmntNo:"+cmntNo);
		System.out.println("cmntCn:"+cmntCn);
		System.out.println("bbsSn:"+bbsSn);
		System.out.println("userId:"+userId);
		
		int result = boardService.insertUpCmnt(commentVo);
		if (result > 0) {
			return "redirect:/boardDetailPage.do?bbsSn="+Integer.parseInt(bbsSn);
		}else {
			return "errorPage";
		}
	}
	
	@RequestMapping(value = "/updateAdminComment.do", method = RequestMethod.POST)
	public ModelAndView updateAdminComment(@RequestParam("cmntNo")String cmntNo, @RequestParam("cmntCn")String cmntCn) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = boardService.updateComment(cmntNo, cmntCn);
			CmntVo commentVo = boardService.getCommentInfo(cmntNo);
			if (result>0) {
				resultMap.put("status", "success");
				resultMap.put("cmntCn", cmntCn);
				resultMap.put("updtDt", commentVo.getUpdtDt()); 
			}else {
				resultMap.put("status", "error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("status", "error");
		}
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("resultMap", resultMap);
		return mav;
	}
	
	@RequestMapping(value = "/deleteBoard.do", method = RequestMethod.GET)
	public String boardDelete(@RequestParam int bbsSn) throws Exception {
		int result = boardService.deleteBoard(bbsSn);
		if (result > 0) {
			return "redirect:/home.do";
		}
		return "errorPage";
	}
	
	@RequestMapping(value = "/adminBoardUpdatePage.do", method = RequestMethod.GET)
	public String boardUpdatePage(@RequestParam int bbsSn, Model model) throws Exception {
		BoardVo boardVo = boardService.getBoardInfo(bbsSn);
		model.addAttribute("boardVo", boardVo);
		return "boardUpdatePage";
	}
	
	@RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
	public String updateBoard(BoardVo boardVo) throws Exception {
		// 파일 업로드 처리
		String fileName = null;
		//String fileNm = null;
		MultipartFile uploadFile = boardVo.getUploadFile();
		String originalFileName = "";
		System.out.println("uploadFile.isEmpty(): " + uploadFile.isEmpty());
		if (!uploadFile.isEmpty()) {
			originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);
			String baseName = FilenameUtils.getBaseName(originalFileName);
			System.out.println("originalFileName : " + originalFileName);
			System.out.println("ext : " + ext);
			System.out.println("baseName : " + baseName);
			
			/*
			UUID uuid = UUID.randomUUID();
			fileNm = uuid + "."+ ext;
			*/
			
			File dir = new File("D:\\upload\\");
			if (!dir.exists()) {
			    dir.mkdirs();
			}
			
			fileName = baseName + "." + ext;
			File targetFile = new File(dir, fileName);
			int count = 1;
			
			while (targetFile.exists()) {
				fileName = baseName  + "_" + count + "." + ext;
				targetFile = new File(dir, fileName);
				count++;
			}
			
			// 파일 저장
			uploadFile.transferTo(targetFile);
		}
		boardVo.setFileNm(fileName);
		boardVo.setOrgnlFileNm(originalFileName);
		
		System.out.println("fileName : " + boardVo.getFileNm());
		System.out.println("originalFileName : " + boardVo.getOrgnlFileNm());
		
		int result = boardService.updateBoard(boardVo);
		String viewPage = "";
		if (result > 0) 
		{
			viewPage = "redirect:/boardDetailPage.do?bbsSn="+boardVo.getBbsSn();
		}
		else 
		{
			viewPage = "errorPage";
		}
		return viewPage;
	}
	
	
	@RequestMapping("/adminBoardInsertPage.do")
	public String showRegisterPage() {
		return "boardInsertPage";
	}
	
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
	public String submitPost(BoardVo boardVo, HttpSession session) throws Exception {
		UserVo user = (UserVo) session.getAttribute("user");
		boardVo.setUserId(user.getUserId());
		
		// 파일 업로드 처리
		String fileName = null;
		//String fileNm = null;
		MultipartFile uploadFile = boardVo.getUploadFile();
		String originalFileName = null;
		System.out.println("uploadFile.isEmpty(): " + uploadFile.isEmpty());
		if (!uploadFile.isEmpty()) {
			originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);
			String baseName = FilenameUtils.getBaseName(originalFileName);
			System.out.println("originalFileName : " + originalFileName);
			System.out.println("ext : " + ext);
			System.out.println("baseName : " + baseName);
			
			/*
			UUID uuid = UUID.randomUUID();
			fileNm = uuid + "."+ ext;
			*/
			
			File dir = new File("D:\\upload\\");
			if (!dir.exists()) {
			    dir.mkdirs();
			}
			
			fileName = baseName + "." + ext;
			File targetFile = new File(dir, fileName);
			int count = 1;
			
			while (targetFile.exists()) {
				fileName = baseName  + "_" + count + "." + ext;
				targetFile = new File(dir, fileName);
				count++;
			}
			
			// 파일 저장
			uploadFile.transferTo(targetFile);
		}
		boardVo.setFileNm(fileName);
		boardVo.setOrgnlFileNm(originalFileName);
		
		System.out.println("fileName : " + boardVo.getFileNm());
		System.out.println("originalFileName : " + boardVo.getOrgnlFileNm());
		
		int result = boardService.insertBoard(boardVo);
		String viewPage = "";
		if (result > 0) 
		{
			viewPage = "redirect:/home.do";
		}
		else 
		{
			viewPage = "errorPage";
		}
		return viewPage;
	}
	
	@RequestMapping(value = "/fileDownload.do", method = RequestMethod.GET)
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String fileName = request.getParameter("fileNm");
		
		//시리얼 넘버(_숫자) 제거
	    String originalFileName = fileName.replaceAll("_\\d+(?=\\.)", "");
		
	    String realFileName = "D:\\upload\\" + fileName;
	    System.out.println("fileName: " + fileName);
	    System.out.println("realFileName: " + realFileName);
	    System.out.println("originalFileName: "+originalFileName);

	    File file = new File(realFileName);

	    try {
	        String encodedFileName;
	        String header = request.getHeader("User-Agent");
	        if (header.contains("MSIE") || header.contains("Trident") || header.contains("Chrome")) {
	            encodedFileName = URLEncoder.encode(originalFileName, "UTF-8").replaceAll("\\+", "%20");
	        } else {
	            encodedFileName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
	        }

	        String mimeType = Files.probeContentType(Paths.get(realFileName));
	        if (mimeType == null) {
	            mimeType = "application/octet-stream";
	        }
	        response.setContentType(mimeType);
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

	        try (OutputStream os = response.getOutputStream();
	             FileInputStream fis = new FileInputStream(file)) {
	            
	            byte[] buffer = new byte[8192];
	            int bytesRead;
	            while ((bytesRead = fis.read(buffer)) != -1) {
	                os.write(buffer, 0, bytesRead);
	            }
	            os.flush();
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	@RequestMapping(value = "/deleteFile.do", method = RequestMethod.POST)
	public String deleteFile(@RequestParam("bbsSn") int bbsSn) throws Exception{
		BoardVo boardVo = boardService.getBoardInfo(bbsSn);
		
		String fileName = boardVo.getFileNm();
		if (fileName != null && !fileName.isEmpty()) {
			// 실제 파일 삭제
			File file = new File("D:\\upload\\" + fileName);
			if (file.exists()) {
				boolean deleted = file.delete();
				if (deleted) {
					System.out.println("파일 삭제 성공");
				}else {
					System.out.println("파일 삭제 실패");
				}
			}
		}
		int result = boardService.updateFileToNull(bbsSn);
		if (result>0) {
			return "redirect:/boardDetailPage.do?bbsSn="+bbsSn;
		}else {
			return "errorPage";
		}
	}
	
	@RequestMapping(value = "/showImage.do", method = RequestMethod.GET)
	public void showImage(@RequestParam("fileNm") String fileNm, HttpServletResponse response) {
	    try {
	        File file = new File("D:\\upload\\" + fileNm); // 저장된 경로
	        String mimeType = Files.probeContentType(file.toPath());

	        response.setContentType(mimeType);
	        InputStream in = new FileInputStream(file);
	        FileCopyUtils.copy(in, response.getOutputStream());
	        in.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	@RequestMapping(value = "/accessDenied.do")
	public String accessDeniedPage() throws Exception {
		return "accessDeniedPage";
	}
	
}
