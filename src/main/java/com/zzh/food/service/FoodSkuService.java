package com.zzh.food.service;

import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.vo.FoodSkuVo;

import java.util.Map;

/**
 * 菜品SKU服务层
 * @author zhengzhenhua
 */
public interface FoodSkuService {

    /**
     * 根据页面的信息查询菜品SKU集合
     * @param vo
     * @return
     */
    public LayuiTableDataResult findFoodSkuListByPage(FoodSkuVo vo);

    /**
     * 新增菜品SKU
     * @param vo
     * @return
     */
    public Map<String, Object> addFoodSku(FoodSkuVo vo);

    /**
     * 新增菜品SKU
     * @param vo
     * @return
     */
    public Map<String, Object> modifyFoodSku(FoodSkuVo vo);

    /**
     * 删除菜品SKU
     * @param skuId
     * @param skuName
     * @param foodId
     * @return
     */
    public Map<String, Object> deleteFoodSku(Long skuId, String skuName, Long foodId);
}
