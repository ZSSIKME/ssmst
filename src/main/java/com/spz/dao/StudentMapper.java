package com.spz.dao;

import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentMapper {
    //添加学生
    int addStudent(Student student);

    //通过学号查询学生信息
    Student findByNum(@Param("num") String num);

    //验证学生信息
    Student checkstu(@Param("num")String num,
                     @Param("IdCard") String IdCard,
                     @Param("name") String name,
                     @Param("phone") String phone);

    //更改学生密码
    int updatepwd(@Param("num")String num,@Param("pwd")String pwd);

    //修改学生信息
    int alterinfo(Student student);

    //通过学号查询社团信息

    //查询社团内的学生列表
    List<Stu_org> showstudentlist(@Param("org_id") Integer org_id);

    //查询社团内的学生列表
    List<Stu_org> showstudentlistFilter(@Param("org_id") Integer org_id,@Param("stu_name")String stuname,@Param("classroom")String classroom);

    //查询所有的学生
    List<Student> showallstu();

    //查询所有的学生
    List<Student> showallstuFilter(@Param("stuname")String stuname,@Param("classroom")String classroom);

    //通过学号删除学生
    int delstu(@Param("num")String num);
}