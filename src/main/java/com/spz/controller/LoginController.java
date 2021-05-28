package com.spz.controller;

import com.spz.pojo.Admin;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import com.spz.service.AdminService;
import com.spz.service.Stu_orgService;
import com.spz.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    AdminService adminService;
    @Autowired
    StudentService studentService;
    @Autowired
    Stu_orgService stu_orgService;


    @RequestMapping("/findAdmin")
    @ResponseBody
    public String SystemLogin(Admin admin, HttpServletRequest request){
        Admin sys = adminService.findSys(admin);
        if (sys!=null){
            request.getSession().setAttribute("username",admin.getName());
            return "ok";
        }else{
            return null;
        }
    }
    @RequestMapping("/findManager")
    @ResponseBody
    public  String ManagerLogin(String num, String pwd, HttpServletRequest request){
        int roleID=2;
        Student stu = studentService.findByNum(num);
        if (stu==null){
            return null;
        }
        System.out.println(stu);
        String stu_num=num;
        List<Stu_org> byRoleAndNum = stu_orgService.findByRoleAndNum(stu_num,roleID);
        System.out.println(byRoleAndNum);
        //判断密码和是否存在该社团角色
        if (stu.getPwd().equals(pwd)&&byRoleAndNum.size()>0){
            System.out.println("管理员登录"+num);
            request.getSession().setAttribute("studentnum",stu.getNum());
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping("/findStudent")
    @ResponseBody
    public  String StudentLogin(String num,String pwd,HttpServletRequest request){
        int roleID=1;
        Student stu = studentService.findByNum(num);
        if (stu==null){
            return null;
        }
        System.out.println(stu);
        String stu_num=num;
        List<Stu_org> byRoleAndNum = stu_orgService.findByRoleAndNum(stu_num,roleID);
        System.out.println(byRoleAndNum);
        //判断密码和是否存在该社团角色
        if (stu.getPwd().equals(pwd)&&byRoleAndNum.size()>0){
            request.getSession().setAttribute("studentnum",stu.getNum());
            System.out.println("登录用户学号："+stu.getNum());
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping("/findStudent1")
    @ResponseBody
    public  String Student1Login(String num,String pwd,HttpServletRequest request){
        //登陆前先清空session信息
        request.getSession().invalidate();
        Student stu = studentService.findByNum(num);
        if (stu==null){
            return null;
        }
        //System.out.println(stu.getPwd());
        String stu_num=num;
        //新成员在stu_org中查询不到信息，查询条件为，在该表中是否存在该学号，或者在该表中的状态是否为1（1
        List<Stu_org> byRoleAndNum = stu_orgService.fingByNumAndSta(stu_num,1);
        //新成员不应该查询到社团信息。
        if (stu.getPwd().equals(pwd)&&byRoleAndNum.size()==0){
            System.out.println(stu_num+stu.getName()+"新成员匹配成功,登陆系统");
            //session存储stu的信息
            request.getSession().setAttribute("studentnum",stu.getNum());
            //存储所有社团的信息
            return "ok";
        }else {
            System.out.println("匹配失败");
            return null;
        }
    }
    @RequestMapping("/forgetpwd")
    @ResponseBody
    public String forgetpwd(String num,String IdCard,String name,String phone,HttpServletRequest request){
        Student checkstu = studentService.checkstu(num, IdCard, name, phone);
        if (checkstu!=null){
            //将验证成功的学生学号存到session中，修改时直接取值
            request.getSession().setAttribute("num",checkstu.getNum());
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/updatepwd",method = RequestMethod.PUT)
    @ResponseBody
    public String updatepwd(String num,String pwd){
        int updatepwd = studentService.updatepwd(num, pwd);
        System.out.println("修改记录数:===="+updatepwd);
        if (updatepwd>0){
            return "ok";
        }else {
            return null;
        }
    }

}