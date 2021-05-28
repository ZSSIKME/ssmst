package com.spz.service;

import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrgService {
    Organization findbyid(int id);
    //查询所有社团
    List<Organization> findall();
    //查询所有社团
    List<Organization> findallFilter(String orgname,String manager);

    //通过管理员查询创建的社团
    Organization findByManager(String managernum);

    //创建社团
    int createorg(Organization organization);

    //根据社团id删除社团
    int deleOrgById(Integer org_id);

    //根据学生学号和社团id删除指定学生
    int delstu_org(String stunum,Integer stu_org);

    //通过学生学号和社团id修改状态
    int agree(String stu_num,Integer stu_org);

    //通过学生学号和社团id删除记录
    int refuse(String stu_num,Integer stu_org);

    //查询所有正在申请的社团
    List<Stu_org> show_apply_org();

    //管理员同意社团申请
    int a_agreeorg(Integer id);

    //修改社团信息
    int alterorginfo(Integer id,String name,String info);

    List<Organization> findorg(String name,String stu_name);

    List<Organization> findallbyName(String name,String stu_name);
}
