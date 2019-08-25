package com.team.house.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.team.house.entity.District;
import com.team.house.entity.DistrictExample;
import com.team.house.mapper.DistrictMapper;
import com.team.house.service.DistrictService;
import com.team.house.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class DistricServiceImpl implements DistrictService {

    @Autowired
    private DistrictMapper districtMapper;

    /**
     * 分页查询所有区域
     * @param page 分页的条件 page页码  rows页大小
     * @return
     */
    @Override
    public PageInfo<District> getAllDistrict(Page page) {
        //1.开启分页传页码页大小
        PageHelper.startPage(page.getPage(),page.getRows());
        //2.查询所有区域
        List<District> list = districtMapper.selectByExample(new DistrictExample());
        //3.获取分页相关的属性
        PageInfo<District> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    /**
     * 添加区域
     * @param district 参数区域实体类
     * @return  返回受影响的行数
     */
    @Override
    public int addDistrict(District district) {
        return districtMapper.insertSelective(district);
    }

    /**
     * 修改查询单条数据进行回显
     * @param id 区域id
     * @return 返回单条数据
     */
    @Override
    public District getOneDistrict(Integer id) {
        return districtMapper.selectByPrimaryKey(id);
    }

    /**
     * 修改区域信息
     * @param district 区域实体类
     * @return 受影响的行数
     */
    @Override
    public int updateDistrict(District district) {
        return districtMapper.updateByPrimaryKeySelective(district);
    }

    /**
     * 通过区域id删除区域
     * @param id 区域id
     * @return 返回受影响的行数
     */
    @Override
    public int delDistrict(Integer id) {
        return districtMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int deleteBatchDistrict(Integer[] ids) {
        return districtMapper.deleteBatchDistrict(ids);
    }
}
