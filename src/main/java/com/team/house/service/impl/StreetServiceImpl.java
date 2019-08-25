package com.team.house.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.team.house.entity.Street;
import com.team.house.entity.StreetExample;
import com.team.house.mapper.StreetMapper;
import com.team.house.service.StreetService;
import com.team.house.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StreetServiceImpl implements StreetService {

    @Autowired
    private StreetMapper streetMapper;

    /**
     * 通过区域id查询街道
     * @param did 区域id
     * @return
     */
    @Override
    public PageInfo<Street> getStreetByDid(Page page, Integer did) {
        //1.开启分页
        PageHelper.startPage(page.getPage(),page.getRows());
        //创建街道条件
        StreetExample se=new StreetExample();
        StreetExample.Criteria c = se.createCriteria();
        c.andDistrictIdEqualTo(did);
        //根据区域查询对应街道
        List<Street> list=streetMapper.selectByExample(se);
        return new PageInfo<Street>(list);
    }
}
