package com.zzh.food.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户实体类
 * @author zhengzhenhua
 */
@Data
public class UserEntity implements Serializable {
    private Long userId;
    private String username;
    private String password;
    private String phone;
    private String email;
    private Integer gender;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd")
    @JSONField(format="yyyy-MM-dd")
    private Date birthday;
    private Date registerDate;
    private Integer score;
    private Date lastLoginTime;
    private Date lastLogoutTime;
    private Integer loginCount;
    private String status;
    private String authFlag;

}
