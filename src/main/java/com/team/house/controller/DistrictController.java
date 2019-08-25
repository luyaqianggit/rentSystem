package com.team.house.controller;

import com.github.pagehelper.PageInfo;
import com.team.house.entity.District;
import com.team.house.service.DistrictService;
import com.team.house.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
@RequestMapping("admin")
public class DistrictController {
    @Autowired
    private DistrictService districtService;

    /**
     * 查询所有区域
     * @return  返回集合：分页需要给前台传 total键和rows的页数据
     */
    @RequestMapping("/getAllDistrict")
    @ResponseBody //返回数据需要@ResponseBody注解
    public HashMap<String,Object> getAllDistrict(Page page){
        //1.掉业务层查询区域
        PageInfo<District> pageInfo = districtService.getAllDistrict(page);
        //返回total键和rows键
        HashMap<String,Object> map=new HashMap<>();
        map.put("total",pageInfo.getTotal());
        map.put("rows",pageInfo.getList());
        return map;
    }
}
