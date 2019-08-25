package com.team.house.service;

import com.team.house.entity.Street;

import java.util.List;

public interface StreetService {

    /**
     * 通过区域id查询对应的街道
     * @param did 区域id
     * @return
     */
    public List<Street> getStreetByDid(Integer did);
}
