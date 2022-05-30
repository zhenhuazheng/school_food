package com.zzh.food.dao;

import com.zzh.food.entity.MobileVerEntity;
import com.zzh.food.entity.UserEntity;
import com.zzh.food.vo.MobileVerVo;
import com.zzh.food.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodMobileVerMapper {

    /**
     * 根据用户名查询用户信息
     * @param
     * @return
     */
    public MobileVerEntity findMobileVerByUserId(String userId);

    /**
     * 后台添加用户，返回添加的用户Id
     * @param vo
     * @return
     */
    public Long addMobileVer(MobileVerVo vo);

    /**
     * 后台修改用户信息
     * @param vo
     * @return
     */
    public Integer modifyMobileVer(MobileVerVo vo);

}
