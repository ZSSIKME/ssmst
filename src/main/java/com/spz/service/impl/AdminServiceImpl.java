package com.spz.service.impl;

import com.spz.dao.AdminMapper;
import com.spz.pojo.Admin;
import com.spz.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;
    @Override
    public int updatePwd(String pwd) {
        return adminMapper.updatePwd(pwd);
    }

    @Override
    public Admin findSys(Admin admin) {
        return adminMapper.findSys(admin);
    }

}
