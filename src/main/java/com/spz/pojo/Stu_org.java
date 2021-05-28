package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.beans.Transient;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Stu_org {
    private String stu_num; //学号
    private int stu_org;       //社团id
    private String jion_time;    //加入社团时间
    private int roleID;         //在社团中的角色
    private int stu_statu;        //加入社团的状态，0为审核中，1为以通过


    //多对一的关系
    private Organization organization;
    private Student student;
}