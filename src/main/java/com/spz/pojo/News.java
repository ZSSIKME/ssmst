package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class News {

    private Integer id;
    private String detail;
    private int org_num;
    private String newstime;

    //
    private Organization organization;
}
