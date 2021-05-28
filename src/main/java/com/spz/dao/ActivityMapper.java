package com.spz.dao;

import com.spz.pojo.Activity;
import com.spz.pojo.Stu_act;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActivityMapper {

    //查询所有活动
    List<Activity> findall();


    //查询所有活动
    List<Activity> findallFilter(@Param("act_name")String actName,@Param("act_mana")String act_mana);

    //通过活动id查询
    Activity findById(@Param("id") int id);

    //通过社团id删除活动
    int deleactByOrgId(@Param("org_id")Integer org_id);

    //通过管理员学号查询管理的活动
    List<Activity> findActBynum(@Param("managernum")String studentnum);


    //查看该活动参加的学生
    List<Stu_act> showAct_stuList(@Param("act_id") Integer act_id);


    //创建活动
    int creatact(Activity activity);

    //通过活动id删除活动
    int delact(@Param("id")Integer id);

    //修改
    int alertact(Activity activity);

    //通过活动名字或社团名字查找活动列表
    List<Activity> findBynames(@Param("actname")String actname,@Param("orgname")String orgname,
                               @Param("stuname")String stuname);
}
