  
<template>
	<div class="main-content" :style='{"padding":"50px 30px 30px"}'>
		<!-- 列表页 -->
		<template v-if="showFlag ">
			<el-form class="center-form-pv" :style='{"width":"100%","padding":"0","margin":"0 0 20px"}' :inline="true" :model="searchForm">
				<el-row :style='{"padding":"20px 20px 10px","borderRadius":"8px  8px  8px  8px","flexWrap":"wrap","background":"#F5F5F5","display":"flex","width":"100%","position":"relative"}' >
					<div  :style='{"margin":"0 1% 10px 0","display":"flex"}'>
						<label :style='{"margin":"0 10px 0 0","whiteSpace":"nowrap","color":"#666","display":"none","lineHeight":"40px","fontSize":"16px","fontWeight":"500","height":"40px"}' class="item-label">订单编号</label>
						<el-input v-model="searchForm.orderid" placeholder="订单编号" @keydown.enter.native="search()" clearable></el-input>
					</div>
					<el-button class="search" type="success" @click="search()">
						<span class="icon iconfont icon-fangdajing01" :style='{"margin":"0 0px","fontSize":"16px","color":"#fff","height":"40px"}'></span>
						查询
					</el-button>
				</el-row>

				<el-row class="actions" :style='{"width":"calc(100% + 8px)","margin":"20px 0 20px -4px","flexWrap":"wrap","justifyContent":"flex-end","display":"flex"}'>
					<el-button class="add" v-if="isAuth('orders'+'/'+orderStatus,'新增')" type="success" @click="addOrUpdateHandler()">
						<span class="icon iconfont icon-tianjia16" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						添加
					</el-button>
					<el-button class="del" v-if="isAuth('orders'+'/'+orderStatus,'删除')" :disabled="dataListSelections.length?false:true" type="danger" @click="deleteHandler()">
						<span class="icon iconfont icon-shanchu6" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						删除
					</el-button>


					<download-excel v-if="isAuth('orders'+'/'+orderStatus,'导出')" class="export-excel-wrapper" :fetch="getAllList" :fields="json_fields" name="订单.xls">
						<!-- 导出excel -->
						<el-button class="btn18" type="success">
							<span class="icon iconfont icon-xiazai7" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
							导出
						</el-button>
					</download-excel>
					<el-button class="btn18" v-if="isAuth('orders'+'/'+orderStatus,'发货')" type="success" @click="updateHandler(null)">
						<span class="icon iconfont icon-zhifudingjin" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						批量发货
					</el-button>
					<el-button class="btn18" v-if="isAuth('orders'+'/'+orderStatus,'确认收货')" @click="updateHandler2(null)">
						<span class="icon iconfont icon-zhifudingjin" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						批量收货
					</el-button>
					<el-button class="btn18" v-if="isAuth('orders'+'/'+orderStatus,'商品销量')" type="success" @click="chartDialogShow1">
						<span class="icon iconfont icon-xihuan" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						商品销量
					</el-button>
					<el-button class="btn18" v-if="isAuth('orders'+'/'+orderStatus,'商品销售额')" type="success" @click="chartDialogShow2">
						<span class="icon iconfont icon-xihuan" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						商品销售额
					</el-button>
					<el-button class="btn18" v-if="isAuth('orders'+'/'+orderStatus,'商品类销量')" type="success" @click="chartDialogShow3">
						<span class="icon iconfont icon-xihuan" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						商品类销量
					</el-button>
					<el-button class="btn18" v-if="isAuth('orders'+'/'+orderStatus,'商品类销售额')" type="success" @click="chartDialogShow4">
						<span class="icon iconfont icon-xihuan" :style='{"margin":"0 0px","fontSize":"16px","color":"#0098EF","height":"auto"}'></span>
						商品类销售额
					</el-button>
				</el-row>
			</el-form>
			<div :style='{"border":"1px solid #DEDEDE","width":"100%","padding":"0","boxShadow":"none","borderRadius":"10px","background":"#fff"}'>
				<el-table class="tables"
					:stripe='false'
					:style='{"padding":"0","borderColor":"#EFEFEF","borderRadius":"10px","borderWidth":"0px 0 0 0px","background":"#fff","width":"100%","borderStyle":"solid"}' 
					:border='false'
					v-if="isAuth('orders'+'/'+orderStatus,'查看')"
					:data="dataList"
					v-loading="dataListLoading"
					@selection-change="selectionChangeHandler">
					<el-table-column :resizable='true' type="selection" align="center" width="50"></el-table-column>
					<el-table-column :resizable='true' :sortable='true' label="序号" type="index" width="50" />
					<el-table-column :resizable='true' :sortable='true'
												prop="orderid"
						label="订单编号">
						<template slot-scope="scope">
							{{scope.row.orderid}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="goodid"
						label="商品id">
						<template slot-scope="scope">
							{{scope.row.goodid}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="goodname"
						label="商品名称">
						<template slot-scope="scope">
							{{scope.row.goodname}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="goodtype"
						label="商品类型">
						<template slot-scope="scope">
							{{scope.row.goodtype}}
						</template>
					</el-table-column>
					<el-table-column  :resizable='true' prop="picture" width="200" label="图片">
						<template slot-scope="scope">
							<div v-if="scope.row.picture">
								<img v-if="scope.row.picture.substring(0,4)=='http'&&scope.row.picture.split(',w').length>1" :src="scope.row.picture" width="100" height="100" style="object-fit: cover" @click="imgPreView(scope.row.picture)">
								<img v-else-if="scope.row.picture.substring(0,4)=='http'" :src="scope.row.picture.split(',')[0]" width="100" height="100" style="object-fit: cover" @click="imgPreView(scope.row.picture.split(',')[0])">
								<img v-else :src="$base.url+scope.row.picture.split(',')[0]" width="100" height="100" style="object-fit: cover" @click="imgPreView($base.url+scope.row.picture.split(',')[0])">
							</div>
							<div v-else>无图片</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="buynumber"
						label="购买数量">
						<template slot-scope="scope">
							{{scope.row.buynumber}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="price"
						label="单价">
						<template slot-scope="scope">
							{{scope.row.price}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="total"
						label="总价">
						<template slot-scope="scope">
							{{scope.row.total}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="status" :formatter="orderStatusFormatter"
						label="状态">
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="address"
						label="地址">
						<template slot-scope="scope">
							{{scope.row.address}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="tel"
						label="电话">
						<template slot-scope="scope">
							{{scope.row.tel}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="consignee"
						label="收货人">
						<template slot-scope="scope">
							{{scope.row.consignee}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="remark"
						label="备注">
						<template slot-scope="scope">
							{{scope.row.remark}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="addtime"
						label="创建时间">
						<template slot-scope="scope">
							{{scope.row.addtime}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
												prop="yonghuzhanghao"
						label="商户名称">
						<template slot-scope="scope">
							{{scope.row.yonghuzhanghao}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="sfsh" label="退货审核" v-if="changeReturnGoods()">
						<template slot-scope="scope">
							<el-tag type="success" v-if="scope.row.sfsh=='是'">已通过</el-tag>
							<el-tag type="warning" v-if="scope.row.sfsh=='待审核'">待审核</el-tag>
							<el-tag type="danger" v-if="scope.row.sfsh=='否'">未通过</el-tag>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="shhf" label="审核回复" show-overflow-tooltip v-if="changeReturnGoods()">
						<template slot-scope="scope">
							<div style="white-space: nowrap;">{{scope.row.shhf}}</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="returnreason" label="退货原因" show-overflow-tooltip v-if="changeReturnGoods()">
						<template slot-scope="scope">
							<div style="white-space: nowrap;">{{scope.row.returnreason}}</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="addtime" label="下单时间">
						<template slot-scope="scope">
							{{scope.row.addtime}}
						</template>
					</el-table-column>
					<el-table-column width="300" label="操作">
						<template slot-scope="scope">
							<el-button class="edit" v-if=" isAuth('orders'+'/'+orderStatus,'修改') " type="success" @click="addOrUpdateHandler(scope.row.id)">
								<span class="icon iconfont icon-xiugai13" :style='{"margin":"0 0px","fontSize":"14px","color":"rgba(255, 140, 0, 1)","display":"none","height":"40px"}'></span>
								修改
							</el-button>

							<el-button class="btn8" v-if="isAuth('orders'+'/'+orderStatus,'物流')&&scope.row.id" type="success" @click="logisticsUpdate(scope.row.id)">
								<span class="icon iconfont icon-wuliu8" :style='{"margin":"0 0px","fontSize":"14px","color":"#333","display":"none","height":"40px"}'></span>
								物流
							</el-button>
							<el-button class="btn8" v-if="isAuth('orders'+'/'+orderStatus,'发货')&&scope.row.id" type="success" @click="updateHandler(scope.row)">
								<span class="icon iconfont icon-fahuo16" :style='{"margin":"0 0px","fontSize":"14px","color":"#333","display":"none","height":"40px"}'></span>
								发货
							</el-button>
							<el-button class="btn8" v-if="isAuth('orders'+'/'+orderStatus,'确认收货')&&scope.row.id" type="success" @click="updateHandler2(scope.row)">
								<span class="icon iconfont icon-queren12" :style='{"margin":"0 0px","fontSize":"14px","color":"#333","display":"none","height":"40px"}'></span>
								确认收货
							</el-button>
							<el-button class="btn8" v-if="isAuth('orders'+'/'+orderStatus,'退货审核')&&scope.row.sfsh=='待审核'" type="success" @click="returnSh(scope.row)">
								<span class="icon iconfont icon-zhangjie7" :style='{"margin":"0 0px","fontSize":"14px","color":"#333","display":"none","height":"40px"}'></span>
								退货审核
							</el-button>
							<el-button class="btn8" v-if="isAuth('orders'+'/'+orderStatus,'二维码')" type="success" @click="qrcodeClick(scope.row)">
								<span class="icon iconfont icon-zhangjie7" :style='{"margin":"0 0px","fontSize":"14px","color":"#333","display":"none","height":"40px"}'></span>
								二维码
							</el-button>



							<el-button class="del" v-if="isAuth('orders'+'/'+orderStatus,'删除')" type="primary" @click="deleteHandler(scope.row.id)">
								<span class="icon iconfont icon-shanchu6" :style='{"margin":"0 0px","fontSize":"14px","color":"rgba(220, 38, 38, 1)","display":"none","height":"40px"}'></span>
								删除
							</el-button>
						</template>
					</el-table-column>
				</el-table>
			</div>
			<el-pagination
				@size-change="sizeChangeHandle"
				@current-change="currentChangeHandle"
				:current-page="pageIndex"
				background
				:page-sizes="[10, 50, 100, 200]"
				:page-size="pageSize"
				:layout="layouts.join()"
				:total="totalPage"
				prev-text="< "
				next-text="> "
				:hide-on-single-page="false"
				:style='{"padding":"0","margin":"20px 0 0","whiteSpace":"nowrap","color":"#333","display":"flex","width":"100%","fontWeight":"500","justifyContent":"center"}'
			></el-pagination>
		</template>
		
		<!-- 添加/修改页面  将父组件的search方法传递给子组件-->
		<add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>


		<el-dialog title="退货审核" :visible.sync="returnShVisible" width="50%">
			<el-form ref="returnShForm" :model="returnShForm" label-width="80px" :rules="returnShRules">
				<el-form-item label="退货理由" prop="returnreason">
					{{returnShForm.returnreason}}
				</el-form-item>
				<el-form-item label="审核状态" prop="sfsh">
					<el-select v-model="returnShForm.sfsh" placeholder="审核状态">
						<el-option label="通过" value="是"></el-option>
						<el-option label="不通过" value="否"></el-option>
						<el-option label="待审核" value="待审核"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="内容" prop="shhf">
					<el-input type="textarea" :rows="8" v-model="returnShForm.shhf"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="returnShVisible=false">取 消</el-button>
				<el-button type="primary" @click="returnShSave">确 定</el-button>
			</span>
		</el-dialog>


		<el-dialog title="二维码" :visible.sync="codeVisible" width="490px">
			<div id="qrcode"></div>
		</el-dialog>
		<el-dialog
			class="chartDialog"
			:visible.sync="chartVisiable1"
			width="800">
			<div id="buynumberChart1" style="width:100%;height:600px;"></div>
			<span slot="footer" class="dialog-footer">
				<el-button @click="chartVisiable1 = false">返回</el-button>
			</span>
		</el-dialog>
		<el-dialog
			class="chartDialog"
			:visible.sync="chartVisiable2"
			width="800">
			<div id="totalChart2" style="width:100%;height:600px;"></div>
			<span slot="footer" class="dialog-footer">
				<el-button @click="chartVisiable2 = false">返回</el-button>
			</span>
		</el-dialog>
		<el-dialog
			class="chartDialog"
			:visible.sync="chartVisiable3"
			width="800">
			<div id="buynumberChart3" style="width:100%;height:600px;"></div>
			<span slot="footer" class="dialog-footer">
				<el-button @click="chartVisiable3 = false">返回</el-button>
			</span>
		</el-dialog>
		<el-dialog
			class="chartDialog"
			:visible.sync="chartVisiable4"
			width="800">
			<div id="totalChart4" style="width:100%;height:600px;"></div>
			<span slot="footer" class="dialog-footer">
				<el-button @click="chartVisiable4 = false">返回</el-button>
			</span>
		</el-dialog>

		<el-dialog title="预览图" :visible.sync="previewVisible" width="50%">
			<img :src="previewImg" alt="" style="width: 100%;">
		</el-dialog>
	</div>
</template>

<script>
	import * as echarts from 'echarts'
	import chinaJson from "@/components/echarts/china.json";
	import axios from 'axios';
	import AddOrUpdate from "./add-or-update";
	import QRCode from 'qrcode2';
	import {
		Loading
	} from 'element-ui';
	export default {
		data() {
			return {
				indexQueryCondition: '',
				searchForm: {
					key: ""
				},
				form:{},
				dataList: [],
				pageIndex: 1,
				pageSize: 10,
				totalPage: 0,
				dataListLoading: false,
				dataListSelections: [],
				showFlag: true,
				line: {"backgroundColor":"transparent","yAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":15,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"minInterval":1,"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,0.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"xAxis":{"axisLabel":{"borderType":"solid","rotate":30,"padding":0,"shadowOffsetX":0,"margin":10,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"truncate","borderRadius":0,"borderWidth":0,"width":120,"interval":0,"fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":false},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"color":["#378bb9","#095dac","#fbc62f","#16606a","#f75d5f","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"legend":{"padding":0,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":20,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"showSymbol":true,"symbol":"pin","symbolSize":18},"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"}},
				bar: {"backgroundColor":"transparent","yAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":12,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"minInterval":1,"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,0.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"xAxis":{"axisLabel":{"borderType":"solid","rotate":30,"padding":0,"shadowOffsetX":0,"margin":10,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"truncate","borderRadius":0,"borderWidth":0,"width":120,"interval":0,"fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":false},"minInterval":1,"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"color":["#378bb9","#095dac","#DEDEDE","#3B8527","#f75d5f","#D82727","#333333","#9ab7a8","#ea7ccc"],"legend":{"padding":0,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":20,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":12,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"grid":{"x":"25%","y":"15%","y2":"15%","x2":"5%"},"series":{"barWidth":"22px","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#f2f8d4","shadowOffsetY":0,"color":{"x":0,"y":0,"y2":1,"x2":0,"global":false,"colorStops":[{"offset":0,"color":"#2fa4e7"},{"offset":1,"color":"#80b1cc"}],"type":"linear"},"shadowBlur":0,"borderWidth":0,"barBorderRadius":[4,4,0,0],"opacity":1,"shadowColor":"#000"},"colorBy":"data","label":{"formatter":"","show":true,"position":"top"},"barCategoryGap":"10%"},"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"subtext":"","shadowBlur":0,"bottom":"auto","show":true,"right":"auto","subtextStyle":{"padding":[5,0,0,0],"borderColor":"red","color":"red","borderWidth":10},"top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"},"base":{"animate":false,"interval":2000}},
				pie: {"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"backgroundColor":"transparent","color":["#449A2D","#2FA4E7","#80B1CC","#212D3F","#09A5FF","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"title":{"borderType":"solid","padding":[5,0,0,0],"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","fontSize":14,"lineHeight":14,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"},"legend":{"padding":[5,0,0,0],"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":2,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":0,"top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":2,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":12,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#666","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"label":{"borderType":"solid","rotate":0,"padding":0,"textBorderWidth":0,"backgroundColor":"transparent","borderColor":"#666","color":"inherit","show":true,"textShadowColor":"transparent","distanceToLabelLine":5,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"fontSize":12,"lineHeight":18,"textShadowOffsetX":0,"position":"outside","textShadowOffsetY":0,"textBorderType":"solid","textBorderColor":"#666","textShadowBlur":0},"labelLine":{"show":true,"length":10,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"#000"},"length2":14,"smooth":false}}},
				funnel: {"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"backgroundColor":"transparent","color":["#449A2D","#2FA4E7","#80B1CC","#212D3F","#09A5FF","#5967cc","#f75d5f","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"title":{"borderType":"solid","padding":2,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"center","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","fontSize":14,"lineHeight":12,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"#ccc","textShadowBlur":0},"shadowColor":"transparent"},"legend":{"padding":5,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"orient":"vertical","shadowBlur":0,"bottom":"auto","itemHeight":2,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"left","borderWidth":0,"width":"auto","itemWidth":2,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":20,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#000","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"label":{"borderType":"solid","rotate":0,"padding":0,"textBorderWidth":0,"backgroundColor":"transparent","borderColor":"#fff","color":"","show":true,"textShadowColor":"transparent","distanceToLabelLine":5,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"fontSize":12,"lineHeight":18,"textShadowOffsetX":0,"position":"outside","textShadowOffsetY":0,"textBorderType":"solid","textBorderColor":"#fff","textShadowBlur":0},"labelLine":{"show":true,"length":10,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"#000"},"length2":14,"smooth":false}}},
				boardBase: {"funnelNum":8,"lineNum":8,"radarNum":8,"gaugeNum":8,"barNum":8,"pieNum":8},
				gauge: {"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"backgroundColor":"transparent","color":["#449A2D","#2FA4E7","#80B1CC","#212D3F","#09A5FF","#5967cc","#f75d5f","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"title":{"top":"top","left":"left","textStyle":{"fontSize":14,"lineHeight":24,"color":"#333","fontWeight":600}},"series":{"pointer":{"offsetCenter":[0,"10%"],"icon":"path://M2.9,0.7L2.9,0.7c1.4,0,2.6,1.2,2.6,2.6v115c0,1.4-1.2,2.6-2.6,2.6l0,0c-1.4,0-2.6-1.2-2.6-2.6V3.3C0.3,1.9,1.4,0.7,2.9,0.7z","width":8,"length":"80%"},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"opacity":0.5,"shadowBlur":1,"shadowColor":"#000"},"roundCap":true},"anchor":{"show":true,"itemStyle":{"color":"inherit"},"size":18,"showAbove":true},"emphasis":{"disabled":false},"progress":{"show":true,"roundCap":true,"overlap":true},"splitNumber":25,"detail":{"formatter":"{value}","backgroundColor":"inherit","color":"#fff","borderRadius":3,"width":20,"fontSize":12,"height":10},"title":{"fontSize":14},"animation":true}},
				radar: {"backgroundColor":"transparent","radar":{"shape":"circle"},"color":["#365E77","#DF308C","#0CB906","#7690cb","#49ada0","#5BBAEC","#a68a28","#EE142F","#FFE9E9"],"legend":{"padding":5,"itemGap":5,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"orient":"vertical","shadowBlur":0,"bottom":"auto","itemHeight":4,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"auto","itemWidth":4,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{},"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#7987FD"}},"title":{"top":"top","left":"left","textStyle":{"textBorderWidth":0,"color":"#365E77","textShadowColor":"transparent","fontSize":14,"lineHeight":14,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0}}},
				chartVisiable1: false,
				chartVisiable2: false,
				chartVisiable3: false,
				chartVisiable4: false,
				codeVisible: false,
				returnShVisible: false,
				returnShForm: {},
				returnShRules:{
					sfsh:[{ required: true, message: '审核状态不能为空', trigger: 'blur' },],
					shhf:[{ required: true, message: '审核回复不能为空', trigger: 'blur' },],
				},
				addOrUpdateFlag:false,
				layouts: ["total","prev","pager","next","sizes","jumper"],
				orderStatus: this.$route.params.status,
//导出excel
				json_fields: {
					"下单时间": "addtime",
					"订单编号": "orderid",    //常规字段
					"商品id": "goodid",    //常规字段
					"商品名称": "goodname",    //常规字段
					"商品类型": "goodtype",    //常规字段
					"图片": "picture",    //常规字段
					"购买数量": "buynumber",    //常规字段
					"单价": "price",    //常规字段
					"总价": "total",    //常规字段
					"支付类型": "type",    //常规字段
					"订单状态": "status",    //常规字段
					"地址": "address",    //常规字段
					"电话": "tel",    //常规字段
					"收货人": "consignee",    //常规字段
					"备注": "remark",    //常规字段
					"创建时间": "addtime",    //常规字段
					"用户id": "userid",    //常规字段
					"商品表名": "tablename",    //常规字段
					"物流": "logistics",    //常规字段
					"商户名称": "yonghuzhanghao",    //常规字段
					"是否审核": "sfsh",    //常规字段
					"审核回复": "shhf",    //常规字段
					"用户角色": "role",    //常规字段
					"退货原因": "returnreason",    //常规字段
				},
				json_meta: [
					[
						{
							" key ": " charset ",
							" value ": " utf- 8 "
						}
					]
				],
				previewImg: '',
				previewVisible: false,
			};
		},
		created() {
			if(this.statType) {
				return false
			}
			this.init();
			this.getDataList();
		},
		mounted() {
		},
		watch: {
			//监听订单表参数是否变化，从而调取接口
			'$route' (to, from) { //监听路由是否变化
				if(this.$route.params.status){//判断状态是否有值
				//调数据
					this.orderStatus=this.$route.params.status;
					this.getDataList();
				}
			},
		},
		filters: {
			htmlfilter: function (val) {
				return val.replace(/<[^>]*>/g).replace(/undefined/g,'');
			}
		},
		computed: {
			tablename(){
				return this.$storage.get('sessionTable')
			},
			role(){
				return this.$storage.get('role')
			},
		},
		components: {
			AddOrUpdate,
		},
		methods: {
			queryChange(arr){
				for(let x in arr) {
					if(arr[x] == this.role) {
						return true
					}
				}
				return false
			},
			imgPreView(url){
				this.previewImg = url
				this.previewVisible = true
				
			},
			orderStatusFormatter: function(row, column) {
				var temp = row.status
				if(row.status=='已退款'&&row.sfsh!=''){
					temp = '已退货'
				}
				return temp
			},
			orderTypeFormatter: function(row, column) {
				var temp = ''
			  // 处理逻辑 保存接口 数据，进行匹配 name
				switch (row.type-0) {
					case 1:
						temp = '余额'
						break
					case 2:
						temp = '积分'
						break
					case 3:
						temp = '拼团'
						break
				}
				return temp
			},
			qrcodeClick(row) {
				this.codeVisible = true
				this.$nextTick(()=>{
					if(document.getElementById('qrcode').innerHTML!=null) {
						document.getElementById('qrcode').innerHTML = ''
					}
					var qrcode = new QRCode(document.getElementById('qrcode'), {
						text: row.orderid,
						width: 450,
						height: 450,
						colorDark : "#000000",
						colorLight : "#ffffff",
						correctLevel : QRCode.CorrectLevel.H
					});
				})
			},
			updateHandler(row=null) {
				if(row==null) {
					if(!this.dataListSelections.length) {
						this.$message.error('请选中数据');
						return false
					}
					this.$confirm(`确定进行批量发货操作?`, "提示", {
						confirmButtonText: "确定",
						cancelButtonText: "取消",
						type: "warning"
					}).then(async() => {
						for(let x in this.dataListSelections) {
							this.dataListSelections[x].status = "已发货";
							await this.$http({
								url: `orders/update`,
								method: "post",
								data: this.dataListSelections[x]
							}).then(({ data }) => {
								if (data && data.code === 0) {
									
								} else {
									this.$message.error(data.msg);
								}
							});
						}
						this.$message({
							message: "操作成功",
							type: "success",
							duration: 1500,
							onClose: () => {
								this.search();
							}
						});
					});
					return false
				}
				this.$confirm(`确定进行发货操作?`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					row.status = "已发货";
					this.$http({
						url: `orders/update`,
						method: "post",
						data: row
					}).then(({ data }) => {
						if (data && data.code === 0) {
							this.$message({
								message: "操作成功",
								type: "success",
								duration: 1500,
								onClose: () => {
									this.search();
								}
							});
						} else {
							this.$message.error(data.msg);
						}
					});
				});
			},
			updateHandler2(row=null) {
				if(row==null) {
					if(!this.dataListSelections.length) {
						this.$message.error('请选中数据');
						return false
					}
					this.$confirm(`确定进行批量收货操作?`, "提示", {
						confirmButtonText: "确定",
						cancelButtonText: "取消",
						type: "warning"
					}).then(async() => {
						for(let x in this.dataListSelections) {
							this.dataListSelections[x].status = "已完成";
							await this.$http({
								url: `orders/update`,
								method: "post",
								data: this.dataListSelections[x]
							}).then(async ({ data }) => {
								if (data && data.code === 0) {
									await this.$http({
										url: `${this.dataListSelections[x].tablename}/info/${this.dataListSelections[x].goodid}`,
										method: 'get'
									}).then(async rs=>{
										if(rs.data.data.sales||rs.data.data.sales==0) {
											rs.data.data.sales = Number((Number(rs.data.data.sales) + Number(this.dataListSelections[x].buynumber)).toFixed(0))
											await this.$http({
												url: `${this.dataListSelections[x].tablename}/update`,
												method: "post",
												data: rs.data.data
											}).then(rs2=>{})
										}
									})
								} else {
									this.$message.error(data.msg);
								}
							});
						}
						this.$message({
							message: "操作成功",
							type: "success",
							duration: 1500,
							onClose: () => {
								this.search();
							}
						});
					});
					return false
				}
				this.$confirm(`确定进行收货操作?`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					row.status = "已完成";
					this.$http({
						url: `orders/update`,
						method: "post",
						data: row
					}).then(async ({ data }) => {
						if (data && data.code === 0) {
							await this.$http({
								url: `${row.tablename}/info/${row.goodid}`,
								method: 'get'
							}).then(async rs=>{
								if(rs.data.data.sales||rs.data.data.sales==0) {
									rs.data.data.sales = Number((Number(rs.data.data.sales) + Number(row.buynumber)).toFixed(0))
									await this.$http({
										url: `${row.tablename}/update`,
										method: "post",
										data: rs.data.data
									}).then(rs2=>{})
								}
							})
							this.$message({
								message: "操作成功",
								type: "success",
								duration: 1500,
								onClose: () => {
									this.search();
								}
							});
						} else {
							this.$message.error(data.msg);
						}
					});
				});
			},
			//物流
			logisticsUpdate(id,type) {
				this.showFlag = false;
				this.addOrUpdateFlag = true;
				this.crossAddOrUpdateFlag = false;
				if(type!='info'){
					type = 'logistics';
				}
				this.$nextTick(() => {
					this.$refs.addOrUpdate.init(id,type);
				});
			},
			// 退货审核
			returnSh(row){
				this.returnShForm = JSON.parse(JSON.stringify(row))
				this.returnShVisible = true
			},
			// 退货审核保存
			returnShSave(){
				this.$refs["returnShForm"].validate(valid => {
					if(valid){
						if(this.returnShForm.sfsh=="是"){
							this.returnShForm.status = '已退款'
							this.$http({
								url: `${this.returnShForm.tablename}/info/${this.returnShForm.goodid}`,
								method: 'get',
							}).then(res=>{
								if(res.data&&res.data.code==0){
									let good = res.data.data
									// 商品存在库存。加回库存
									if(good.alllimittimes){
										good.alllimittimes = parseInt(good.alllimittimes) + parseInt(this.returnShForm.buynumber)
										this.$http({
											url: `${this.returnShForm.tablename}/update`,
											method: 'post',
											data: good
										}).then(obj=>{})
									}
									this.$http({
										url: `${this.returnShForm.role}/info/${this.returnShForm.userid}`,
										method: 'get',
									}).then(res1=>{
										if(res1.data&&res1.data.code==0){
											let user = res1.data.data
											// 如果是积分兑换 加回积分 
											if(this.returnShForm.type==2){
												user.jf = (Number(user.jf) + Number(this.returnShForm.total)).toFixed(2)
												this.$http({
													url: `${this.returnShForm.role}/update`,
													method: 'post',
													data: user
												}).then(obj=>{})
											}
											// 如果是其他形式 有积分减去积分。余额加回余额
											else{
												// 商品存在积分。加回积分
												if(good.jf){
													user.jf = (Number(user.jf) - Number(this.returnShForm.total)).toFixed(2)
												}
												if(user.jf<0) {
													user.jf = 0
												}
												// 加回余额
												user.money = (Number(user.money) + Number(this.returnShForm.total)).toFixed(2)
												this.$http({
													url: `${this.returnShForm.role}/update`,
													method: 'post',
													data: user
												}).then(obj=>{})
											}
											this.$http({
												url: 'orders/update',
												method: 'post',
												data: this.returnShForm
											}).then(res=>{
												if(res.data&&res.data.code==0){
													this.$message({
														message: "审核成功",
														type: "success",
														duration: 1500,
														onClose: () => {
															this.search()
															this.returnShVisible = false
														}
													})
												}
											})
										}
									})
								}
							})
						}else if(this.returnShForm.sfsh=='否'){
							this.$http({
								url: 'orders/update',
								method: 'post',
								data: this.returnShForm
							}).then(res=>{
								if(res.data&&res.data.code==0){
									this.$message({
										message: "审核成功",
										type: "success",
										duration: 1500,
										onClose: () => {
											this.search()
											this.returnShVisible = false
										}
									})
								}
							})
						}
					}
				})
			},
			changeStatQuery(arr) {
				if(arr.length==1) {
					if(arr[0] == 'users'&&this.$storage.get("sessionTable")=='users') {
						return true
					}
				}
				for(let x in arr) {
					if(arr[x] == this.role) {
						return true
					}
				}
				return false
			},
			chartDialogShow1() {
				this.chartVisiable1 = true
				this.chartDialog1()
			},
			// 统计接口1
			chartDialog1() {
				this.$nextTick(()=>{
					var buynumberChart1 = echarts.init(document.getElementById("buynumberChart1"),'macarons');
					let params = {}
					this.$http({
						url: "orders/value/goodname/buynumber",
						method: "get",
						params
					}).then(({data})=>{
						if (data && data.code === 0) {
							let res = data.data;
							let xAxis = [];
							let yAxis = [];
							let pArray = []
							for(let i=0;i<res.length;i++){
								if(this.boardBase&&i==this.boardBase.barNum){
									break;
								}
								xAxis.push(res[i].goodname);
								yAxis.push(parseFloat((res[i].total)));
								pArray.push({
									value: parseFloat((res[i].total)),
									name: res[i].goodname
								})
							}
							var option = {};
							let titleObj = this.bar.title
							titleObj.text = '商品销量'
							
							const legendObj = this.bar.legend
							let tooltipObj = {trigger: 'item',formatter: '{b} : {c}'}
							tooltipObj = Object.assign(tooltipObj , this.bar.tooltip?this.bar.tooltip:{})
							let xAxisObj = this.bar.xAxis
							xAxisObj.type = 'category'
							xAxisObj.data = xAxis
							
							let yAxisObj = this.bar.yAxis
							yAxisObj.type = 'value'
							let seriesObj = {
								data: yAxis,
								type: 'bar',
							}
							seriesObj = Object.assign(seriesObj , this.bar.series)
							const gridObj = this.bar.grid
							option = {
								backgroundColor: this.bar.backgroundColor,
								color: this.bar.color,
								title: titleObj,
								legend: legendObj,
								grid: gridObj,
								tooltip: tooltipObj,
								xAxis: xAxisObj,
								yAxis: yAxisObj,
								series: [seriesObj]
							};
							// 使用刚指定的配置项和数据显示图表。
							buynumberChart1.setOption(option);
							  //根据窗口的大小变动图表
							window.onresize = function() {
								buynumberChart1.resize();
							};
						}
					})
				})
			},
			chartDialogShow2() {
				this.chartVisiable2 = true
				this.chartDialog2()
			},
			// 统计接口2
			chartDialog2() {
				this.$nextTick(()=>{
					var totalChart2 = echarts.init(document.getElementById("totalChart2"),'macarons');
					let params = {}
					this.$http({
						url: "orders/value/goodname/total",
						method: "get",
						params
					}).then(({data})=>{
						if (data && data.code === 0) {
							let res = data.data;
							let xAxis = [];
							let yAxis = [];
							let pArray = []
							for(let i=0;i<res.length;i++){
								if(this.boardBase&&i==this.boardBase.funnelNum){
									break;
								}
								xAxis.push(res[i].goodname);
								yAxis.push(parseFloat((res[i].total)));
								pArray.push({
									value: parseFloat((res[i].total)),
									name: res[i].goodname
								})
							}
							var option = {};
							let titleObj = this.funnel.title
							titleObj.text = '商品销售额'
							
							let legendObj = {
								data: xAxis,
							}
							legendObj = Object.assign(legendObj , this.funnel.legend)
							let tooltipObj = {trigger: 'item',formatter: '{b} : {c}'}
							tooltipObj = Object.assign(tooltipObj , this.funnel.tooltip?this.funnel.tooltip:{})
							let seriesObj = {
								name: '商品销售额',
								data: pArray,
								type: 'funnel',
								left: '10%',
								top: 60,
								bottom: 60,
								width: '80%',
								minSize: '0%',
								maxSize: '100%',
							}
							seriesObj = Object.assign(seriesObj , this.funnel.series)
							const gridObj = this.funnel.grid
							option = {
								backgroundColor: this.funnel.backgroundColor,
								color: this.funnel.color,
								title: titleObj,
								legend: legendObj,
								tooltip: tooltipObj,
								series: seriesObj,
								grid: gridObj
							}
							// 使用刚指定的配置项和数据显示图表。
							totalChart2.setOption(option);
							  //根据窗口的大小变动图表
							window.onresize = function() {
								totalChart2.resize();
							};
						}
					})
				})
			},
			chartDialogShow3() {
				this.chartVisiable3 = true
				this.chartDialog3()
			},
			// 统计接口3
			chartDialog3() {
				this.$nextTick(()=>{
					var buynumberChart3 = echarts.init(document.getElementById("buynumberChart3"),'macarons');
					let params = {}
					this.$http({
						url: "orders/value/goodtype/buynumber",
						method: "get",
						params
					}).then(({data})=>{
						if (data && data.code === 0) {
							let res = data.data;
							let xAxis = [];
							let yAxis = [];
							let pArray = []
							for(let i=0;i<res.length;i++){
								if(this.boardBase&&i==this.boardBase.pieNum){
									break;
								}
								xAxis.push(res[i].goodtype);
								yAxis.push(parseFloat((res[i].total)));
								pArray.push({
									value: parseFloat((res[i].total)),
									name: res[i].goodtype
								})
							}
							var option = {};
							let titleObj = this.pie.title
							titleObj.text = '商品类销量'
							
							const legendObj = this.pie.legend
							let tooltipObj = {trigger: 'item',formatter: '{b} : {c} ({d}%)'}
							tooltipObj = Object.assign(tooltipObj , this.pie.tooltip?this.pie.tooltip:{})
							
							let seriesObj = {
								type: 'pie',
								radius: '55%',
								center: ['50%', '60%'],
								data: pArray,
								emphasis: {
									itemStyle: {
										shadowBlur: 10,
										shadowOffsetX: 0,
										shadowColor: 'rgba(0, 0, 0, 0.5)'
									}
								}
							}
							seriesObj = Object.assign(seriesObj , this.pie.series)
							const gridObj = this.pie.grid
							option = {
								backgroundColor: this.pie.backgroundColor,
								color: this.pie.color,
								title: titleObj,
								legend: legendObj,
								grid: gridObj,
								tooltip: tooltipObj,
								series: [seriesObj]
							};
							// 使用刚指定的配置项和数据显示图表。
							buynumberChart3.setOption(option);
							  //根据窗口的大小变动图表
							window.onresize = function() {
								buynumberChart3.resize();
							};
						}
					})
				})
			},
			chartDialogShow4() {
				this.chartVisiable4 = true
				this.chartDialog4()
			},
			// 统计接口4
			chartDialog4() {
				this.$nextTick(()=>{
					var totalChart4 = echarts.init(document.getElementById("totalChart4"),'macarons');
					let params = {}
					this.$http({
						url: "orders/value/goodtype/total",
						method: "get",
						params
					}).then(({data})=>{
						if (data && data.code === 0) {
							let res = data.data;
							let xAxis = [];
							let yAxis = [];
							let pArray = []
							for(let i=0;i<res.length;i++){
								if(this.boardBase&&i==this.boardBase.pieNum){
									break;
								}
								xAxis.push(res[i].goodtype);
								yAxis.push(parseFloat((res[i].total)));
								pArray.push({
									value: parseFloat((res[i].total)),
									name: res[i].goodtype
								})
							}
							var option = {};
							let titleObj = this.pie.title
							titleObj.text = '商品类销售额'
							
							const legendObj = this.pie.legend
							let tooltipObj = {trigger: 'item',formatter: '{b} : {c} ({d}%)'}
							tooltipObj = Object.assign(tooltipObj , this.pie.tooltip?this.pie.tooltip:{})
							
							let seriesObj = {
								type: 'pie',
								radius: ['25%', '55%'],
								center: ['50%', '60%'],
								data: pArray,
								emphasis: {
									itemStyle: {
										shadowBlur: 10,
										shadowOffsetX: 0,
										shadowColor: 'rgba(0, 0, 0, 0.5)'
									}
								}
							}
							seriesObj = Object.assign(seriesObj , this.pie.series)
							const gridObj = this.pie.grid
							option = {
								backgroundColor: this.pie.backgroundColor,
								color: this.pie.color,
								title: titleObj,
								legend: legendObj,
								grid: gridObj,
								tooltip: tooltipObj,
								series: [seriesObj]
							};
							// 使用刚指定的配置项和数据显示图表。
							totalChart4.setOption(option);
							  //根据窗口的大小变动图表
							window.onresize = function() {
								totalChart4.resize();
							};
						}
					})
				})
			},
			init () {
			},
			search() {
				this.pageIndex = 1;
				this.getDataList();
			},

			// 获取数据列表
			getDataList() {
				this.dataListLoading = true;
				let params = {
					page: this.pageIndex,
					limit: this.pageSize,
					sort: 'id',
					order: 'desc',
					status: this.$route.params.status,
				}
				if(this.searchForm.orderid!='' && this.searchForm.orderid!=undefined){
					params['orderid'] = '%' + this.searchForm.orderid + '%'
				}
				if(this.searchForm.type!='' && this.searchForm.type!=undefined){
					params['type'] = this.searchForm.type
				}
				let user = JSON.parse(this.$storage.getObj('userForm'))
				this.$http({
					url: "orders/page",
					method: "get",
					params: params
				}).then(({ data }) => {
					if (data && data.code === 0) {
						this.dataList = data.data.list;
						this.totalPage = data.data.total;
					} else {
						this.dataList = [];
						this.totalPage = 0;
					}
					this.dataListLoading = false;
				});
			},
			// 每页数
			sizeChangeHandle(val) {
				this.pageSize = val;
				this.pageIndex = 1;
				this.getDataList();
			},
			// 当前页
			currentChangeHandle(val) {
				this.pageIndex = val;
				this.getDataList();
			},
			// 多选
			selectionChangeHandler(val) {
				this.dataListSelections = val;
			},
			// 添加/修改
			addOrUpdateHandler(id,type) {
				this.showFlag = false;
				this.addOrUpdateFlag = true;
				this.crossAddOrUpdateFlag = false;
				if(type!='info'&&type!='msg'){
					type = 'else';
				}
				this.$nextTick(() => {
					this.$refs.addOrUpdate.init(id,type );
				});
			},
			async getAllList() {
				return new Promise(async(resolve, reject) => {
					await this.$http({
						url: 'orders/page',
						method: 'get',
						params: {
							limit: 10000
						}
					}).then(rs => {
						resolve(rs.data.data.list)
					})
				})
			
			},
			// 删除
			async deleteHandler(id ) {
				var ids = id? [Number(id)]: this.dataListSelections.map(item => {
					return Number(item.id);
				});
				await this.$confirm(`确定进行[${id ? "删除" : "批量删除"}]操作?`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(async () => {
					await this.$http({
						url: "orders/delete",
						method: "post",
						data: ids
					}).then(async ({ data }) => {
						if (data && data.code === 0) {
							this.$message({
								message: "操作成功",
								type: "success",
								duration: 1500,
								onClose: () => {
									this.search();
								}
							});
			
						} else {
							this.$message.error(data.msg);
						}
					});
				});
			},


		}

	};
</script>
<style lang="scss" scoped>
	//导出excel
	.export-excel-wrapper{
		display: inline-block;
	}
	
	.center-form-pv {
		.el-date-editor.el-input {
			width: auto;
		}
	}
	
	.el-input {
		width: auto;
	}
	
	// form
	.center-form-pv .el-input {
		width: 100%;
	}
	.center-form-pv .el-input /deep/ .el-input__inner {
		border: 1px solid #DADFE6;
		border-radius: 4px;
		padding: 0 12px;
		box-shadow: none;
		outline: none;
		color: #333;
		width: 100%;
		font-size: 16px;
		height: 41px;
	}
	.center-form-pv .el-select {
		width: 100%;
	}
	.center-form-pv .el-select /deep/ .el-input__inner {
		border:  1px solid #0098EF;
		border-radius: 4px;
		padding: 0 10px;
		box-shadow: none;
		outline: none;
		color:  #0098EF;
		width: 100%;
		font-size: 16px;
		height: 41px;
	}
	.center-form-pv .el-date-editor {
		width: 100%;
	}
	
	.center-form-pv .el-date-editor /deep/ .el-input__inner {
		border: 1px solid #DADFE6;
		border-radius: 4px;
		padding: 0 10px 0 30px;
		box-shadow: none;
		outline: none;
		color: #333;
		width: 100%;
		font-size: 16px;
		height: 41px;
	}
	
	.center-form-pv .search {
		border: 1px solid #09A5FF;
		cursor: pointer;
		border-radius: 8px 8px 8px 8px;
		padding: 0 12px 0 10px;
		box-shadow:  inset 0px 3px 6px 1px #9ADAFF;
		outline: none;
		color: #fff;
		background:  linear-gradient( 180deg, #0098EF 0%, #0075B8 100%);
		width: 122px;
		font-size: 16px;
		height: 42px;
	}
	
	.center-form-pv .search:hover {
		opacity: 0.8;
	}
	
	.center-form-pv .actions .add {
		border: 1px solid #0098EF;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 4px;
		outline: none;
		color: #0098EF;
		background: #fff;
		width: auto;
		font-size: 14px;
		height: 36px;
	}
	
	.center-form-pv .actions .add:hover {
		opacity: 0.8;
	}
	
	.center-form-pv .actions .del {
		border: 1px solid #0098EF;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 4px;
		outline: none;
		color: #0098EF;
		background: #fff;
		width: auto;
		font-size: 14px;
		height: 36px;
	}
	
	.center-form-pv .actions .del:hover {
		opacity: 0.8;
	}
	
	.center-form-pv .actions .statis {
		border: 1px solid #0098EF;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 4px;
		outline: none;
		color: #0098EF;
		background: #fff;
		width: auto;
		font-size: 14px;
		height: 36px;
	}
	
	.center-form-pv .actions .statis:hover {
		opacity: 0.8;
	}
	
	.center-form-pv .actions .btn18 {
		border: 1px solid #0098EF;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 4px;
		outline: none;
		color: #0098EF;
		background: #fff;
		width: auto;
		font-size: 14px;
		height: 36px;
	}
	
	.center-form-pv .actions .btn18:hover {
		opacity: 0.8;
	}
	
	// table
	.el-table /deep/ .el-table__header-wrapper thead {
		color: #0098EF;
		background: linear-gradient( 180deg, #FCFCFC 0%, #E5E5E5 100%);
		font-weight: 500;
		width: 100%;
	}
	
	.el-table /deep/ .el-table__header-wrapper thead tr {
		background: none;
	}
	
	.el-table /deep/ .el-table__header-wrapper thead tr th {
		padding: 12px 0;
		background: none;
		border-color: #999999;
		border-width: 0;
		border-style: solid;
		text-align: center;
	}

	.el-table /deep/ .el-table__header-wrapper thead tr th .cell {
		padding: 0 0 0 5px;
		word-wrap: normal;
		color: #0098EF;
		white-space: normal;
		font-weight: bold;
		display: flex;
		vertical-align: middle;
		font-size: 15px;
		line-height: 24px;
		text-overflow: ellipsis;
		word-break: break-all;
		width: 100%;
		justify-content: flex-start;
		align-items: center;
		position: relative;
		min-width: 110px;
	}

	.el-table /deep/ .el-table__body-wrapper {
		position: relative;
	}
	.el-table /deep/ .el-table__body-wrapper tbody {
		width: 100%;
	}

	.el-table /deep/ .el-table__body-wrapper tbody tr {
		background: #fff;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td {
		padding: 4px 0;
		color: #555;
		background: none;
		border-color: #999999;
		border-width: 0 0px 1px 0;
		border-style: solid;
		text-align: left;
	}
	
		
	.el-table /deep/ .el-table__body-wrapper tbody tr:hover td {
		padding: 4px 0;
		color: #000;
		background: #f4f8fe;
		border-color: #999999;
		border-width: 0 0px 1px 0;
		border-style: solid;
		text-align: left;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td {
		padding: 4px 0;
		color: #555;
		background: none;
		border-color: #999999;
		border-width: 0 0px 1px 0;
		border-style: solid;
		text-align: left;
	}

	.el-table /deep/ .el-table__body-wrapper tbody tr td .cell {
		padding: 0 0 0 5px;
		overflow: hidden;
		color: #212D3F;
		word-break: break-all;
		white-space: normal;
		font-size: inherit;
		line-height: 24px;
		text-overflow: ellipsis;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .view {
		border: 0px solid #216db4;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		outline: none;
		color: #0098EF;
		background: none;
		width: auto;
		font-size: 14px;
		height: 32px;
		order: 3;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .view:hover {
		opacity: 0.8;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .add {
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .add:hover {
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .edit {
		border: 0px solid #22c08e;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		outline: none;
		color: #0098EF;
		background: none;
		width: auto;
		font-size: 14px;
		height: 32px;
		order: -1;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .edit:hover {
		opacity: 0.8;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .del {
		border: 0px solid #0098EF;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		outline: none;
		color: #0098EF;
		background: none;
		width: auto;
		font-size: 14px;
		height: 32px;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .del:hover {
		opacity: 0.8;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .btn8 {
		border: 0px solid #70a0fa;
		cursor: pointer;
		border-radius: 6px;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		outline: none;
		color: #0098EF;
		background: none;
		width: auto;
		font-size: 14px;
		height: 32px;
		order: 5;
	}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .btn8:hover {
		opacity: 0.8;
	}
	
	// pagination
	.main-content .el-pagination /deep/ .el-pagination__total {
		margin: 0 20px 0 0;
		color: #333333;
		font-weight: 600;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		line-height: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .btn-prev {
		border: 1px solid #333333;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #212D3F;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #fff;
		width: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .btn-next {
		border: 1px solid #333333;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #212D3F;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #fff;
		width: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .btn-prev:disabled {
		border: 1px solid #333333;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #212D3F;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #eee;
		width: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .btn-next:disabled {
		border: 1px solid #333333;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #212D3F;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #eee;
		width: 40px;
		height: 40px;
	}

	.main-content .el-pagination /deep/ .el-pager {
		padding: 0;
		margin: 0;
		display: inline-block;
		vertical-align: top;
	}

	.main-content .el-pagination /deep/ .el-pager .number {
		border: 1px solid #333333;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #333333;
		font-weight: 600;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		line-height: 40px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #fff;
		width: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .el-pager .number:hover {
		border: 1px solid #333333;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #212D3F;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		line-height: 40px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #fff;
		width: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .el-pager .number.active {
		border: 1px solid #0098EF;
		cursor: not-allowed;
		padding: 0;
		margin: 0 5px;
		color: #0098EF;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		line-height: 40px;
		border-radius: 8px  8px  8px  8px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		background: #fff;
		width: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes {
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		line-height: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input {
		margin: 0 5px;
		width: 100px;
		position: relative;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input .el-input__inner {
		border: 1px solid #333333;
		cursor: pointer;
		padding: 0 25px 0 8px;
		color: #333333;
		font-weight: 600;
		display: inline-block;
		font-size: 15px;
		line-height: 40px;
		border-radius: 3px;
		box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		outline: 0;
		background: #FFF;
		width: 100%;
		text-align: center;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input span.el-input__suffix {
		top: 0;
		position: absolute;
		right: 0;
		height: 100%;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input .el-input__suffix .el-select__caret {
		cursor: pointer;
		color: #333333;
		width: 25px;
		font-size: 15px;
		line-height: 28px;
		text-align: center;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__jump {
		margin: 0 0 0 24px;
		color: #333333;
		font-weight: 600;
		display: inline-block;
		vertical-align: top;
		font-size: 15px;
		line-height: 40px;
		height: 40px;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__jump .el-input {
		border-radius: 3px;
		padding: 0 2px;
		margin: 0 2px;
		display: inline-block;
		width: 50px;
		font-size: 15px;
		line-height: 18px;
		position: relative;
		text-align: center;
		height: 28px;
	}
	
	.main-content .el-pagination /deep/ .el-pagination__jump .el-input .el-input__inner {
		border: 1px solid #333333;
		cursor: pointer;
		padding: 0 3px;
		color: #333333;
		font-weight: 600;
		display: inline-block;
		font-size: 15px;
		line-height: 40px;
		border-radius: 8px;
		box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		outline: 0;
		background: #FFF;
		width: 100%;
		text-align: center;
		height: 40px;
	}
	
	// list one
	.one .list1-view {
		border: 0;
		cursor: pointer;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		color: #095dac;
		font-size: 14px;
		border-radius: 30px;
		outline: none;
		background: #00c7f230;
		width: auto;
		min-width: 60px;
		height: 32px;
		order: 3;
	}
	
	.one .list1-view:hover {
		opacity: 0.8;
	}
	
	.one .list1-edit {
		border: 0;
		cursor: pointer;
		border-radius: 30px;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		outline: none;
		color: #4f7df5;
		background: #edf2ff;
		width: auto;
		font-size: 14px;
		min-width: 60px;
		height: 32px;
	}
	
	.one .list1-edit:hover {
		opacity: 0.8;
	}
	
	.one .list1-del {
		border: 0;
		cursor: pointer;
		border-radius: 30px;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		outline: none;
		color: #f00;
		background: #ffefed;
		width: auto;
		font-size: 14px;
		min-width: 60px;
		height: 32px;
	}
	
	.one .list1-del:hover {
		opacity: 0.8;
	}
	
	.one .list1-btn8 {
		border: 0;
		cursor: pointer;
		padding: 0 10px;
		margin: 0 5px 5px 0;
		color: #095dac;
		font-size: 14px;
		border-radius: 30px;
		outline: none;
		background: #aaceec50;
		width: auto;
		min-width: 60px;
		height: 32px;
		order: 11;
	}
	
	.one .list1-btn8:hover {
		opacity: 0.8;
	}
	
	.main-content .el-table .el-switch {
		display: inline-flex;
		vertical-align: middle;
		line-height: 30px;
		position: relative;
		align-items: center;
		height: 30px;
	}
	.main-content .el-table .el-switch /deep/ .el-switch__label--left {
		cursor: pointer;
		margin: 0 10px 0 0;
		color: #333;
		font-weight: 500;
		display: none;
		vertical-align: middle;
		font-size: 16px;
		transition: .2s;
		height: 30px;
	}
	.main-content .el-table .el-switch /deep/ .el-switch__label--right {
		cursor: pointer;
		margin: 0 0 0 10px;
		color: #333;
		font-weight: 500;
		display: none;
		vertical-align: middle;
		font-size: 16px;
		transition: .2s;
		height: 30px;
	}
	.main-content .el-table .el-switch /deep/ .el-switch__core {
		border: 1px solid #ff8b00;
		cursor: pointer;
		border-radius: 15px;
		margin: 0;
		outline: 0;
		background: #ff8b00;
		display: inline-block;
		width: 36px;
		box-sizing: border-box;
		transition: border-color .3s,background-color .3s;
		height: 18px;
	}
	.main-content .el-table .el-switch /deep/ .el-switch__core::after {
		border-radius: 100%;
		top: 1px;
		left: 2px;
		background: #FFF;
		width: 14px;
		position: absolute;
		transition: all .3s;
		height: 14px;
	}
	.main-content .el-table .el-switch.is-checked /deep/ .el-switch__core::after {
		margin: 0 0 0 -16px;
		left: 100%;
	}
	
	.main-content .el-table .el-rate /deep/ .el-rate__item {
		cursor: pointer;
		display: inline-block;
		vertical-align: middle;
		font-size: 0;
		position: relative;
	}
	.main-content .el-table .el-rate /deep/ .el-rate__item .el-rate__icon {
		margin: 0 3px;
		display: inline-block;
		font-size: 18px;
		position: relative;
		transition: .3s;
	}

	.chartDialog /deep/ .el-dialog {
		background: #fff;
	}
</style>
