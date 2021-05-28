package com.spz.service;

import com.spz.pojo.News;
import com.spz.pojo.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsService {
    //通过社团查询所有的通知消息
    List<News> findByOrg (int org_num);

    //通过学号和角色查询所有的消息
   List<News> findBystuNumAndRole(String num, Integer stu_statu);

    //通过学号和角色查询所有的消息按照条件
    List<News> findBystuNumAndRoleFilter(String num,Integer stu_statu,String orgname);

    //通过通知id进行修改detail
    int editornews(Integer id,String detail);

    //通过news的id删除记录
    int delnews(Integer id);

    //发布新的通知
    int createnews(News news);
}
