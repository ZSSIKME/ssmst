package com.spz.dao;

import com.spz.pojo.Admin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminMapper {
    //修改密码
    int updatePwd(@Param("pwd") String pwd);

    //查询登录
    Admin findSys(Admin admin);

}
