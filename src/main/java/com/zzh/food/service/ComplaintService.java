package com.zzh.food.service;

import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.vo.ComplaintVo;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 投诉 服务层
 * @author zhengzhenhua
 */
public interface ComplaintService {

    /**
     * 用户发表投诉
     * @param vo
     * @param session
     * @return
     */
    public Map<String, Object> addComplaint(ComplaintVo vo, HttpSession session);

    /**
     * 根据页面传递的条件查询对应的投诉信息
     * @param vo
     * @return
     */
    public LayuiTableDataResult findComplaintListByPage(ComplaintVo vo);

    /**
     * 查询该用户的所有投诉
     * @param session
     * @return
     */
    public Map<String, Object> findByUser(HttpSession session);
}
