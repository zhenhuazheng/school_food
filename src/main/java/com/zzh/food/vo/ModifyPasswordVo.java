package com.zzh.food.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ModifyPasswordVo  implements Serializable {

    private String newPassword;

    private String phone;

    private String verCode;

}
