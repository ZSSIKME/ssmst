package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.*;
import com.spz.service.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/comm")
public class commController {
    @Autowired
    StudentService studentService;
    @Autowired
    Stu_orgService stu_orgService;
    @Autowired
    OrgService orgService;
    @Autowired
    ActivityService activityService;
    @Autowired
    Stu_actService stu_actService;
    @Autowired
    NewsService newsService;

    @RequestMapping("/alterinfo")
    @ResponseBody
    public String addStudent(Student student, HttpServletRequest request){
        System.out.println("更改成员信息："+student);
        int i = studentService.alterinfo(student);
        System.out.println("修改记录数："+i);
        if (i>0){
            System.out.println("密码修改成功");
            //成功之后跳转登陆页，清空session
            //request.getSession().invalidate();
            request.getSession().setAttribute("msg","修改成功，请返回重新登陆！");
            request.getSession().setAttribute("url","/jsp/login.jsp");
            return "ok";
        }else {
            System.out.println("修改失败");
            return null;
        }
    }
    //查询学生信息
    @RequestMapping("/stuinfo")
    public String stuinfo(HttpServletRequest request,Model model){
        String num = (String) request.getSession().getAttribute("studentnum");
        Student stu = studentService.findByNum(num);
        System.out.println(stu);
        model.addAttribute("stuinfo",stu);
        return "jsp/comm/stuinfo";
    }

    //查询我的社团信息
    @RequestMapping("/myorginfo")
    public String myorginfo(HttpServletRequest request, Model model){
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        int stu_statu=1;
        System.out.println("学生学号："+stu_num);
        List<Stu_org> stu_orgs = stu_orgService.findByNumStaROle(stu_num,stu_statu,1);
        System.out.println(stu_orgs);
        model.addAttribute("stu_org",stu_orgs);
        return "jsp/comm/myorginfo";
    }

    //查询我申请的社团
    @RequestMapping("/myapply")
    public String myapply(HttpServletRequest request, Model model){
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        List<Stu_org> stu_orgs = stu_orgService.fingByNumAndSta(stu_num,0);
        model.addAttribute("applyOrgs",stu_orgs);
        return "jsp/comm/myapply";
    }

    //查询所有社团
    @RequestMapping("/orglist")
    public String orglist(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          @RequestParam(value = "name",required = false)String name,
                          @RequestParam(value = "stu_name",required = false)String stu_name,
                          Model model){
        //分页查询
        PageHelper.startPage(pn,6);
        List<Organization> organizations = orgService.findallbyName(name, stu_name);
        //使用pageinfo包装查询后的结果
        PageInfo orgList = new PageInfo(organizations,5);
        model.addAttribute("orglist",orgList);
        model.addAttribute("name",name);
        model.addAttribute("stu_name",stu_name);
        return "jsp/comm/orglist";
    }

    //查询活动列表
    @RequestMapping("/actlist")
    public String actlist(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          @RequestParam(value = "ActName",required = false)String act_name,
                          @RequestParam(value = "OrgName",required = false)String org_name,
                          @RequestParam(value = "StuName",required = false)String stu_name,
                          Model model){
        PageHelper.startPage(pn,7);
        List<Activity> activities = activityService.findBynames(act_name,org_name,stu_name);
        PageInfo pageInfo = new PageInfo(activities, 5);
        model.addAttribute("actlist",pageInfo);
        model.addAttribute("ActName",act_name);
        model.addAttribute("OrgName",org_name);
        model.addAttribute("StuName",stu_name);
        return "jsp/comm/actlist";
    }

    //通过社团中社长学号查询社长名字
    @RequestMapping("/showMa")
    @ResponseBody
    public HashMap showMa(@RequestParam("num") String num){
        HashMap<String, Object> map = new HashMap<>();
        Student student = studentService.findByNum(num);
        String managernum=num;
        Organization org = orgService.findByManager(managernum);
        int stu_org=org.getId();
        int count = stu_orgService.findCount(stu_org);
        map.put("manager",student);
        map.put("org",org);
        map.put("count",count);
        System.out.println("社团：=="+org);
        System.out.println("管理员：=="+student);
        return map;
    }

    //查询我的活动
    @RequestMapping("/myact")
    public String myact(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                        @RequestParam(value = "actname1",required = false)String actname,
                        Model model,HttpServletRequest request){
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        PageHelper.startPage(pn,7);
        List<Stu_act> actidList = stu_actService.findBynumName(stu_num,actname);
       // System.out.println("我的活动"+actidList.size());
        PageInfo pageInfo = new PageInfo(actidList, 7);
        model.addAttribute("myactlist",pageInfo);
        model.addAttribute("actname1",actname);
        return "jsp/comm/myact";
    }

    //查询我创建的社团
    @RequestMapping("/mycreateorg")
    public String mycreateorg(HttpServletRequest request,Model model){

        String managernum = (String) request.getSession().getAttribute("studentnum");
        Organization mycreOrg = orgService.findByManager(managernum);
        model.addAttribute("mycreOrg",mycreOrg);
        return "jsp/comm/mycreorg";
    }

    //查询我的通知
    @RequestMapping("/mynews")
    public String mynews(@RequestParam(value = "OrgName1",required = false)String orgname,
                         HttpServletRequest request,Model model){
        String stu_num = (String) request.getSession().getAttribute("studentnum");
       /* //通过学号和在社团状态查询该学生的社团列表
        List<Stu_org> stu_orgs = stu_orgService.fingByNumAndSta(stu_num, 1);
        //查询该学生所在所有社团的所有消息
        //存储所有消息
        final ArrayList<List<News>> newslist = new ArrayList<>();

        //遍历所在社团，使用社团id进行通知查询
        for (Stu_org stu_org : stu_orgs) {
            int org_num = stu_org.getStu_org();
            //获取社团的通知信息
            List<News> news = newsService.findByOrg(org_num);
            newslist.add(news);
        }*/
        List<News> newslist = newsService.findBystuNumAndRoleFilter(stu_num,1,orgname);
        //System.out.println("查询到的社团消息：================="+newslist);
        model.addAttribute("newslist",newslist);
        model.addAttribute("OrgName1",orgname);
        return "jsp/comm/newslist";
    }

    //加入社团
    @RequestMapping(value = "/joinorg",method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public String joinorg(@RequestParam("org_id")int org_id,HttpServletRequest request){
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        //时间
        LocalDate now = LocalDate.now();
        Stu_org stu_org = new Stu_org();
        stu_org.setRoleID(1);
        stu_org.setStu_num(stu_num);
        stu_org.setStu_org(org_id);
        stu_org.setStu_statu(0);
        stu_org.setJion_time(now.toString());
        //加入社团前先查看是否存在，存在则返回错误，不存在则加入
        //已加入，或待审核，通过学号查看
        int i = stu_orgService.isjoinOrg(stu_num, org_id);
        if (i>0){
            return null;
        }else {
            int joinorgnum = stu_orgService.joinorg(stu_org);
            if (joinorgnum>0){
                return "success";
            }else {
                return "wrong";
            }
        }
    }

    //通过id查询活动详细信息。
    @RequestMapping("/actinfo")
    @ResponseBody
    public Activity actinfo(@RequestParam("actid") Integer actid,Model model){
        Activity byId = activityService.findById(actid);
        return byId;
    }

    //加入活动
    @RequestMapping(value = "/joinact",method = RequestMethod.POST)
    @ResponseBody
    public String joinact(@RequestParam("actid") Integer act_id,HttpServletRequest request){
        //加入活动，通过学号和活动id
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        //加入之前先查询表中是否已经添加过该活动，如果有就返回添加失败，，通过学号和活动id进行查询
        int count = stu_actService.isjoinByid(stu_num, act_id);
        if (count==0){
            int i = stu_actService.joinact(stu_num, act_id);
            if (i>0){
                return "ok";
            }else {
                return null;
            }
        }else {
            return null;
        }
    }
    @RequestMapping(value = "/signinact",method = RequestMethod.PUT)
    @ResponseBody
    public String signinact(@RequestParam("actid") Integer act_id,HttpServletRequest request){
        //获取学生id
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //进行签到
        int signinact = stu_actService.signinact(studentnum, act_id);
        if (signinact>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/cancelact",method = RequestMethod.DELETE)
    @ResponseBody
    public String cancenact(@RequestParam("actid")Integer act_id,HttpServletRequest request){
        //获取学生id
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        System.out.println("============================================================");
        //删除记录
        int cancelact = stu_actService.cancelact(studentnum, act_id);
        System.out.println("删除记录数："+cancelact);
        if (cancelact>0){
            return "ok";
        }else {
            return null;
        }
    }
}