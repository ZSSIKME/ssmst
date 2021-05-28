package com.spz.service.impl;

import com.spz.dao.Stu_actMapper;
import com.spz.pojo.Stu_act;
import com.spz.service.Stu_actService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Stu_actServiceImpl implements Stu_actService {
    @Autowired
    Stu_actMapper stu_actMapper;
    @Override
    public List<Stu_act> findBynum(String stu_num) {
        return stu_actMapper.findBynum(stu_num);
    }

    @Override
    public List<Stu_act> findBynumName(String stu_num, String actname) {
        return stu_actMapper.findBynumName(stu_num, actname);
    }

    @Override
    public int joinact(String stu_num, Integer act_id) {
        return stu_actMapper.joinact(stu_num,act_id);
    }

    @Override
    public int isjoinByid(String stu_num, Integer act_id) {
        return stu_actMapper.isjoinByid(stu_num,act_id);
    }

    @Override
    public int signinact(String stu_num, Integer act_id) {
        return stu_actMapper.signinact(stu_num,act_id);
    }

    @Override
    public int cancelact(String stu_num, Integer act_id) {
        return stu_actMapper.cancelact(stu_num, act_id);
    }
}
