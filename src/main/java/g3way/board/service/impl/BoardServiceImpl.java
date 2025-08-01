package g3way.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import g3way.board.mapper.BoardMapper;
import g3way.board.service.BoardService;
import g3way.board.vo.BoardVo;
import g3way.board.vo.CmntVo;
import g3way.board.vo.PageVo;
import g3way.board.vo.UserVo;

@Service
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService{
	
	@Autowired 
	private BoardMapper boardMapper;
	
	//@Resource(name = "BoardMapper")
	//BoardMapper boardMapper;
	
	// private static final int PAGELIMIT = 10; // 한 페이지에 보여줄 게시물의 수
	private static final int BLOCKLIMIT = 10; // 하단에 보여줄 페이지 수
	
	private int calPageStart (int page, int pageLimit) {
		return (page - 1) * pageLimit + 1;
	}
	
	private PageVo creatPageVo(int page, int totalCount, int pageLimit) {
		int startPage = (int) (Math.ceil((double) page / BLOCKLIMIT) - 1) * BLOCKLIMIT + 1;
		int maxPage = (int) (Math.ceil((double) totalCount / pageLimit));
		int endPage = startPage + BLOCKLIMIT - 1;
		if (endPage>maxPage) 
			endPage = maxPage;
		PageVo pageVo = new PageVo();
		pageVo.setPage(page);
		pageVo.setStartPage(startPage);
		pageVo.setMaxPage(maxPage);
		pageVo.setEndPage(endPage);
		pageVo.setPageLimit(pageLimit);
		
		return pageVo;
	}
	
	@Override
	public List<BoardVo> boardList(int page, int pageLimit, String filter) throws Exception {
		int pageStart = calPageStart(page, pageLimit);
		return boardMapper.boardList(pageStart, pageLimit, filter);
	} 
	
	@Override
	public PageVo pagingParam(int page, int pageLimit) throws Exception {
		int boardCount = boardMapper.boardCount();
		PageVo pageVo = creatPageVo(page, boardCount, pageLimit);
		return pageVo;
	}
	
	@Override
	public List<BoardVo> searchBoardList(String searchBy, String searchCn, int page, int pageLimit, String filter) throws Exception {
		int pageStart = calPageStart(page, pageLimit);
		return boardMapper.searchBoardList(searchBy, searchCn, pageStart, pageLimit, filter); 
	}
	
	@Override
	public PageVo searchPagingParam(String searchBy, String searchCn,int page, int pageLimit) throws Exception {
		int boardCount = boardMapper.searchBoardCount(searchBy, searchCn);
		PageVo pageVo = creatPageVo(page, boardCount, pageLimit);
		return pageVo;
	}
	
	@Override
	public BoardVo getBoardInfo(int bbsSn) throws Exception {
		return boardMapper.getBoardInfo(bbsSn);
	}
	
	@Override
	public CmntVo getCommentInfo(String cmntNo) throws Exception {
		return boardMapper.getCommentInfo(cmntNo);
	}
	
	@Override
	public List<CmntVo> commentList(int bbsSn) throws Exception {
		return boardMapper.commentList(bbsSn); 
	}
	
	@Override
	public int insertComment(CmntVo commentVo) throws Exception {
		return boardMapper.insertComment(commentVo);
	}
	
	@Override
	public int deleteComment(String cmntNo) throws Exception {
		return boardMapper.deleteComment(cmntNo);
	}
	
	@Override
	public int updateComment(String cmntNo, String cmntCn) throws Exception {
		return boardMapper.updateComment(cmntNo, cmntCn);
	}
	
	@Override
	public int insertUpCmnt(CmntVo commentVo) throws Exception{
		return boardMapper.insertUpCmnt(commentVo);
	}
	
	@Override
	public int updateBbsInqCnt(int bbsSn) throws Exception {
		return boardMapper.updateBbsInqCnt(bbsSn);
	}
	
	@Override
	public int deleteBoard(int bbsSn) throws Exception {
		return boardMapper.deleteBoard(bbsSn);
	}
	
	@Override
	public int updateBoard(BoardVo boardVo) throws Exception {
		return boardMapper.updateBoard(boardVo);
	}
	
	@Override
	public int insertBoard(BoardVo boardVo) throws Exception {
		int result = boardMapper.insertBoard(boardVo);
		return result;
	}
	
	@Override
	public UserVo validateUser(UserVo userVo) throws Exception {
		UserVo user = boardMapper.selectUser(userVo);
		
		if (user != null && user.getUserPw().equals(userVo.getUserPw())) {
			return user;
		}
		return null;
	}
	
	@Override
	public int updateFileToNull(int bbsSn) throws Exception {
		return boardMapper.updateFileToNull(bbsSn);
	}
	
	@Override
	public int boardCount() throws Exception {
		return boardMapper.boardCount();
	}
	
	@Override
	public int searchBoardCount(String searchBy, String searchCn) throws Exception {
		return boardMapper.searchBoardCount(searchBy, searchCn);
	}
	
}
