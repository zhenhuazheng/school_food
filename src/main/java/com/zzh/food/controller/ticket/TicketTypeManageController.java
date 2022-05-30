package com.zzh.food.controller.ticket;

import com.alibaba.fastjson.JSON;
import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.vo.TicketTypeVo;
import com.zzh.food.service.TicketTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 优惠券类别管理控制器
 * @author zhengzhenhua
 */
@RestController
@RequestMapping("/backstage/ticketType")
public class TicketTypeManageController {

    @Autowired
    private TicketTypeService ticketTypeService;

    /**
     * 根据页面条件查询优惠券类型集合
     * @param vo
     * @return
     */
    @RequestMapping("/list")
    public String findTicketTypeListByPage(TicketTypeVo vo){
        LayuiTableDataResult ticketTypeListByPage = ticketTypeService.findTicketTypeListByPage(vo);
        return JSON.toJSONString(ticketTypeListByPage);
    }

    /**
     * 新增优惠券类型
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/add")
    public String addTicketType(TicketTypeVo vo, HttpSession session){
        Map<String, Object> map = ticketTypeService.addTicketType(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 修改优惠券类型
     * @param vo
     * @param session
     * @return
     */
    @RequestMapping("/modify")
    public String modifyTicketType(TicketTypeVo vo, HttpSession session){
        Map<String, Object> map = ticketTypeService.modifyTicketType(vo, session);
        return JSON.toJSONString(map);
    }

    /**
     * 优惠券类型上架
     * @param ticketTypeId
     * @param session
     * @return
     */
    @RequestMapping("/onShelf")
    public String onShelf(Long ticketTypeId, HttpSession session){
        Map<String, Object> map = ticketTypeService.onShelf(ticketTypeId, session);
        return JSON.toJSONString(map);
    }

    /**
     * 优惠券类型下架
     * @param ticketTypeId
     * @param session
     * @return
     */
    @RequestMapping("/offShelf")
    public String offShelf(Long ticketTypeId, HttpSession session){
        Map<String, Object> map = ticketTypeService.offShelf(ticketTypeId, session);
        return JSON.toJSONString(map);
    }

    /**
     * 删除优惠券类型
     * @param ticketTypeId
     * @return
     */
    @RequestMapping("/delete")
    public String deleteTicketType(Long ticketTypeId){
        Map<String, Object> map = ticketTypeService.deleteTicketType(ticketTypeId);
        return JSON.toJSONString(map);
    }

}
