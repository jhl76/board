package g3way.stat.service;

import java.util.List;

import g3way.stat.vo.GunguVo;
import g3way.stat.vo.SggVo;
import g3way.stat.vo.SidoVo;
import g3way.stat.vo.UmdVo;

public interface StatService {

	public UmdVo getEmdInfoByPoint(double lat, double lng) throws Exception;
	
	public SidoVo sidoList() throws Exception;
	
	public List<GunguVo> gunguList() throws Exception;
	
	public List<SggVo> sggList() throws Exception;
	
	public List<String> getUmdListBySgg(String sggNm) throws Exception;
	
	public SggVo getSggStats(String sggNm) throws Exception;
}
