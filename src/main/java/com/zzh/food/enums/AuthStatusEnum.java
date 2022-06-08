package com.zzh.food.enums;

/**
 * @author zzh
 * @description
 * @date 2022/5/31
 */
public enum AuthStatusEnum {
    WAIT("W", "待审核"),
    PASS("P", "审核通过"),
    NOPASS("N", "审核未通过");

    private final String code;
    private final String value;

    private AuthStatusEnum(String code, String value) {
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
