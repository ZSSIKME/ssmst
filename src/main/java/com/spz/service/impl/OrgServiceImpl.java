package com.spz.service.impl;

import com.spz.dao.OrgMapper;
import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.service.OrgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgServiceImpl implements OrgService {

    @Autowired
    OrgMapper orgMapper;
    @Override
    public Organization findbyid(int id) {
        return orgMapper.findbyid(id);
    }

    @Override
    public List<Organization> findall() {
        return orgMapper.findall();
    }

    @Override
    public List<Organization> findallFilter(String orgname, String manager) {
        return orgMapper.findallFilter(orgname, manager);
    }

    @Override
    public Organization findByManager(String managernum) {
        return orgMapper.findByManager(managernum);
    }

    @Override
    public int createorg(Organization organization) {
        return orgMapper.createorg(organization);
    }

    @Override
    public int deleOrgById(Integer org_id) {
        return orgMapper.deleOrgById(org_id);
    }

    @Override
    public int delstu_org(String stunum, Integer stu_org) {
        return orgMapper.delstu_org(stunum,stu_org);
    }

    @Override
    public int agree(String stu_num, Integer stu_org) {
        return orgMapper.agree(stu_num, stu_org);
    }

    @Override
    public int refuse(String stu_num, Integer stu_org) {
        return orgMapper.refuse(stu_num, stu_org);
    }

    @Override
    public List<Stu_org> show_apply_org() {
        return orgMapper.show_apply_org();
    }

    @Override
    public int a_agreeorg(Integer id) {
        return orgMapper.a_agreeorg(id);
    }

    @Override
    public int alterorginfo(Integer id, String name, String info) {
        return orgMapper.alterorginfo(id,name,info);
    }

    @Override
    public List<Organization> findorg(String name,String stu_name) {
        return orgMapper.findorg(name,stu_name);
    }

    @Override
    public List<Organization> findallbyName(String name, String stu_name) {
        return orgMapper.findallbyName(name, stu_name);
    }

}
