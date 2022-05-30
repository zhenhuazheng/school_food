package com.zzh.food.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 验证码实体类
 * @author zhengzhenhua
 */
@Data
public class MobileVerEntity implements Serializable {
    private Long id;
    private Long userId;
    private String verCode;
    private String status;
    private Date createTime;
    private Date endTime;

}
