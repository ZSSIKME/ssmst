package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Activity {
    private Integer id;
    private String name;
    private String info;
    private String ma_num;
    private int org_id;
    private String place;
    private String act_time;
    private String act_end_time;
    //活动与社团是一对一的关系
    private Organization organization;
    private Student student;
}
