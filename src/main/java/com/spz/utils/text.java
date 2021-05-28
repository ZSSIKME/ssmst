package com.spz.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;


public class text {
    public static void main(String[] args) {
        LocalDateTime now = LocalDateTime.now();
        System.out.println(now);
        LocalDate now1 = LocalDate.now();
        System.out.println(now1.toString());
    }
}
