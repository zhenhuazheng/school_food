package com.zzh.food.utils;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * @author zzh
 * @description
 * @date 2022/6/6
 */
public class TimeUtil {

    /**
     * localDateTime 转 date
     * @param dateTime
     * @return
     */
    public static LocalDateTime addMinute(LocalDateTime dateTime, int minute) {
        return dateTime.atZone(ZoneId.systemDefault()).plusMinutes(30).toLocalDateTime();
    }

    /**
     * localDateTime 转 date
     * @param dateTime
     * @return
     */
    public static Date toDate(LocalDateTime dateTime) {
        return Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

}
