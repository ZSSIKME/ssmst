package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.Activity;
import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.pojo.Student;
import com.spz.service.ActivityService;
import com.spz.service.GoodsService;
import com.spz.service.OrgService;
import com.spz.service.Stu_orgService;
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
import java.util.List;

@Controller
@RequestMapping("/org")
public class OrgController {
    @Autowired
    Stu_orgService stu_orgService;
    @Autowired
    OrgService orgService;
    @Autowired
    ActivityService activityService;
    @Autowired
    GoodsService goodsService;


    @RequestMapping("/stulist")
    public String showstulist(@RequestParam("num") int num,Model model){
        List<Stu_org> stu_orgs = stu_orgService.findstuByid(num);
        model.addAttribute("stulist",stu_orgs);
        model.addAttribute("stucount",stu_orgs.size());
        return "jsp/comm/org_stulist";
    }

    @RequestMapping(value = "/exit",method = RequestMethod.DELETE)
    @ResponseBody
    public String exitorg(HttpServletRequest request,@RequestParam("stu_org") Integer stu_org){
        //获取session 中的学生学号
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        //通过学号和社团id进行删除
        int exitorg = stu_orgService.exitorg(stu_num, stu_org);
        if (exitorg>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/cencel",method = RequestMethod.DELETE)
    @ResponseBody
    public String cencel(@RequestParam("org_id") Integer org_id,HttpServletRequest request){
        String stu_num = (String) request.getSession().getAttribute("studentnum");
        //取消申请，根据学号和社团，删除stu_org表中的信息，stu_statu为0
        int cencelorg = stu_orgService.cencelorg(org_id, stu_num);
        if (cencelorg>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/createorg",method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public String createorg(@RequestParam("orgname")String orgname,@RequestParam("orginfo")String orginfo,HttpServletRequest request) throws Exception {
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //获取学号后对新申请的社团进行赋值。
        Organization org = new Organization();
        org.setStatu(0);
        org.setId(null);
        org.setName(orgname);
        org.setInfo(orginfo);
        org.setManagernum(studentnum);
        LocalDate now = LocalDate.now();
        org.setCreate_time(now.toString());
        int createorg = orgService.createorg(org);
        //创建成功后要在stu_org表中添加记录，系统管理员审核成功后，stu_org表中的状态也会改变。
        //查询该社团获取社团的id
        Organization myorg = orgService.findByManager(studentnum);
        int myorg_id=myorg.getId();
        Stu_org stu_org = new Stu_org();
        stu_org.setStu_num(studentnum);
        stu_org.setStu_org(myorg_id);
        stu_org.setJion_time(now.toString());
        stu_org.setRoleID(2);//申请社团，身份是社团管理员
        //设置状态为0,等待管理员审核
        stu_org.setStu_statu(0);
        int joinorg = stu_orgService.joinorg(stu_org);
        if (createorg>0&&joinorg>0){
            return "ok";
        }else {
            //throw new Exception("失败");
            return null;
        }
    }

    //取消创建社团操作
    //取消创建社团需要把所有有关的学生、活动、物品、通知全部删除
    @RequestMapping(value = "/deleorg",method = RequestMethod.DELETE)
    @ResponseBody
    @Transactional
    public String deleorg(@RequestParam("orgid")Integer orgid){
        //删除所有有关的活动,mysql中activity中与stu_act级联，所以不用删除stu_act
       /* int i = activityService.deleactByOrgId(orgid);
        System.out.println("删除活动==="+i);
        //删除所有学生
        int i1 = stu_orgService.deleStuByorgID(orgid);
        System.out.println("删除学生：==="+i1);
        //删除物品
        int i2 = goodsService.deleGoodsByOrgId(orgid);*/

        //删除社团
        int delorg = orgService.deleOrgById(orgid);
        if (delorg>0){
            return "ok";
        }else {
            return null;
        }
    }

    //查看所有申请该社团的学生
    @RequestMapping("/apply_stu_list")
    public String apply_stu_list(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpServletRequest request,Model model){
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //根据学生学号查询出社团id
        Organization byManager = orgService.findByManager(studentnum);
        Integer id = byManager.getId();
        //根据社团id查询出所有申请该社团的学生
        PageHelper.startPage(pn,6);
        List<Stu_org> students = stu_orgService.apply_stu_list(id);
        PageInfo pageInfo = new PageInfo(students, 5);
        model.addAttribute("students",pageInfo);
        return "jsp/manager/apply_stu_list";

    }

    /**
     *
     * 同意加入社团
     * @param stu_num
     * @param stu_org
     * @return
     */
    @RequestMapping(value = "/agree",method = RequestMethod.PUT)
    @ResponseBody
    public String agree(@RequestParam("stu_num")String stu_num,@RequestParam("stu_org")Integer stu_org){
        //通过学生学号和社团学号更改状态
        int agree = orgService.agree(stu_num, stu_org);
        if (agree>0){
            return "ok";
        }else {
            return null;
        }
    }


    /**
     * 拒绝加入社团
     * @param stu_num
     * @param stu_org
     * @return
     */
    @RequestMapping(value = "/refuse",method = RequestMethod.DELETE)
    @ResponseBody
    public String refuse(@RequestParam("stu_num")String stu_num,@RequestParam("stu_org")Integer stu_org){
        //通过学生学号和社团学号从表中删除记录
        int refuse = orgService.refuse(stu_num, stu_org);
        if (refuse>0){
            return "ok";
        }else {
            return null;
        }
    }

    //修改社团信息
    @RequestMapping(value = "/alterorginfo",method = RequestMethod.PUT)
    @ResponseBody
    public String alterorginfo(@RequestParam("org_id")Integer org_id,@RequestParam("org_name")String org_name,@RequestParam("org_info")String org_info){
        int alterorginfo = orgService.alterorginfo(org_id, org_name, org_info);
        if (alterorginfo>0){
            return "ok";
        }else {
            return null;
        }
    }
}
