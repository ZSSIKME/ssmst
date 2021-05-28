package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Organization {
    private Integer id;     //社团id
    private int statu; //社团状态
    private String name;    //社团名字
    private String info;    //社团简介
    private String managernum;  //社团管理员
    private String create_time; //创建社团的时间


    //社团与管理员是一对一的关系
    private Student manager;

    //社团与学生是多对多的关系
    private List<Student> studentList;
    //社团与物品时一对多的关系
    private List<Goods> goodsList;

    //社团与news是一对多关系
    private List<News> newsList;
}
