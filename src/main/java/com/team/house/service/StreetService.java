package com.team.house.service;

import com.github.pagehelper.PageInfo;
import com.team.house.entity.Street;
import com.team.house.utils.Page;

import java.util.List;

public interface StreetService {

    /**
     * 通过区域id查询对应的街道
     * @param did 区域id
     * @return
     */
    public PageInfo<Street> getStreetByDid(Page page, Integer did);

}
