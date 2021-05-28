package com.spz.dao;

import com.spz.pojo.News;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsMapper {

    //通过社团查询所有的通知消息
    List<News> findByOrg(@Param("org_num")int org_num);

    //通过学号和角色查询所有的消息
    List<News> findBystuNumAndRole(@Param("stu_num") String num, @Param("stu_statu") Integer stu_statu);

    //通过学号和角色查询所有的消息按照条件
    List<News> findBystuNumAndRoleFilter(@Param("stu_num") String num, @Param("stu_statu") Integer stu_statu,@Param("orgname")String orgname);

    //通过通知id进行修改detail
    int editornews(@Param("id")Integer id,@Param("detail")String detail);

    //通过news的id删除记录
    int delnews(@Param("id")Integer id);

    //发布新的通知
    int createnews(News news);
}
