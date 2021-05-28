package com.spz.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * 管理员信息表
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Admin {
    private String name;
    private String pwd;
}
