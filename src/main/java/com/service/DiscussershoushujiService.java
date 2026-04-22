package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.DiscussershoushujiEntity;
import java.util.List;
import java.util.Map;
import com.entity.vo.DiscussershoushujiVO;
import org.apache.ibatis.annotations.Param;
import com.entity.view.DiscussershoushujiView;


/**
 * 评论
 *
 * @author 
 * @email 
 * @date 2026-01-08 13:29:32
 */
public interface DiscussershoushujiService extends IService<DiscussershoushujiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DiscussershoushujiVO> selectListVO(Wrapper<DiscussershoushujiEntity> wrapper);
   	
   	DiscussershoushujiVO selectVO(@Param("ew") Wrapper<DiscussershoushujiEntity> wrapper);
   	
   	List<DiscussershoushujiView> selectListView(Wrapper<DiscussershoushujiEntity> wrapper);
   	
   	DiscussershoushujiView selectView(@Param("ew") Wrapper<DiscussershoushujiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DiscussershoushujiEntity> wrapper);

   	

}

