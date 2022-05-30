package com.zzh.food.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户扩展实体类
 * @author zhengzhenhua
 */
@Data
public class UserExtEntity implements Serializable {
    private Long userId;
    private String name;
    private String idCard;
    private String pictureUp;
    private String pictureDown;
    private String status;
    private Date createTime;
    private String lastOperator;

}
