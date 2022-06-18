package com.zzh.food.configuration;

import org.redisson.Redisson;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author zzh
 * @description
 * @date 2022/5/24
 */
@Configuration
public class RedissonConfig {

    @Bean
    RedissonClient redisson(){
        Config config = new Config();
        config.useSingleServer().setAddress("redis://127.0.0.1:6379");
        //config.useClusterServers().addNodeAddress("redis://127.0.0.1:6379","redis://127.0.0.1:6380");
        config.setCodec(new org.redisson.client.codec.StringCodec());
        RedissonClient redissonClient = null;
        try {
            redissonClient = Redisson.create(config);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return redissonClient;
    }

}
