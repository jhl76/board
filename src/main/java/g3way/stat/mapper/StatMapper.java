package g3way.stat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import g3way.stat.vo.GunguVo;
import g3way.stat.vo.SidoVo;
import g3way.stat.vo.UmdVo;

@Mapper("statMapper")
@Repository
public interface StatMapper {
	
	public UmdVo getEmdInfoByPoint(@Param("lat") double lat, @Param("lng") double lng) throws Exception;
	
	public SidoVo sidoList() throws Exception;
	
	public List<GunguVo> gunguList() throws Exception;
	
}
