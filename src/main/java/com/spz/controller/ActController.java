package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.Activity;
import com.spz.pojo.Stu_act;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import com.spz.service.ActivityService;
import com.spz.service.Stu_orgService;
import com.spz.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/act")
public class ActController {
    @Autowired
    ActivityService activityService;
    @Autowired
    StudentService studentService;
    @Autowired
    Stu_orgService stu_orgService;

    //发布de活动
    @RequestMapping("/myact")
    public String myact(@RequestParam(value = "pn" ,defaultValue = "1")Integer pn,HttpServletRequest request, Model model){
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        Student stu = studentService.findByNum(studentnum);
        //分页查询
        PageHelper.startPage(pn,7);
        //通过学号查询我已经创建的活动
        List<Activity> actBynum = activityService.findActBynum(studentnum);
        PageInfo pageInfo = new PageInfo(actBynum, 7);
        model.addAttribute("myactlist",pageInfo);
        model.addAttribute("stu",stu);
        return "jsp/manager/myact";
    }


    //通过活动id查看活动参加的学生
    @RequestMapping("/stulist")
    public String stulist(@RequestParam("act_id")Integer act_id,Model model){
        //查询活动的学生
        List<Stu_act> stu_acts = activityService.showAct_stuList(act_id);
        System.out.println(stu_acts.size());
        model.addAttribute("stulist",stu_acts);
        return "jsp/manager/actstudents";
    }

    //创建活动
    @RequestMapping(value = "/createact",method = RequestMethod.POST)
    @ResponseBody
    public String createact(@RequestParam("name")String name,
                            @RequestParam("info")String info,
                            @RequestParam("place")String place,
                            @RequestParam("act_time")String act_time,
                            @RequestParam("act_end_time")String act_end_time,
                            HttpServletRequest request){
        //通过学号获取学生的管理社团
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        Stu_org stu_org = stu_orgService.findorgByNum(studentnum);
        int orgid = stu_org.getStu_org();
        //添加orgid
        Activity activity = new Activity();
        activity.setId(null);
        activity.setName(name);
        activity.setInfo(info);
        activity.setMa_num(studentnum);
        activity.setOrg_id(orgid);
        activity.setPlace(place);
        activity.setAct_time(act_time);
        activity.setAct_end_time(act_end_time);

        //进行创建
        int creatact = activityService.creatact(activity);
        if (creatact>0){
            return "ok";
        }else {
            return null;
        }
    }

    //修改社团信息
    @RequestMapping(value = "/alteract",method = RequestMethod.PUT)
    @ResponseBody
    public String acertact(@RequestParam("id")Integer actid,
                           @RequestParam("name")String name,
                           @RequestParam("info")String info,
                           @RequestParam("place")String place,
                           @RequestParam("act_time")String act_time,
                           @RequestParam("act_end_time")String act_end_time,
                           HttpServletRequest request){
        //通过学号获取学生的管理社团
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        Stu_org stu_org = stu_orgService.findorgByNum(studentnum);
        int orgid = stu_org.getStu_org();
        //添加orgid
        Activity activity = new Activity();
        activity.setId(actid);
        activity.setName(name);
        activity.setInfo(info);
        activity.setMa_num(studentnum);
        activity.setOrg_id(orgid);
        activity.setPlace(place);
        activity.setAct_time(act_time);
        activity.setAct_end_time(act_end_time);
        //修改社团信息
        int alertact = activityService.alertact(activity);
        if (alertact>0){
            return "ok";
        }else {
            return null;
        }
    }
}
