package com.spz.service;

import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentService {

    //通过num查找学生
    Student findByNum(String num);
    //验证学生身份
    Student checkstu(String num,String IdCard,String name,String phone);
    //更改学生密码
    int updatepwd(String num,String pwd);

    //添加学生
    int addStudent(Student student);

    //更改信息
    int alterinfo(Student student);

    //查询社团内的学生列表
    List<Stu_org> showstudentlist(Integer org_id);

    //查询社团内的学生列表
    List<Stu_org> showstudentlistFilter(Integer org_id,String stuname,String classroom);

    //查询所有的学生
    List<Student> showallstu();

    //查询所有的学生
    List<Student> showallstuFilter(String stuname,String classroom);

    //通过学号删除学生
    int delstu(String num);
}
