package com.spz.controller;

import com.spz.pojo.Student;
import com.spz.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/regist")
public class RegistController {
    @Autowired
    StudentService studentService;

    @RequestMapping("/add")
    public String addStudent(Student student, HttpServletRequest request){
        int i = studentService.addStudent(student);
        if (i>0){
            request.getSession().setAttribute("msg","注册成功，返回登陆");
            request.getSession().setAttribute("url","/jsp/login.jsp");
            return "jsp/success";
        }else {
            request.getSession().setAttribute("msg","注册失败，请重试");
            request.getSession().setAttribute("url","/jsp/regist.jsp");
            return "jsp/error";
        }
    }
}
