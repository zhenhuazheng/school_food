package com.zzh.food.enums;

/**
 * @author zzh
 * @description
 * @date 2022/5/31
 */
public enum StatusEnum {
    YES("Y", "可用"),
    NO("N", "不可用");

    private final String code;
    private final String value;

    private StatusEnum(String code, String value) {
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
