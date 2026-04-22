package com.entity.view;

import com.entity.ShujifenleiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.utils.EncryptUtil;
 

/**
 * 羽毛球装备分类
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2026-01-08 13:29:31
 */
@TableName("shujifenlei")
public class ShujifenleiView  extends ShujifenleiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ShujifenleiView(){
	}
 
 	public ShujifenleiView(ShujifenleiEntity shujifenleiEntity){
 	try {
			BeanUtils.copyProperties(this, shujifenleiEntity);
		} catch (BeansException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}


}
