package com.spz.dao;

import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrgMapper {

    //通过id查询社团信息
    Organization findbyid(@Param("id") int id);

    //查询所有社团
    List<Organization> findall();

    //查询所有社团
    List<Organization> findallFilter(@Param("orgname")String orgname,@Param("manager")String manager);


    //通过管理员查询创建的社团
    Organization findByManager(@Param("managernum") String managernum);

    //创建社团
    int createorg(Organization organization);

    //根据社团id删除社团
    int deleOrgById(@Param("org_id")Integer org_id);

    //根据学生学号和社团id删除指定学生
    int delstu_org(@Param("stu_num")String stunum,@Param("stu_org")Integer stu_org);

    //通过学生学号和社团id修改状态
    int agree(@Param("stu_num")String stu_num,@Param("stu_org")Integer stu_org);

    //通过学生学号和社团id删除记录
    int refuse(@Param("stu_num")String stu_num,@Param("stu_org")Integer stu_org);

    //查询所有正在申请的社团
    List<Stu_org> show_apply_org();

    //管理员同意社团申请
    int a_agreeorg(@Param("id")Integer id);

    //修改社团信息
    int alterorginfo(@Param("id")Integer id,@Param("name")String name,@Param("info")String info);

    List<Organization> findorg(@Param("name")String name,@Param("stu_name")String stu_name);
    List<Organization> findallbyName(@Param("name")String name,@Param("stu_name")String stu_name);
}
