package com.spz.dao;

import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface Stu_orgMapper {

    //通过学号和角色id查询信息
    List<Stu_org> findByRoleAndNum(@Param("stu_num") String stu_num, @Param("roleID") int roleID);
    //通过学号查询
    List<Stu_org> findByNum(@Param("stu_num") String stu_num);
    //通过学号和状态吗查询
    List<Stu_org> fingByNumAndSta(@Param("stu_num") String stu_num,@Param("stu_statu") int stu_statu);
    //查询我加入的社团列表
    List<Stu_org> findByNumStaROle(@Param("stu_num") String stu_num,@Param("stu_statu") int stu_statu,@Param("roleID") int roleID);

    //查询社团的人数
    int findCount(@Param("stu_org") int stu_org);

    //加入社团通过学号和社团id
    int joinorg(Stu_org stu_org);


    //通过学号和社团id查询是否在这个社团
    int isjoinOrg(@Param("stu_num") String stu_num,@Param("stu_org") int stu_org);


    //通过学号查询所在的社团
    List<Student> myorglist(@Param("stu_num") String stu_num);

    //通过社团id查询所有学生
    List<Stu_org> findstuByid(@Param("id") int id);

    //通过学生学号进行退出社团操作，社团id
    int exitorg(@Param("stu_num") String stu_num,@Param("stu_org") Integer stu_org);

    //学生取消申请社团
    int cencelorg(@Param("stu_org") Integer stu_org,@Param("stu_num") String stu_num);

    //删除所有关于一个社团的学生信息
    int deleStuByorgID(@Param("org_id")Integer org_id);

    //根据社团id查询出所有申请的学生
    List<Stu_org> apply_stu_list(@Param("stu_org")Integer stuorg);

    //通过学生学号查询管理的社团
    Stu_org findorgByNum(@Param("stu_num")String stu_num);

    //通过学号查询是否为管理员
    int is_manager(@Param("stu_num")String stu_num);

    //同意社团的创建申请，将stu_org中的状态设置为1
    int a_agreeorg(@Param("stu_org")Integer stu_org,@Param("stu_num")String stu_num);

    //拒绝社团申请删除记录
    int a_rejectorg(@Param("stu_org")Integer stu_org,@Param("stu_num")String stu_num);
}