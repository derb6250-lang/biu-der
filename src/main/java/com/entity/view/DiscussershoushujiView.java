package com.entity.view;

import com.entity.DiscussershoushujiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.utils.EncryptUtil;
 

/**
 * 评论
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2026-01-08 13:29:32
 */
@TableName("discussershoushuji")
public class DiscussershoushujiView  extends DiscussershoushujiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public DiscussershoushujiView(){
	}
 
 	public DiscussershoushujiView(DiscussershoushujiEntity discussershoushujiEntity){
 	try {
			BeanUtils.copyProperties(this, discussershoushujiEntity);
		} catch (BeansException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}


}
