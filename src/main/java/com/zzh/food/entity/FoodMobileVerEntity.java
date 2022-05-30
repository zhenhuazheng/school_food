package com.zzh.food.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author zhengzhenhua
 */
@Data
public class FoodMobileVerEntity implements Serializable {
    private Long id;
    private String verCode;
    private Long userId;
    private Date endTime;
    private Date createTime;
    private String status;

}
