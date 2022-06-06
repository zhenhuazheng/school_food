package com.zzh.food.vo;

import com.zzh.food.entity.UserEntity;
import lombok.Data;

@Data
public class UserVo extends UserEntity {
    //当前页码
    private Integer page;
    //每页显示数量
    private Integer limit;
    //验证码
    private String verCode;

}
