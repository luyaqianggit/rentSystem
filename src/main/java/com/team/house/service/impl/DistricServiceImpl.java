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
}
