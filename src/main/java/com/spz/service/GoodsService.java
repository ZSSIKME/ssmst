package com.spz.service;

import com.spz.pojo.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsService {
    //通过社团id删除所有关于社团的物品
    int deleGoodsByOrgId(Integer org_id);
    //显示所有社团的物品
    List<Goods> showallGoogs(Integer org_id);

    //显示所有社团的物品
    List<Goods> showallGoogsName(Integer org_id,String GoodsName);

    //通过id查询物品
    Goods findGoodsByid(Integer id);

    //修改社团中物品的信息
    int alterGoods(Integer id,String name,Integer num);

    //通过物品id删除物品
    int delgoods(Integer id);

    //添加物品信息
    int addgoods(String name,Integer num,Integer organiza);
}
