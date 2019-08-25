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
@RequestMapping("/admin")
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

    /**
     * //添加区域
     * @param district 区域实体类
     * @return 返回数据（受影响的行数）
     */
    @RequestMapping("/addDistrict")
    @ResponseBody
    public String addDistrict(District district){
        //掉业务层实现添加区域
        int i = districtService.addDistrict(district);
        return "{\"result\":"+i+"}";
    }

    /**
     * 修改查询单条数据进行回显
     * @param id 区域id
     * @return 返回单条数据
     */
    @RequestMapping("/getOneDistrict")
    @ResponseBody
    public District getOneDistrict(Integer id){
        //掉业务层查询单条数据
        District district = districtService.getOneDistrict(id);
        //返回单条数据
        return district;
    }

    /**
     * 修改区域信息
     * @param district 区域实体类
     * @return 返回受影响的行数
     */
    @RequestMapping("/updateDistrict")
    @ResponseBody
    public String updateDistrict(District district){
        //掉业务层实现区域的修改
        int i = districtService.updateDistrict(district);
        //返回受影响的行数
        return "{\"result\":"+i+"}";
    }

    /**
     * 通过区域id删除区域信息
     * @param id 区域id
     * @return 返回受影响的行数
     */
    @RequestMapping("/delDistrict")
    @ResponseBody
    public String delDistrict(Integer id){
        //掉业务层通过id删除区域信息
        int i = districtService.delDistrict(id);
        //返回受影响的行数
        return "{\"result\":"+i+"}";
    }

    /**
     * 通过区域id数组，批量删除区域信息
     * @param ids 区域id
     * @return 受影响的行数
     */
    @RequestMapping("/deleteBatchDistrict")
    @ResponseBody
    public String deleteBatchDistrict(String ids){
        //1.将字符串转化成字符数组
        String [] array=ids.split(",");
        Integer [] is=new Integer[array.length];
        for (int i=0;i<array.length;i++){
            is[i]=new Integer(array[i]);
        }
        //掉业务层通过id删除区域信息
        int i = districtService.deleteBatchDistrict(is);
        //返回受影响的行数
        return "{\"result\":"+i+"}";
    }
}
