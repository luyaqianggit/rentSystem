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

    /**
     * 添加区域信息
     * @param district 参数区域实体类
     * @return 返回受影响的行数
     */
    public int addDistrict(District district);

    /**
     * 修改通过ID查询单条进行回显
     * @param id 区域id
     * @return 返回单条数据 区域对象
     */
    public District getOneDistrict(Integer id);

    /**
     * 修改区域信息
     * @param district 区域实体类
     * @return 受影响的行数
     */
    public int updateDistrict(District district);

    /**
     * 通过区域id删除区域
     * @param id 区域id
     * @return 返回受影响的行数
     */
    public int delDistrict(Integer id);


    /**
     * 批量删除区域
     * @param ids  数组区域ID
     * @return 返回受影响的行数
     */
    public int deleteBatchDistrict(Integer [] ids);
}
