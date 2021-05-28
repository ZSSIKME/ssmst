package com.spz.service;

import com.spz.pojo.Stu_act;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface Stu_actService {
    List<Stu_act> findBynum(String stu_num);


    //按照学号查找加入的活动编号
    List<Stu_act> findBynumName(String stu_num, String actname);
    //加入活动
    int joinact(String stu_num, Integer act_id);

    //通过学号和活动id进行查询，是否已经参加过该活动
    int isjoinByid(String stu_num,Integer act_id);

    //学生进行签到,参数为学号和活动id
    int signinact(String stu_num,Integer act_id);

    //取消加入活动
    int cancelact(String stu_num,Integer act_id);
}
