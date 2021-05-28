package com.spz.service;

import com.spz.pojo.Activity;
import com.spz.pojo.Stu_act;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ActivityService {
    //查询所有活动
    List<Activity> findall();

    //查询所有活动
    List<Activity> findallFilter(String actName,String act_mana);
    //通过活动id查询
    Activity findById(int id);

    //通过社团id删除活动
    int deleactByOrgId(Integer org_id);

    //通过管理员学号查询管理的活动
    List<Activity> findActBynum(String studentnum);


    //查看该活动参加的学生
    List<Stu_act> showAct_stuList(Integer act_id);

    //创建活动
    int creatact(Activity activity);

    //通过活动id删除活动
    int delact(Integer id);

    //修改
    int alertact(Activity activity);

    //通过活动名字或社团名字查找活动列表
    List<Activity> findBynames(String actname,String orgname, String stuname);
}
