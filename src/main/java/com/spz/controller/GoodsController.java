package com.spz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spz.pojo.Goods;
import com.spz.pojo.Organization;
import com.spz.service.GoodsService;
import com.spz.service.OrgService;
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
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    GoodsService goodsService;
    @Autowired
    OrgService orgService;


    /**
     * 通过社团id查询社团的所有物品信息
     */
    @RequestMapping("/showall")
    public String showallgoods(@RequestParam(value = "pn" ,defaultValue = "1")Integer pn,
                               @RequestParam(value = "goods_name",required = false)String goodsname,
                               HttpServletRequest request, Model model){
        //查询需要先找到社团的id
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //通过学号进行查找stu_org中我创建的社团
        Organization byManager = orgService.findByManager(studentnum);
        Integer org_id = byManager.getId();
        PageHelper.startPage(pn,7);
        List<Goods> goods = goodsService.showallGoogsName(org_id,goodsname);
        PageInfo pageInfo = new PageInfo(goods, 7);
        model.addAttribute("goodslist",pageInfo);
        model.addAttribute("goods_name",goodsname);
        return "jsp/comm/goodslist";
    }

/*    @RequestMapping("findgoods")
    @ResponseBody
    public Goods findgoods(@RequestParam("goodsid")Integer goodsid,Model model){
        Goods goodsByid = goodsService.findGoodsByid(goodsid);
        model.addAttribute("goodinfo",goodsByid);
        return goodsByid;
    }*/

    @RequestMapping("/altergoods")
    @ResponseBody
    public String alterGoods(@RequestParam("id")Integer id,@RequestParam("name") String name,@RequestParam("num") Integer num){
        int i = goodsService.alterGoods(id, name, num);
        if (i>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/delgoods",method = RequestMethod.DELETE)
    @ResponseBody
    public String delgoods(@RequestParam("id")Integer id){
        //通过物品id删除
        int delgoods = goodsService.delgoods(id);
        if (delgoods>0){
            return "ok";
        }else {
            return null;
        }
    }

    @RequestMapping(value = "/addgoods",method = RequestMethod.POST)
    @ResponseBody
    public String addgoods(@RequestParam("name")String name,@RequestParam("num")Integer num,HttpServletRequest request){
        String studentnum = (String) request.getSession().getAttribute("studentnum");
        //通过学号进行查找stu_org中我创建的社团
        Organization byManager = orgService.findByManager(studentnum);
        Integer org_id = byManager.getId();
        int addgoods = goodsService.addgoods(name, num, org_id);
        if (addgoods>0){
            return "ok";
        }else {
            return null;
        }
    }

}
