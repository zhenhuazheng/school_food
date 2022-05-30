package com.zzh.food.controller.food;

import com.alibaba.fastjson.JSON;
import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.vo.FoodSkuVo;
import com.zzh.food.service.FoodSkuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 菜品SKU管理控制器
 * @author zhengzhenhua
 */
@RestController
@RequestMapping("/backstage/foodSku")
public class FoodSkuManageController {

    @Autowired
    private FoodSkuService foodSkuService;

    /**
     * 根据页面的信息查询菜品SKU集合
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findFoodSkuListByPage(FoodSkuVo vo){
        LayuiTableDataResult foodSkuListByPage = foodSkuService.findFoodSkuListByPage(vo);
        return JSON.toJSONString(foodSkuListByPage);
    }

    /**
     * 新增菜品SKU
     * @param vo
     * @return
     */
    @RequestMapping("/add")
    public String addFoodSku(FoodSkuVo vo){
        Map<String, Object> map = foodSkuService.addFoodSku(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 菜品SKU修改
     * @param vo
     * @return
     */
    @RequestMapping("/modify")
    public String modifyFoodSku(FoodSkuVo vo){
        Map<String, Object> map = foodSkuService.modifyFoodSku(vo);
        return JSON.toJSONString(map);
    }

    /**
     * 删除菜品SKU
     * @param skuId
     * @param skuName
     * @param foodId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteFoodSku(Long skuId, String skuName, Long foodId){
        Map<String, Object> map = foodSkuService.deleteFoodSku(skuId, skuName, foodId);
        return JSON.toJSONString(map);
    }
}
