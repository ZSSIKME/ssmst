package com.spz.dao;

import com.spz.pojo.Goods;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsMapper {

    //通过社团id删除所有关于社团的物品
    int deleGoodsByOrgId(@Param("org_id")Integer org_id);

    //显示所有社团的物品
    List<Goods> showallGoogs(@Param("org_id")Integer org_id);

    //显示所有社团的物品
    List<Goods> showallGoogsName(@Param("org_id")Integer org_id,@Param("GoodsName")String GoodsName);

    //通过id查询物品
    Goods findGoodsByid(@Param("id")Integer id);

    //修改社团中物品的信息
    int alterGoods(@Param("id")Integer id,@Param("name") String name,@Param("num")Integer num);

    //通过物品id删除物品
    int delgoods(@Param("id")Integer id);

    //添加物品信息
    int addgoods(@Param("name")String name,@Param("num")Integer num,@Param("organiza")Integer organiza);
}
