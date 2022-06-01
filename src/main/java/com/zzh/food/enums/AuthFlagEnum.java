package com.zzh.food.enums;

/**
 * @author zzh
 * @description
 * @date 2022/5/31
 */
public enum AuthFlagEnum {
    YES("Y", "已认证"),
    NO("N", "未认证");

    private final String code;
    private final String value;

    private AuthFlagEnum(String code, String value) {
        this.code = code;
        this.value = value;
    }

    public String getCode() {
        return code;
    }

    public String getValue() {
        return value;
    }
}
