package g3way.stat.service;

import g3way.stat.vo.SidoVo;
import g3way.stat.vo.UmdVo;

public interface StatService {

	public UmdVo getEmdInfoByPoint(double lat, double lng) throws Exception;
	
	public SidoVo sidoList() throws Exception;
}
