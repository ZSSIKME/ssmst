package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Stu_act {
    private String stu_num;
    private int act_id;
    private String sign;

    private Activity activity;
    private Student  student;
}
