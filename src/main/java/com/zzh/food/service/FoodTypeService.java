package com.zzh.food.service;

import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.vo.FoodTypeVo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 菜品类别服务层
 * @author LiangJie
 */
public interface FoodTypeService {

    /**
     * 根据页面返回信息查找符合条件的菜品类别集合
     * @param vo
     * @return
     */
    public LayuiTableDataResult findFoodTypeListByPage(FoodTypeVo vo);

    /**
     * 菜品类别文件上传
     * @param foodtypeImage
     * @return
     */
    public Map<String, Object> uploadFile(MultipartFile foodtypeImage);

    /**
     * 添加菜品类别
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> addFoodtype(FoodTypeVo vo, HttpSession session);

    /**
     * 编辑菜品类别
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> modifyFoodtype(FoodTypeVo vo, HttpSession session);

    /**
     * 菜品类别下架
     * @param typeId
     * @param session
     * @return
     */
    public Map<String, Object> offShelfFoodtype(Long typeId, HttpSession session);

    /**
     * 菜品类别恢复上架
     * @param typeId
     * @param session
     * @return
     */
    public Map<String, Object> onShelfFoodtype(Long typeId, HttpSession session);

    /**
     * 查询所有的菜品类别
     * @return
     */
    public Map<String, Object> findAllFoodtype();
}
