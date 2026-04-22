package com.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import java.lang.*;
import java.math.*;
import com.utils.*;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.annotation.IgnoreAuth;

import com.entity.YouhuihuodongEntity;
import com.entity.view.YouhuihuodongView;

import com.service.YouhuihuodongService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.utils.MapUtils;
import com.utils.CommonUtil;
import java.io.IOException;

/**
 * 优惠活动
 * 后端接口
 * @author 
 * @email 
 * @date 2026-01-08 13:29:31
 */
@RestController
@RequestMapping("/youhuihuodong")
public class YouhuihuodongController {
    @Autowired
    private YouhuihuodongService youhuihuodongService;










    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,YouhuihuodongEntity youhuihuodong,
		HttpServletRequest request){
        //设置查询条件
        EntityWrapper<YouhuihuodongEntity> ew = new EntityWrapper<YouhuihuodongEntity>();


        //查询结果
		PageUtils page = youhuihuodongService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, youhuihuodong), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }


    /**
     * 前台列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,YouhuihuodongEntity youhuihuodong,
                @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date huodongriqistart,
                @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date huodongriqiend,
                @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date fabushijianstart,
                @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date fabushijianend,
                @RequestParam(required = false) Double thumbsupnumstart,
                @RequestParam(required = false) Double thumbsupnumend,
                @RequestParam(required = false) Double crazilynumstart,
                @RequestParam(required = false) Double crazilynumend,
		HttpServletRequest request){
        //设置查询条件
        EntityWrapper<YouhuihuodongEntity> ew = new EntityWrapper<YouhuihuodongEntity>();
        if(huodongriqistart!=null) ew.ge("huodongriqi", huodongriqistart);
        if(huodongriqiend!=null) ew.le("huodongriqi", huodongriqiend);
        if(fabushijianstart!=null) ew.ge("fabushijian", fabushijianstart);
        if(fabushijianend!=null) ew.le("fabushijian", fabushijianend);
        if(thumbsupnumstart!=null) ew.ge("thumbsupnum", thumbsupnumstart);
        if(thumbsupnumend!=null) ew.le("thumbsupnum", thumbsupnumend);
        if(crazilynumstart!=null) ew.ge("crazilynum", crazilynumstart);
        if(crazilynumend!=null) ew.le("crazilynum", crazilynumend);

        //查询结果
		PageUtils page = youhuihuodongService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, youhuihuodong), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }




	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( YouhuihuodongEntity youhuihuodong){
       	EntityWrapper<YouhuihuodongEntity> ew = new EntityWrapper<YouhuihuodongEntity>();
      	ew.allEq(MPUtil.allEQMapPre( youhuihuodong, "youhuihuodong"));
        return R.ok().put("data", youhuihuodongService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(YouhuihuodongEntity youhuihuodong){
        EntityWrapper< YouhuihuodongEntity> ew = new EntityWrapper< YouhuihuodongEntity>();
 		ew.allEq(MPUtil.allEQMapPre( youhuihuodong, "youhuihuodong"));
		YouhuihuodongView youhuihuodongView =  youhuihuodongService.selectView(ew);
		return R.ok("查询优惠活动成功").put("data", youhuihuodongView);
    }

    /**
     * 后台详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        YouhuihuodongEntity youhuihuodong = youhuihuodongService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(youhuihuodong,deSens);
        return R.ok().put("data", youhuihuodong);
    }

    /**
     * 前台详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        YouhuihuodongEntity youhuihuodong = youhuihuodongService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(youhuihuodong,deSens);
        return R.ok().put("data", youhuihuodong);
    }



    /**
     * 赞或踩
     */
    @RequestMapping("/thumbsup/{id}")
    public R vote(@PathVariable("id") String id,String type){
        YouhuihuodongEntity youhuihuodong = youhuihuodongService.selectById(id);
        if(type.equals("1")) {
        	youhuihuodong.setThumbsupnum(youhuihuodong.getThumbsupnum()+1);
        } else {
        	youhuihuodong.setCrazilynum(youhuihuodong.getCrazilynum()+1);
        }
        youhuihuodongService.updateById(youhuihuodong);
        return R.ok("投票成功");
    }

    /**
     * 后台保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody YouhuihuodongEntity youhuihuodong, HttpServletRequest request){
        //ValidatorUtils.validateEntity(youhuihuodong);
        youhuihuodongService.insert(youhuihuodong);
        return R.ok().put("data",youhuihuodong.getId());
    }

    /**
     * 前台保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody YouhuihuodongEntity youhuihuodong, HttpServletRequest request){
        //ValidatorUtils.validateEntity(youhuihuodong);
        youhuihuodongService.insert(youhuihuodong);
        return R.ok().put("data",youhuihuodong.getId());
    }





    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody YouhuihuodongEntity youhuihuodong, HttpServletRequest request){
        //ValidatorUtils.validateEntity(youhuihuodong);
        //全部更新
        youhuihuodongService.updateById(youhuihuodong);
        return R.ok();
    }





    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        youhuihuodongService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }










}
