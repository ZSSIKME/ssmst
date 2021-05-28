package com.spz.service;


import com.spz.pojo.Admin;
import org.apache.ibatis.annotations.Param;

public interface AdminService {
    //修改密码
    int updatePwd(String pwd);

    //查询登录
    Admin findSys(Admin admin);

}
