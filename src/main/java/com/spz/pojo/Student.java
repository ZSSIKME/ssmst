package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Student {
    private String num;     //学号
    private String name;    //名字
    private String sex;     //性别
    private String pwd;     //密码
    private String classroom;//班级
    private int age;        //年龄
    private String IdCard;  //身份证
    private String phone; //电话号码

    //学生与社团是多对多的关系
    private List<Organization> organizationList;
    //与stu_org也是多对多关系
}
