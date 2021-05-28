package com.spz.service.impl;

import com.spz.dao.Stu_orgMapper;
import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import com.spz.service.Stu_orgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Stu_orgServiceImpl implements Stu_orgService {
    @Autowired
    Stu_orgMapper stu_orgMapper;
    @Override
    public List<Stu_org> findByRoleAndNum(String stu_num, int roleID) {
        return stu_orgMapper.findByRoleAndNum(stu_num,roleID);
    }

    @Override
    public List<Stu_org> findByNum(String stu_num) {
        return stu_orgMapper.findByNum(stu_num);
    }

    @Override
    public List<Stu_org> fingByNumAndSta(String stu_num, int stu_statu) {
        return stu_orgMapper.fingByNumAndSta(stu_num,stu_statu);
    }

    @Override
    public int findCount(int stu_org) {
        return stu_orgMapper.findCount(stu_org);
    }

    @Override
    public int joinorg(Stu_org stu_org) {
        return stu_orgMapper.joinorg(stu_org);
    }

    @Override
    public int isjoinOrg(String stu_num, int stu_org) {
        return stu_orgMapper.isjoinOrg(stu_num,stu_org);
    }

    @Override
    public List<Stu_org> findByNumStaROle(String stu_num, int stu_statu, int roleID) {
        return stu_orgMapper.findByNumStaROle(stu_num,stu_statu,roleID);
    }

    @Override
    public List<Stu_org> findstuByid(int id) {
        return stu_orgMapper.findstuByid(id);
    }

    @Override
    public int exitorg(String stu_num, Integer stu_org) {
        return stu_orgMapper.exitorg(stu_num,stu_org);
    }

    @Override
    public int cencelorg(Integer stu_org, String stu_num) {
        return stu_orgMapper.cencelorg(stu_org,stu_num);
    }

    @Override
    public int deleStuByorgID(Integer org_id) {
        return stu_orgMapper.deleStuByorgID(org_id);
    }

    @Override
    public List<Stu_org> apply_stu_list(Integer stuorg) {
        return stu_orgMapper.apply_stu_list(stuorg);
    }

    @Override
    public Stu_org findorgByNum(String stu_num) {
        return stu_orgMapper.findorgByNum(stu_num);
    }

    @Override
    public int is_manager(String stu_num) {
        return stu_orgMapper.is_manager(stu_num);
    }

    @Override
    public int a_agreeorg(Integer stu_org, String stu_num) {
        return stu_orgMapper.a_agreeorg(stu_org,stu_num);
    }

    @Override
    public int a_rejectorg(Integer stu_org, String stu_num) {
        return stu_orgMapper.a_rejectorg(stu_org, stu_num);
    }

}
