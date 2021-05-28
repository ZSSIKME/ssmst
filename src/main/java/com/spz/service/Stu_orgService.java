package com.spz.service;

import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface Stu_orgService {
    List<Stu_org> findByRoleAndNum(String stu_num, int roleID);

    //通过学号查询
    List<Stu_org> findByNum(String stu_num);

    //通过学号和状态吗查询
    List<Stu_org> fingByNumAndSta(String stu_num,int stu_statu);

    //查询社团的人数
    int findCount(int stu_org);
    //加入社团通过学号和社团id
    int joinorg(Stu_org stu_org);

    //通过学号和社团id查询是否在这个社团
    int isjoinOrg(String stu_num,int stu_org);

    //查询我加入的社团列表
    List<Stu_org> findByNumStaROle( String stu_num, int stu_statu, int roleID);

    //通过社团id查询所有学生
    List<Stu_org> findstuByid(int id);

    //通过学生学号进行退出社团操作，社团id
    int exitorg(String stu_num,Integer stu_org);
    //学生取消申请社团
    int cencelorg(Integer stu_org,String stu_num);

    //删除所有关于一个社团的学生信息
    int deleStuByorgID(Integer org_id);

    //根据社团id查询出所有申请的学生
    List<Stu_org> apply_stu_list(Integer stuorg);

    //通过学生学号查询管理的社团
    Stu_org findorgByNum(String stu_num);

    //通过学号查询是否为管理员
    int is_manager(String stu_num);

    //同意社团的创建申请，将stu_org中的状态设置为1
    int a_agreeorg(Integer stu_org,String stu_num);

    //拒绝社团申请删除记录
    int a_rejectorg(Integer stu_org,String stu_num);
}