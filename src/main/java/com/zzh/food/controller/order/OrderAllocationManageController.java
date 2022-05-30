package com.zzh.food.controller.order;

import com.alibaba.fastjson.JSON;
import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.vo.OrderVo;
import com.zzh.food.entity.OrderDetailEntity;
import com.zzh.food.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * 订单分配管理控制器
 * @author zhengzhenhua
 */
@RestController
@RequestMapping("/backstage/order")
public class OrderAllocationManageController {

    @Autowired
    private OrderService orderService;

    /**
     * 查询所有出餐中的订单
     * @param vo
     * @return
     */
    @RequestMapping("/allocationList")
    public String findAllCookingOrder(OrderVo vo){
        LayuiTableDataResult allCookingOrder = orderService.findAllCookingOrder(vo);
        return JSON.toJSONString(allCookingOrder);
    }

    /**
     * 查询该订单的所有细则
     * @param orderId
     * @return
     */
    @RequestMapping("/findOrderDetailByOrderId")
    public String findOrderDetailByOrderId(String orderId){
        List<OrderDetailEntity> orderDetailList = orderService.findOrderDetailByOrderId(orderId);
        return JSON.toJSONString(orderDetailList);
    }

    /**
     * 将订单分配给配送员
     * @param deliverId
     * @param orderId
     * @return
     */
    @RequestMapping("/allocationOrder")
    public String allocationOrder(String deliverId, String orderId){
        Map<String, Object> map = orderService.allocationOrder(deliverId, orderId);
        return JSON.toJSONString(map);
    }

    /**
     * 取消订单
     * @param orderId
     * @return
     */
    @RequestMapping("/cancelOrder")
    public String cancelOrder(String orderId){
        Map<String, Object> map = orderService.cancelOrder(orderId);
        return JSON.toJSONString(map);
    }
}
