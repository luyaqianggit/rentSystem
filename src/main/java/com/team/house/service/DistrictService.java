package com.team.house.service;

import com.github.pagehelper.PageInfo;
import com.team.house.entity.District;
import com.team.house.utils.Page;

public interface DistrictService {

    /**
     * 分页查询所有区域
     * @param page 分页的条件 page页码  rows页大小
     * @return 区域实体集合
     */
    public PageInfo<District> getAllDistrict(Page page);

}
