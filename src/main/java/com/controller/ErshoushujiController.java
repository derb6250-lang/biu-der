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
import com.entity.OrdersEntity;
import com.service.OrdersService;
import com.utils.UserBasedCollaborativeFiltering;

import com.entity.ErshoushujiEntity;
import com.entity.view.ErshoushujiView;

import com.service.ErshoushujiService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.utils.MapUtils;
import com.utils.CommonUtil;
import java.io.IOException;
import com.service.StoreupService;
import com.entity.StoreupEntity;

/**
 * 二手羽毛球装备
 * 后端接口
 * @author 
 * @email 
 * @date 2026-01-08 13:29:31
 */
@RestController
@RequestMapping("/ershoushuji")
public class ErshoushujiController {
    @Autowired
    private ErshoushujiService ershoushujiService;

    @Autowired
    private StoreupService storeupService;

    @Autowired
    private OrdersService ordersService;








    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ErshoushujiEntity ershoushuji,
                @RequestParam(required = false) Double pricestart,
                @RequestParam(required = false) Double priceend,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("yonghu")) {
			ershoushuji.setYonghuzhanghao((String)request.getSession().getAttribute("username"));
		}
        //设置查询条件
        EntityWrapper<ErshoushujiEntity> ew = new EntityWrapper<ErshoushujiEntity>();
        if(pricestart!=null) ew.ge("price", pricestart);
        if(priceend!=null) ew.le("price", priceend);


        //查询结果
		PageUtils page = ershoushujiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ershoushuji), params), params));
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
    public R list(@RequestParam Map<String, Object> params,ErshoushujiEntity ershoushuji,
                @RequestParam(required = false) Double onelimittimesstart,
                @RequestParam(required = false) Double onelimittimesend,
                @RequestParam(required = false) Double alllimittimesstart,
                @RequestParam(required = false) Double alllimittimesend,
                @RequestParam(required = false) Double pricestart,
                @RequestParam(required = false) Double priceend,
                @RequestParam(required = false) Double thumbsupnumstart,
                @RequestParam(required = false) Double thumbsupnumend,
                @RequestParam(required = false) Double crazilynumstart,
                @RequestParam(required = false) Double crazilynumend,
                @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date clicktimestart,
                @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date clicktimeend,
                @RequestParam(required = false) Double clicknumstart,
                @RequestParam(required = false) Double clicknumend,
                @RequestParam(required = false) Double discussnumstart,
                @RequestParam(required = false) Double discussnumend,
                @RequestParam(required = false) Double totalscorestart,
                @RequestParam(required = false) Double totalscoreend,
                @RequestParam(required = false) Double onshelvesstart,
                @RequestParam(required = false) Double onshelvesend,
                @RequestParam(required = false) Double storeupnumstart,
                @RequestParam(required = false) Double storeupnumend,
		HttpServletRequest request){
        //设置查询条件
        EntityWrapper<ErshoushujiEntity> ew = new EntityWrapper<ErshoushujiEntity>();
        if(onelimittimesstart!=null) ew.ge("onelimittimes", onelimittimesstart);
        if(onelimittimesend!=null) ew.le("onelimittimes", onelimittimesend);
        if(alllimittimesstart!=null) ew.ge("alllimittimes", alllimittimesstart);
        if(alllimittimesend!=null) ew.le("alllimittimes", alllimittimesend);
        if(pricestart!=null) ew.ge("price", pricestart);
        if(priceend!=null) ew.le("price", priceend);
        if(thumbsupnumstart!=null) ew.ge("thumbsupnum", thumbsupnumstart);
        if(thumbsupnumend!=null) ew.le("thumbsupnum", thumbsupnumend);
        if(crazilynumstart!=null) ew.ge("crazilynum", crazilynumstart);
        if(crazilynumend!=null) ew.le("crazilynum", crazilynumend);
        if(clicktimestart!=null) ew.ge("clicktime", clicktimestart);
        if(clicktimeend!=null) ew.le("clicktime", clicktimeend);
        if(clicknumstart!=null) ew.ge("clicknum", clicknumstart);
        if(clicknumend!=null) ew.le("clicknum", clicknumend);
        if(discussnumstart!=null) ew.ge("discussnum", discussnumstart);
        if(discussnumend!=null) ew.le("discussnum", discussnumend);
        if(totalscorestart!=null) ew.ge("totalscore", totalscorestart);
        if(totalscoreend!=null) ew.le("totalscore", totalscoreend);
        if(onshelvesstart!=null) ew.ge("onshelves", onshelvesstart);
        if(onshelvesend!=null) ew.le("onshelves", onshelvesend);
        if(storeupnumstart!=null) ew.ge("storeupnum", storeupnumstart);
        if(storeupnumend!=null) ew.le("storeupnum", storeupnumend);

        //查询结果
		PageUtils page = ershoushujiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ershoushuji), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }




	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ErshoushujiEntity ershoushuji){
       	EntityWrapper<ErshoushujiEntity> ew = new EntityWrapper<ErshoushujiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( ershoushuji, "ershoushuji"));
        return R.ok().put("data", ershoushujiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ErshoushujiEntity ershoushuji){
        EntityWrapper< ErshoushujiEntity> ew = new EntityWrapper< ErshoushujiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( ershoushuji, "ershoushuji"));
		ErshoushujiView ershoushujiView =  ershoushujiService.selectView(ew);
		return R.ok("查询二手羽毛球装备成功").put("data", ershoushujiView);
    }

    /**
     * 后台详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ErshoushujiEntity ershoushuji = ershoushujiService.selectById(id);
        if(null==ershoushuji.getClicknum()){
            ershoushuji.setClicknum(0);
        }
		ershoushuji.setClicknum(ershoushuji.getClicknum()+1);
		ershoushujiService.updateById(ershoushuji);
        ershoushuji = ershoushujiService.selectView(new EntityWrapper<ErshoushujiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(ershoushuji,deSens);
        return R.ok().put("data", ershoushuji);
    }

    /**
     * 前台详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ErshoushujiEntity ershoushuji = ershoushujiService.selectById(id);
        if(null==ershoushuji.getClicknum()){
            ershoushuji.setClicknum(0);
        }
		ershoushuji.setClicknum(ershoushuji.getClicknum()+1);
		ershoushujiService.updateById(ershoushuji);
        ershoushuji = ershoushujiService.selectView(new EntityWrapper<ErshoushujiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(ershoushuji,deSens);
        return R.ok().put("data", ershoushuji);
    }



    /**
     * 赞或踩
     */
    @RequestMapping("/thumbsup/{id}")
    public R vote(@PathVariable("id") String id,String type){
        ErshoushujiEntity ershoushuji = ershoushujiService.selectById(id);
        if(type.equals("1")) {
        	ershoushuji.setThumbsupnum(ershoushuji.getThumbsupnum()+1);
        } else {
        	ershoushuji.setCrazilynum(ershoushuji.getCrazilynum()+1);
        }
        ershoushujiService.updateById(ershoushuji);
        return R.ok("投票成功");
    }

    /**
     * 后台保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ErshoushujiEntity ershoushuji, HttpServletRequest request){
        //ValidatorUtils.validateEntity(ershoushuji);
        ershoushujiService.insert(ershoushuji);
        return R.ok().put("data",ershoushuji.getId());
    }

    /**
     * 前台保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody ErshoushujiEntity ershoushuji, HttpServletRequest request){
        //ValidatorUtils.validateEntity(ershoushuji);
        ershoushujiService.insert(ershoushuji);
        return R.ok().put("data",ershoushuji.getId());
    }





    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody ErshoushujiEntity ershoushuji, HttpServletRequest request){
        //ValidatorUtils.validateEntity(ershoushuji);
        //全部更新
        ershoushujiService.updateById(ershoushuji);
        return R.ok();
    }

    /**
     * 审核
     */
    @RequestMapping("/shBatch")
    @Transactional
    public R update(@RequestBody Long[] ids, @RequestParam String sfsh, @RequestParam String shhf){
        List<ErshoushujiEntity> list = new ArrayList<ErshoushujiEntity>();
        for(Long id : ids) {
            ErshoushujiEntity ershoushuji = ershoushujiService.selectById(id);
            ershoushuji.setSfsh(sfsh);
            ershoushuji.setShhf(shhf);
            list.add(ershoushuji);
        }
        ershoushujiService.updateBatchById(list);
        return R.ok();
    }




    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        ershoushujiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

	/**
     * 前台智能排序
     */
	@IgnoreAuth
    @RequestMapping("/autoSort")
    public R autoSort(@RequestParam Map<String, Object> params,ErshoushujiEntity ershoushuji, HttpServletRequest request,String pre){
        EntityWrapper<ErshoushujiEntity> ew = new EntityWrapper<ErshoushujiEntity>();
        ew.eq("onshelves","1");
        Map<String, Object> newMap = new HashMap<String, Object>();
        Map<String, Object> param = new HashMap<String, Object>();
        // 组装参数
		Iterator<Map.Entry<String, Object>> it = param.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String key = entry.getKey();
			String newKey = entry.getKey();
			if (pre.endsWith(".")) {
				newMap.put(pre + newKey, entry.getValue());
			} else if (StringUtils.isEmpty(pre)) {
				newMap.put(newKey, entry.getValue());
			} else {
				newMap.put(pre + "." + newKey, entry.getValue());
			}
		}
		params.put("sort", "clicknum");
        params.put("order", "desc");

		PageUtils page = ershoushujiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ershoushuji), params), params));
        return R.ok().put("data", page);
    }



    /**
     * 协同算法（基于用户的协同算法：购买、收藏、关注）
     */
    @RequestMapping("/autoSort2")
    public R autoSort2(@RequestParam Map<String, Object> params,ErshoushujiEntity ershoushuji, HttpServletRequest request){
        String userId = request.getSession().getAttribute("userId").toString();
        Integer limit = params.get("limit") == null ? 10 : Integer.parseInt(params.get("limit").toString());
        // 创建协同过滤对象
        UserBasedCollaborativeFiltering filter = new UserBasedCollaborativeFiltering();
        //用户行为数据
        List<UserBasedCollaborativeFiltering.UserBehavior> userBehaviors = new ArrayList<>();
        // 查询订单数据
        userBehaviors.addAll(ordersService.selectList(new EntityWrapper<>()).stream().map(order -> {
            return new UserBasedCollaborativeFiltering.UserBehavior(order.getUserid().toString(), order.getGoodid().toString());
        }).collect(Collectors.toList()));
        // 查询收藏/关注数据
        userBehaviors.addAll(storeupService.selectList(new EntityWrapper<StoreupEntity>().eq("type", 1 ).eq("tablename", "ershoushuji")).stream().map(storeup -> {
            return new UserBasedCollaborativeFiltering.UserBehavior(storeup.getUserid().toString(), storeup.getRefid().toString());
        }).collect(Collectors.toList()));
        // 查询点赞数据
        userBehaviors.addAll(storeupService.selectList(new EntityWrapper<StoreupEntity>().eq("type", 21).eq("tablename", "ershoushuji")).stream().map(storeup -> {
            return new UserBasedCollaborativeFiltering.UserBehavior(storeup.getUserid().toString(), storeup.getRefid().toString());
        }).collect(Collectors.toList()));
        // 根据物品推荐用户
        List<String> recommendations = filter.recommendItems(userBehaviors, userId, limit, true );

        // 输出推荐结果
        System.out.println("Recommendations for " + userId + ":");
        for (String item : recommendations) {
            System.out.println(item);
        }

        EntityWrapper<ErshoushujiEntity> ew = new EntityWrapper<ErshoushujiEntity>();
                                                                                            ew.eq("onshelves","1");
        if(recommendations!=null && recommendations.size()>0 && recommendations.size()>0) {
            ew.in("id", recommendations);
            ew.last("order by FIELD(id, "+String.join(",", recommendations)+")");
        }
        // 根据协同结果查询结果并返回
        PageUtils page = ershoushujiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ershoushuji), params), params));
        List<ErshoushujiEntity> pageList = (List<ErshoushujiEntity>)page.getList();
        if(recommendations!=null && recommendations.size()>0 && pageList.size()<limit) {
            int toAddNum = limit-pageList.size();
            ew = new EntityWrapper<ErshoushujiEntity>();
            ew.notIn("id", recommendations);
            ew.orderBy("id", false);
            ew.last("limit "+toAddNum);
            pageList.addAll(ershoushujiService.selectList(ew));
        } else if(pageList.size()>limit) {
            pageList = pageList.subList(0, limit);
        }
        page.setList(pageList);

        return R.ok().put("data", page);
    }






}
