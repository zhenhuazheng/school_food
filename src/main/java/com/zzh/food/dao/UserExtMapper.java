package com.zzh.food.dao;

import com.zzh.food.entity.UserExtEntity;
import com.zzh.food.vo.UserExtVo;
import org.springframework.stereotype.Repository;

@Repository
public interface UserExtMapper {

    /**
     * 根据用户编号查询用户信息
     * @param userId
     * @return
     */
    public UserExtEntity findUserExtByUserId(String userId);


    /**
     * 后台添加用户，返回添加的用户Id
     * @param vo
     * @return
     */
    public Long addUserExt(UserExtVo vo);

    /**
     * 后台修改用户信息
     * @param vo
     * @return
     */
    public Integer modifyUserExt(UserExtVo vo);


}
