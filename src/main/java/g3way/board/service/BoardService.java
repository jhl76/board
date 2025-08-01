package g3way.board.service;

import java.util.List;

import g3way.board.vo.BoardVo;
import g3way.board.vo.CmntVo;
import g3way.board.vo.PageVo;
import g3way.board.vo.UserVo;

public interface BoardService {
	
	public List<BoardVo> boardList(int page, int pageLimit, String filter) throws Exception;
	
	public List<BoardVo> searchBoardList(String searchBy, String searchCn, int page, int pageLimit, String filter) throws Exception;
	
	public PageVo searchPagingParam(String searchBy, String searchCn,int page, int pageLimit) throws Exception;
	
	public PageVo pagingParam(int page, int pageLimit) throws Exception;
	
	public BoardVo getBoardInfo(int bbsSn) throws Exception;
	
	public CmntVo getCommentInfo(String cmntNo) throws Exception;
	
	public List<CmntVo> commentList(int bbsSn) throws Exception;
	
	public int insertComment(CmntVo commentVo) throws Exception;
	
	public int deleteComment(String cmntNo) throws Exception;
	
	public int updateComment(String cmntNo, String cmntCn) throws Exception;
	
	public int insertUpCmnt(CmntVo commentVo) throws Exception;
	
	public int updateBbsInqCnt(int bbsSn) throws Exception;
	
	public int deleteBoard(int bbsSn) throws Exception;
	
	public int updateBoard(BoardVo boardVo) throws Exception;
	
	public int insertBoard(BoardVo boardVo) throws Exception;
	
	public UserVo validateUser(UserVo userVo) throws Exception;
	
	public int updateFileToNull(int bbsSn) throws Exception;
	
	public int boardCount() throws Exception;
	
	public int searchBoardCount(String searchBy, String searchCn) throws Exception;
}
