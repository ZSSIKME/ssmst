package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import com.spz.service.OrgService;
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
@RequestMapping("/stu")
public class studentController {
    @Autowired
    StudentService studentService;
    @Autowired
    OrgService orgService;

    @RequestMapping("showstudents")
    public String showstudents(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                               @RequestParam(value = "stu_name1",required = false)String stu_name,
                               @RequestParam(value = "classroom1",required = false)String classroom,
                               HttpServletRequest request, Model model){
        //查询需要先找到社团的id
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //通过学号进行查找stu_org中我创建的社团
        Organization byManager = orgService.findByManager(studentnum);
        Integer org_id = byManager.getId();
        //开启分页
        PageHelper.startPage(pn,7);
        //通过社团id查询所有学生
        List<Stu_org> showstudentlist = studentService.showstudentlistFilter(org_id,stu_name,classroom);
        PageInfo pageInfo = new PageInfo(showstudentlist, 7);
        model.addAttribute("studentlist",pageInfo);
        model.addAttribute("stu_name1",stu_name);
        model.addAttribute("classroom1",classroom);
        return "jsp/comm/orgstulist";
    }


    @RequestMapping(value = "/delstu_org",method = RequestMethod.DELETE)
    @ResponseBody
    //删除社团中指定的学生
    public String delstu_org(@RequestParam("stunum")String stunum,HttpServletRequest request){
        //根据管理员学号查询所管理的社团id
        //查询需要先找到社团的id
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //通过学号进行查找stu_org中我创建的社团
        Organization byManager = orgService.findByManager(studentnum);
        //根据社团id和学生id删除，社团中的指定学生
        Integer id = byManager.getId();
        int i = orgService.delstu_org(stunum, id);
        if (i>0){
            return "ok";
        }else {
            return null;
        }
    }
}
