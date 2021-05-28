package com.spz.dao;

import com.spz.pojo.Stu_act;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
@Repository
public interface Stu_actMapper {
    //按照学号查找加入的活动编号
    List<Stu_act> findBynum(@Param("stu_num") String stu_num);

    //按照学号查找加入的活动编号
    List<Stu_act> findBynumName(@Param("stu_num") String stu_num, @Param("actname") String actname);

    //加入活动
    int joinact(@Param("stu_num")String stu_num,@Param("act_id") Integer act_id);

    //通过学号和活动id进行查询，是否已经参加过该活动
    int isjoinByid(@Param("stu_num") String stu_num,@Param("act_id")Integer act_id);

    //学生进行签到,参数为学号和活动id
    int signinact(@Param("stu_num") String stu_num,@Param("act_id")Integer act_id);

    //取消加入活动
    int cancelact(@Param("stu_num")String stu_num,@Param("act_id")Integer act_id);
}
