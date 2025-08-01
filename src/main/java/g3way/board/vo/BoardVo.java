package g3way.board.vo;

import org.springframework.web.multipart.MultipartFile;

public class BoardVo {
	
	private String bbsSn;
	private String bbsTtl;
	private String bbsCn;
	private String bbsInqCnt;
	private String rmrkCn;
	private String useYn;
	private String wrtDt;
	private String cntnIpAddr;
	private String updtDt;
	private String userId;
	private String rowNum;
	
	// 파일 입출력
	private String fileNm;
	private String orgnlFileNm;
	private MultipartFile uploadFile;
	
	private String cmntCount;
	
	public String getBbsSn() {
		return bbsSn;
	}
	public void setBbsSn(String bbsSn) {
		this.bbsSn = bbsSn;
	}
	public String getBbsTtl() {
		return bbsTtl;
	}
	public void setBbsTtl(String bbsTtl) {
		this.bbsTtl = bbsTtl;
	}
	public String getBbsCn() {
		return bbsCn;
	}
	public void setBbsCn(String bbsCn) {
		this.bbsCn = bbsCn;
	}
	public String getBbsInqCnt() {
		return bbsInqCnt;
	}
	public void setBbsInqCnt(String bbsInqCnt) {
		this.bbsInqCnt = bbsInqCnt;
	}
	public String getRmrkCn() {
		return rmrkCn;
	}
	public void setRmrkCn(String rmrkCn) {
		this.rmrkCn = rmrkCn;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getWrtDt() {
		return wrtDt;
	}
	public void setWrtDt(String wrtDt) {
		this.wrtDt = wrtDt;
	}
	public String getCntnIpAddr() {
		return cntnIpAddr;
	}
	public void setCntnIpAddr(String cntnIpAddr) {
		this.cntnIpAddr = cntnIpAddr;
	}
	public String getUpdtDt() {
		return updtDt;
	}
	public void setUpdtDt(String updtDt) {
		this.updtDt = updtDt;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRowNum() {
		return rowNum;
	}
	public void setRowNum(String rowNum) {
		this.rowNum = rowNum;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getOrgnlFileNm() {
		return orgnlFileNm;
	}
	public void setOrgnlFileNm(String orgnlFileNm) {
		this.orgnlFileNm = orgnlFileNm;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getCmntCount() {
		return cmntCount;
	}
	public void setCmntCount(String cmntCount) {
		this.cmntCount = cmntCount;
	}
	
	

}
