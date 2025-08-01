package g3way.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import g3way.board.vo.BoardVo;
import g3way.board.vo.CmntVo;
import g3way.board.vo.UserVo;

@Mapper("boardMapper")
@Repository
public interface BoardMapper {
	
	public List<BoardVo> boardList(@Param("pageStart") int pageStart, @Param("pageLimit") int pageLimit, @Param("filter")String filter) throws Exception;
	
	public int boardCount() throws Exception;
	
	public List<BoardVo> searchBoardList(
	@Param("searchBy")String searchBy, @Param("searchCn")String searchCn
	, @Param("pageStart")int pageStart, @Param("pageLimit") int pageLimit
	, @Param("filter")String filter) throws Exception;
	
	public int searchBoardCount(@Param("searchBy")String searchBy, @Param("searchCn")String searchCn) throws Exception;
	
	public BoardVo getBoardInfo(int bbsSn) throws Exception;
	
	public CmntVo getCommentInfo(String cmntNo) throws Exception;
	
	public List<CmntVo> commentList(int bbsSn) throws Exception;
	
	public int insertComment(CmntVo commentVo) throws Exception;
	
	public int deleteComment(String cmntNo) throws Exception;
	
	public int updateComment(@Param("cmntNo")String cmntNo, @Param("cmntCn")String cmntCn) throws Exception;
	
	public int insertUpCmnt(CmntVo commentVo) throws Exception;
	
	public int updateBbsInqCnt(int bbsSn) throws Exception;
	
	public int deleteBoard(int bbsSn) throws Exception;
	
	public int updateBoard(BoardVo boardVo) throws Exception;
	
	public int insertBoard(BoardVo boardVo) throws Exception;
	
	public UserVo selectUser(UserVo userVo) throws Exception;
	
	public int updateFileToNull(int bbsSn) throws Exception;
}
