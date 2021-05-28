package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.News;
import com.spz.pojo.Organization;
import com.spz.pojo.Stu_org;
import com.spz.service.NewsService;
import com.spz.service.OrgService;
import com.spz.service.Stu_orgService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/news")
public class NewsController {
    @Autowired
    NewsService newsService;
    @Autowired
    OrgService orgService;
    @Autowired
    Stu_orgService stu_orgService;


    @RequestMapping("/myNews")
    public String myNews(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpServletRequest request, Model model){
        //通过学号查出学生的社团
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        Organization byManager = orgService.findByManager(studentnum);
        Integer id = byManager.getId();
        //查出社团之后获取社团id,通过社团id查看我发布的通知
        PageHelper.startPage(pn,5);
        List<News> byOrg = newsService.findByOrg(id);
        PageInfo pageInfo = new PageInfo(byOrg, 5);
        model.addAttribute("newslist",pageInfo);
        return "/jsp/manager/mynews";
    }

    @RequestMapping(value = "/editornews",method = RequestMethod.PUT)
    @ResponseBody
    public String editornews(@RequestParam("id")Integer id,@RequestParam("detail")String detail){
        //通过news的id进行修改
        int editornews = newsService.editornews(id, detail);
        if (editornews>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/delnews",method = RequestMethod.DELETE)
    @ResponseBody
    public String delnews(@RequestParam("id")Integer id){
        //通过news的id进行删除
        int delnews = newsService.delnews(id);
        if (delnews>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/createnews",method = RequestMethod.POST)
    @ResponseBody
    public String createnews(@RequestParam("detail")String detail,HttpServletRequest request){
        //获取管理员学号，通过学号查出学号所管理的社团
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        Stu_org stu_org = stu_orgService.findorgByNum(studentnum);
        int orgid = stu_org.getStu_org();
        //new一个通知，把通知内容写进通知对象中
        LocalDate now = LocalDate.now();
        News news = new News();
        news.setId(null);
        news.setDetail(detail);
        news.setOrg_num(orgid);
        news.setNewstime(now.toString());
        int createnews = newsService.createnews(news);
        if (createnews>0){
            return "ok";
        }else {
            return null;
        }
    }
}
