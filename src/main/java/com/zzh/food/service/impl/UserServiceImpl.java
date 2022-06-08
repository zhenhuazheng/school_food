package com.zzh.food.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzh.food.dao.*;
import com.zzh.food.entity.MobileVerEntity;
import com.zzh.food.enums.AuthFlagEnum;
import com.zzh.food.enums.AuthStatusEnum;
import com.zzh.food.enums.StatusEnum;
import com.zzh.food.utils.CreateCodeUtil;
import com.zzh.food.utils.LayuiTableDataResult;
import com.zzh.food.utils.SystemConstant;
import com.zzh.food.utils.TimeUtil;
import com.zzh.food.vo.MobileVerVo;
import com.zzh.food.vo.ModifyPasswordVo;
import com.zzh.food.vo.UserExtVo;
import com.zzh.food.vo.UserVo;
import com.zzh.food.entity.RoleEntity;
import com.zzh.food.entity.UserEntity;
import com.zzh.food.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private DeliverMapper deliverMapper;

    @Autowired
    private UserExtMapper userExtMapper;

    @Autowired
    private FoodMobileVerMapper mobileVerMapper;

    /**
     * 用户登录方法，根据用户名和密码校验用户的信息是否正确
     * @return
     */
    @Override
    public Map<String, Object> login(String usernane, String password, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        UserEntity userLogin = userMapper.findUserByUsername(usernane);
        if (userLogin != null) {
            if (userLogin.getPassword().equals(password)){
                //登录通过，保存登录成功的信息
                userMapper.setLoginSuccessInfo(userLogin.getUserId());
                //将user信息保存到session中
                session.setAttribute(SystemConstant.USERLOGIN, userLogin);
                map.put(SystemConstant.LOGINFLAG, true);
                map.put(SystemConstant.AUTH_FLAG, false);
                if (AuthFlagEnum.YES.getCode().equals(userLogin.getAuthFlag())) {
                    map.put(SystemConstant.AUTH_FLAG, true);
                }
            }else {
                //密码错误
                map.put(SystemConstant.LOGINFLAG, false);
                map.put(SystemConstant.MESSAGE, "密码错误！");
            }
        }else {
            //用户名不存在
            map.put(SystemConstant.LOGINFLAG, false);
            map.put(SystemConstant.MESSAGE, "用户名不存在！");
        }
        return map;
    }

    /**
     * 用户退出登录时的业务逻辑
     * @param session
     */
    @Override
    public void exit(HttpSession session) {
        UserEntity user = (UserEntity)session.getAttribute(SystemConstant.USERLOGIN);
        //保存用户登出信息
        userMapper.setLogoutSuccessInfo(user.getUserId());
        session.removeAttribute(SystemConstant.USERLOGIN);
    }

    /**
     * 根据页面条件查询用户列表
     * @param vo
     * @return
     */
    @Override
    public LayuiTableDataResult findUserListByPage(UserVo vo) {
        //设置分页信息
        PageHelper.startPage(vo.getPage(), vo.getLimit());
        //调用分页查询的方法
        List<UserEntity> userList = userMapper.findUserListByPage(vo);
        //创建分页对象，将查询到的数据放进去
        PageInfo<UserEntity> pageInfo = new PageInfo<>(userList);
        //返回数据
        return new LayuiTableDataResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 后台添加用户
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> addUser(UserVo vo) {
        //设置默认的用户初始密码
        vo.setPassword(SystemConstant.DEFAULTPASSWORD);
        Map<String, Object> map = new HashMap<>(16);
        //获取影响行数
        Long effectRow = userMapper.addUser(vo);
        //获取用户Id，这个是在xml配置文件中配置的，也是mysql的方法，将新增的Id包装回原对象中
        Long userId = vo.getUserId();
        //添加用户的默认角色关系
        if (userId!=null && userMapper.addUserAndRole(userId, SystemConstant.DEFAULTROLEID)>=1 && effectRow>=1) {
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "添加用户成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "添加用户失败");
        }
        return map;
    }

    /**
     * 后台修改用户信息
     * @param vo
     * @return
     */
    @Override
    public Map<String, Object> modifyUserBackstage(UserVo vo) {
        Map<String, Object> map = new HashMap<>(16);
        if (userMapper.modifyUserBackstage(vo) >= 1){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "修改用户成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "修改用户失败");
        }
        return map;
    }

    /**
     * 重置用户密码
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> resetPassword(Long userId) {
        Map<String, Object> map = new HashMap<>(16);
        if (userMapper.resetPassword(userId, SystemConstant.DEFAULTPASSWORD) >= 1){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "用户密码重置成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "用户密码重置失败");
        }
        return map;
    }

    /**
     * 查询用户所拥有的角色列表
     * @param userId
     * @return
     */
    @Override
    public LayuiTableDataResult findRoleListByUserId(Long userId) {
        //查询所有的角色列表
        List<Map<String, Object>> roleListMap = roleMapper.findRoleListMap();
        //根据用户ID查询其拥有的角色
        List<Long> roleByUserId = userMapper.findRoleByUserId(userId);
        for (Map<String, Object> roleMap : roleListMap) {
            roleMap.put(SystemConstant.LAY_CHECK, false);
            for (Long roleId : roleByUserId) {
                //遍历角色编号列表，标记用户拥有的角色
                if (roleMap.get("roleId").equals(roleId)){
                    roleMap.put(SystemConstant.LAY_CHECK, true);
                    break;
                }
            }
        }
        return new LayuiTableDataResult(roleListMap);
    }

    /**
     * 为用户授权角色
     * @param roleIds
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> grantRole(String roleIds, Long userId) {
        Map<String, Object> map = new HashMap<>(16);
        //拆分字符串，得到roleID的数组
        String[] roleIdArray = roleIds.split(",");
        try{
            //每一次授权都需要删除之前该用户的所有角色关系
            userMapper.deleteUserAllRole(userId);
            for (String roleId : roleIdArray) {
                //新增用户角色关系
                userMapper.addUserAndRole(userId, Long.parseLong(roleId));
                //根据角色Id查询角色名称
                RoleEntity role = roleMapper.findRoleByRoleId(Long.parseLong(roleId));
                if (role!=null && role.getRoleName().equals(SystemConstant.DELIVERROLENAME)){
                    //查找该用户是否曾经是配送员
                    if (deliverMapper.findDeliverByUserId(userId) == 0){
                        //添加该用户到配送员表
                        deliverMapper.addDeliver(CreateCodeUtil.createDeliverId(), userId);
                    }
                }
            }
            map.put(SystemConstant.MESSAGE, "用户角色关系授权成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put(SystemConstant.MESSAGE, "用户角色关系授权失败");
        }
        return map;
    }

    /**
     * 删除用户信息
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> deleteUser(Long userId) {
        Map<String, Object> map = new HashMap<>(16);
        //先删除该用户的角色关系
        if (userMapper.deleteUserAndRoleByUserId(userId)>=1 && userMapper.deleteUser(userId)>=1){
            map.put(SystemConstant.FLAG, true);
            map.put(SystemConstant.MESSAGE, "用户信息删除成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "用户信息删除失败");
        }
        return map;
    }

    /**
     * 校验用户注册输入的用户名是否存在
     * @param username
     * @return
     */
    @Override
    public Map<String, Object> checkUsername(String username) {
        Map<String, Object> map = new HashMap<>(16);
        if (userMapper.checkUsername(username) == 0) {
            map.put(SystemConstant.FLAG, true);
        } else {
            map.put(SystemConstant.FLAG, false);
        }
        return map;
    }

    /**
     * 用户注册
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> register(UserVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        //校验用户名是否重复
        if (userMapper.checkUsername(vo.getUsername()) != 0){
            map.put(SystemConstant.LOGINFLAG, false);
            map.put(SystemConstant.MESSAGE, "该用户名已存在!");
            return map;
        }
        MobileVerEntity verEntity = mobileVerMapper.findMobileVerByPhone(vo.getPhone());
        if (verEntity == null || !vo.getVerCode().equals(verEntity.getVerCode())) {
            map.put(SystemConstant.LOGINFLAG, false);
            map.put(SystemConstant.MESSAGE, "验证码不正确!");
            return map;
        }
        vo.setAuthFlag(AuthFlagEnum.NO.getCode());
        vo.setStatus(StatusEnum.YES.getCode());
        //加入用户基础数据
        if (userMapper.register(vo) > 0){
            //将用户添加基础角色
            Long userId = vo.getUserId();
            if (userMapper.addUserAndRole(userId, SystemConstant.DEFAULTROLEID) > 0) {
                map.put(SystemConstant.LOGINFLAG, true);
                map.put(SystemConstant.AUTH_FLAG, false);
                //将user信息保存到session中
                session.setAttribute(SystemConstant.USERLOGIN, vo);
                //登录通过，保存登录成功的信息
                userMapper.setLoginSuccessInfo(vo.getUserId());
                return map;
            }
        }
        map.put(SystemConstant.LOGINFLAG, false);
        return map;
    }

    @Override
    public Map<String, Object> auth(UserExtVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        vo.setStatus(AuthStatusEnum.PASS.getCode());
        //加入用户基础数据
        if (userExtMapper.addUserExt(vo) > 0){
            UserVo userVo = new UserVo();
            userVo.setUserId(vo.getUserId());
            userVo.setAuthFlag(AuthFlagEnum.YES.getCode());
            userMapper.modifyUserBackstage(userVo);
            map.put(SystemConstant.AUTH_FLAG, true);
        } else {
            map.put(SystemConstant.AUTH_FLAG, false);
        }
        return map;
    }

    /**
     * 查询登录用户的个人资料
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> findUserByUserId(Long userId) {
        Map<String, Object> map = new HashMap<>(16);
        UserEntity user = userMapper.findUserByUserId(userId);
        map.put(SystemConstant.USERLOGIN, user);
        return map;
    }

    /**
     * 修改用户个人信息
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyUserReception(UserVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        if (userMapper.modifyUserBackstage(vo) > 0) {
            map.put(SystemConstant.FLAG, true);
            UserEntity user = userMapper.findUserByUserId(vo.getUserId());
            //重新设置session域中的登录用户信息
            session.setAttribute(SystemConstant.USERLOGIN, user);
            map.put(SystemConstant.MESSAGE, "信息修改成功");
        }else {
            map.put(SystemConstant.FLAG, false);
            map.put(SystemConstant.MESSAGE, "信息修改失败");
        }
        return map;
    }

    /**
     * 用户修改密码
     * @param vo
     * @param session
     * @return
     */
    @Override
    public Map<String, Object> modifyPassword(ModifyPasswordVo vo, HttpSession session) {
        Map<String, Object> map = new HashMap<>(16);
        try {
            UserEntity user = userMapper.findUserByPhone(vo.getPhone());
            if (user != null){
                MobileVerEntity verEntity = mobileVerMapper.findMobileVerByPhone(vo.getPhone());
                if (verEntity == null || !vo.getVerCode().equals(verEntity.getVerCode())) {
                    map.put(SystemConstant.LOGINFLAG, false);
                    map.put(SystemConstant.MESSAGE, "验证码不正确!");
                    return map;
                }
                if (userMapper.modifyPassword(vo.getNewPassword(), user.getUserId()) > 0) {
                    map.put(SystemConstant.SUCCESS, true);
                    map.put(SystemConstant.MESSAGE, "密码修改成功");
                }else {
                    map.put(SystemConstant.SUCCESS, false);
                    map.put(SystemConstant.MESSAGE, "密码修改失败");
                }
            }else {
                map.put(SystemConstant.SUCCESS, false);
                map.put(SystemConstant.MESSAGE, "用户不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            map.put(SystemConstant.SUCCESS, false);
            map.put(SystemConstant.MESSAGE, "系统异常");
        }
        return map;
    }

    @Override
    public Map<String, Object> verCode(String phone) {
        Map<String, Object> map = new HashMap<>(16);
        MobileVerVo mobileVerVo = new MobileVerVo();
        mobileVerVo.setEndTime(TimeUtil.toDate(TimeUtil.addMinute(LocalDateTime.now(), 30)));
        mobileVerVo.setVerCode(String.valueOf((int)((Math.random()*9+1)*100000)));
        mobileVerVo.setPhone(phone);
        if (mobileVerMapper.addMobileVer(mobileVerVo) > 0){
            map.put(SystemConstant.SUCCESS, true);
        } else {
            map.put(SystemConstant.SUCCESS, false);
            map.put(SystemConstant.MESSAGE, "发送短信失败");
        }
        return map;
    }


}
