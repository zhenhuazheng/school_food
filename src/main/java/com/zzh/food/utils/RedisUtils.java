package com.zzh.food.utils;

import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * @author zzh
 * @description
 * @date 2022/6/18
 */
//@Service
public class RedisUtils {

   // @Autowired
    RedissonClient redissonClient;

    private final String LOCK_TITLE = "redisLock_";

    //加锁
    public boolean tryAcquire(String lockName) {
        boolean isLock = false;
        try {
            //声明key对象
            String key = LOCK_TITLE + lockName;
            //获取锁对象
            RLock mylock = redissonClient.getLock(key);
            //加锁，并且设置锁过期时间，防止死锁的产生
            isLock = mylock.tryLock(2, TimeUnit.MINUTES);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return  isLock;
    }

    //加锁
    public void acquire(String lockName) {
        //声明key对象
        String key = LOCK_TITLE + lockName;
        //获取锁对象
        RLock mylock = redissonClient.getLock(key);
        //加锁，并且设置锁过期时间，防止死锁的产生
        mylock.lock(2, TimeUnit.MINUTES);
    }
    //锁的释放
    public void release(String lockName) {
        //必须是和加锁时的同一个key
        String key = LOCK_TITLE + lockName;
        //获取所对象
        RLock mylock = redissonClient.getLock(key);
        //释放锁（解锁）
        mylock.unlock();
    }

}
