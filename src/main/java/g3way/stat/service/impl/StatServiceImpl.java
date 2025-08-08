package g3way.stat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import g3way.stat.mapper.StatMapper;
import g3way.stat.service.StatService;
import g3way.stat.vo.GunguVo;
import g3way.stat.vo.SggVo;
import g3way.stat.vo.SidoVo;
import g3way.stat.vo.UmdVo;

@Service
public class StatServiceImpl extends EgovAbstractServiceImpl implements StatService{
	
	@Autowired 
	private StatMapper statMapper;
	
	@Override
	public UmdVo getEmdInfoByPoint(double lat, double lng) throws Exception {
		return statMapper.getEmdInfoByPoint(lat, lng);
	}
	
	@Override
	public SidoVo sidoList() throws Exception {
		return statMapper.sidoList();
	}
	
	@Override
	public List<GunguVo> gunguList() throws Exception {
		return statMapper.gunguList();
	}
	
	@Override
	public List<SggVo> sggList() throws Exception {
		return statMapper.sggList();
	}
	
	@Override
	public List<String> getUmdListBySgg(String sggNm) throws Exception {
		return statMapper.getUmdListBySgg(sggNm);
	}
	
	@Override
	public SggVo getSggStats(String sggNm) throws Exception {
		return statMapper.getSggStats(sggNm);
	}
	
}
