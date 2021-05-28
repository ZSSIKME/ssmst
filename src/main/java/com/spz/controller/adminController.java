package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.*;
import com.spz.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class adminController {
    @Autowired
    AdminService adminService;
    @Autowired
    OrgService orgService;
    @Autowired
    StudentService studentService;
    @Autowired
    Stu_orgService stu_orgService;
    @Autowired
    ActivityService activityService;

    //直接显示欢迎系统管理员的界面
    @RequestMapping(value = "/alterinfo",method = RequestMethod.PUT)
    @ResponseBody
    public String admininfo(@RequestParam("pwd")String pwd){
        //获取系统管理员的名字
        //通过管理员名字进行修改
        int updateinfo = adminService.updatePwd(pwd);
        if (updateinfo>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping("/orgman")
    public String orgman(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                         @RequestParam (value = "Orgname1",required = false)String orgname,
                         @RequestParam(value = "orgmana1",required = false)String orgmana,
                         Model model){
        //分页查询
        PageHelper.startPage(pn,6);
        List<Organization> organizations = orgService.findallFilter(orgname,orgmana);
        //使用pageinfo包装查询后的结果
        PageInfo orgList = new PageInfo(organizations,5);
        model.addAttribute("orglist",orgList);
        model.addAttribute("Orgname1",orgname);
        model.addAttribute("orgmana1",orgmana);
        return "jsp/admin/orgmanager";
    }


    @RequestMapping("/showstus")
    public String showstus(@RequestParam(value = "pn",defaultValue = "1")Integer pn,@RequestParam("org_id")Integer org_id,Model model){
        //通过社团id查询出所有该社团的成员
        PageHelper.startPage(pn,7);
        //通过社团id查询所有学生
        List<Stu_org> showstudentlist = studentService.showstudentlist(org_id);
        PageInfo pageInfo = new PageInfo(showstudentlist, 7);
        model.addAttribute("studentlist",pageInfo);
        model.addAttribute("org_id",org_id);
        return "jsp/admin/a_orgstulist";
    }

    @RequestMapping(value = "/delorgstu",method = RequestMethod.DELETE)
    @ResponseBody
    public String delorgstu(@RequestParam("stu_num")String stu_num,@RequestParam("org_id")Integer org_id){
        //通过学生学号和社团id删除学生
        int exitorg = stu_orgService.exitorg(stu_num, org_id);
        if (exitorg>0){
            return "ok";
        }else {
            return null;
        }
    }

    //查询活动列表
    @RequestMapping("/actlist")
    public String actlist(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          @RequestParam(value = "findActName",required = false)String actname,
                          @RequestParam(value = "findActMana",required = false) String actmana,
                          Model model){
        PageHelper.startPage(pn,7);
        List<Activity> activities = activityService.findallFilter(actname,actmana);
        PageInfo pageInfo = new PageInfo(activities, 5);
        model.addAttribute("actlist",pageInfo);
        model.addAttribute("findActName",actname);
        model.addAttribute("findActMana",actmana);
        return "jsp/admin/act/a_actmanager";
    }

    //管理员删除活动
    @RequestMapping(value = "delact",method = RequestMethod.DELETE)
    @ResponseBody
    public String delact(@RequestParam("actid")Integer actid){
        //通过活动id直接删除
        int delact = activityService.delact(actid);
        if (delact>0){
            return "ok";
        }else {
            return null;
        }
    }

    //管理员查看所有学生并管理。
    @RequestMapping("/allstu")
    public String showallstu(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                             @RequestParam(value = "findstuName",required = false)String stuname,
                             @RequestParam(value = "findstuClass",required = false)String classroom,
                             Model model){
        PageHelper.startPage(pn,5);
        List<Student> showallstu = studentService.showallstuFilter(stuname,classroom);
        PageInfo pageInfo = new PageInfo(showallstu, 5);
        model.addAttribute("stulist",pageInfo);
        model.addAttribute("findstuName",stuname);
        model.addAttribute("findstuClass",classroom);
        return "jsp/admin/a_stu_manager";
    }

    //管理员删除学生
    @RequestMapping(value = "/delstu",method = {RequestMethod.GET,RequestMethod.DELETE})
    @ResponseBody
    public String delstu(@RequestParam("num")String num){
        //删除学生前需要查看是否是社团管理员
        int manager = stu_orgService.is_manager(num);
        if (manager>0){
            //是管理员返回null
            return "warn";
        }else if (manager==0){
            //不是管理员可以删除
            int delstu = studentService.delstu(num);
            if (delstu>0){
                return "ok";
            }else {
                return null;
            }
        }else {
            return null;
        }
    }

    //管理员修改学生信息
    @RequestMapping(value = "/alterstuinfo",method = RequestMethod.PUT)
    @ResponseBody
    public String alterstuinfo(Student student){
        int alterinfo = studentService.alterinfo(student);
        if (alterinfo>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping("/show_apply_org")
    public String show_apply_org(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
        //查询所有正在申请的社团。
        List<Stu_org> stu_orgs = orgService.show_apply_org();
        PageInfo pageInfo = new PageInfo(stu_orgs, 5);
        model.addAttribute("applyorgs",pageInfo);
        return "jsp/admin/apply_org";
    }

    //同意社团申请
    @RequestMapping(value = "/agreeorg",method = RequestMethod.PUT)
    @ResponseBody
    @Transactional
    public String agreeorg(@RequestParam("orgid")Integer orgid,@RequestParam("stunum")String stunum){
        //同意申请先查看该学生是否已经是社团管理员。
        //同意先设置organization的状态为1
        int i = orgService.a_agreeorg(orgid);
        if (i>0){
            //将stu_org里的状态设置为1（通过学号和社团id。
            int i1 = stu_orgService.a_agreeorg(orgid, stunum);
            if (i1>0){
                return "ok";
            }else{
                return null;
            }
        }else {
            return null;
        }
    }

    //拒绝社团申请
    @RequestMapping(value = "/rejectorg",method = RequestMethod.DELETE)
    @ResponseBody
    public String rejectorg(@RequestParam("orgid")Integer orgid,@RequestParam("stunum")String stunum){
        //删除organization表中的记录
        int deleOrgById = orgService.deleOrgById(orgid);
        if (deleOrgById>0){
            return "ok";
        }else {
            return null;
        }
    }
}
