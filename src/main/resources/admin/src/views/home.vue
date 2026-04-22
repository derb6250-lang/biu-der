<template>
	<div class="home-content" :style="{'backgroundImage': indexBgUrl?`url(${$base.url + indexBgUrl})`:''}">
		<!-- title -->
		<div id="home-title" class="home-title animate__animated">
			<div class="titles" >
				<span>欢迎使用</span>
				{{this.$project.projectName}}
			</div>
		</div>
		<!-- statis -->
		<div class="statis-box">
			<div id="statis1" class="statis1 animate__animated" v-if="isAuth('orders','首页总数')">
				<div class="left">
					<span class="icon iconfont icon-liulan12"></span>
				</div>
				<div class="right">
					<div class="num">{{ordersCount}}</div>
					<div class="name">订单总数</div>
				</div>
			</div>
		</div>
		<!-- statis -->
	
		<!-- echarts -->
		<!-- 4 -->
		<div class="type4">
			<div class="echarts1 animate__animated" v-if="isAuth('orders','首页统计',2)">
				<div id="ordersChart1" style="width: 100%;height: 100%"></div>
			</div>
			<div class="echarts2 animate__animated" v-if="isAuth('orders','首页统计',2)">
				<div id="ordersChart2" style="width: 100%;height: 100%"></div>
			</div>
			<div class="echarts3 animate__animated" v-if="isAuth('orders','首页统计',2)">
				<div id="ordersChart3" style="width: 100%;height: 100%"></div>
			</div>
			<div class="echarts4 animate__animated" v-if="isAuth('orders','首页统计',2)">
				<div id="ordersChart4" style="width: 100%;height: 100%"></div>
			</div>
		</div>
		<!-- echarts -->
	</div>
</template>
<script>
import 'animate.css'
//4
import router from '@/router/router-static'
import * as echarts from 'echarts'
export default {
	data() {
		return {
			ordersCount: 0,
			line: {"backgroundColor":"transparent","yAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":15,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"minInterval":1,"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,0.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"xAxis":{"axisLabel":{"borderType":"solid","rotate":30,"padding":0,"shadowOffsetX":0,"margin":10,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"truncate","borderRadius":0,"borderWidth":0,"width":120,"interval":0,"fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":false},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"color":["#378bb9","#095dac","#fbc62f","#16606a","#f75d5f","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"legend":{"padding":0,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":20,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"showSymbol":true,"symbol":"pin","symbolSize":18},"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"}},
			bar: {"backgroundColor":"transparent","yAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":12,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"minInterval":1,"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,0.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"xAxis":{"axisLabel":{"borderType":"solid","rotate":30,"padding":0,"shadowOffsetX":0,"margin":10,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"truncate","borderRadius":0,"borderWidth":0,"width":120,"interval":0,"fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":false},"minInterval":1,"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"color":["#378bb9","#095dac","#DEDEDE","#3B8527","#f75d5f","#D82727","#333333","#9ab7a8","#ea7ccc"],"legend":{"padding":0,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":20,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":12,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"grid":{"x":"25%","y":"15%","y2":"15%","x2":"5%"},"series":{"barWidth":"22px","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#f2f8d4","shadowOffsetY":0,"color":{"x":0,"y":0,"y2":1,"x2":0,"global":false,"colorStops":[{"offset":0,"color":"#2fa4e7"},{"offset":1,"color":"#80b1cc"}],"type":"linear"},"shadowBlur":0,"borderWidth":0,"barBorderRadius":[4,4,0,0],"opacity":1,"shadowColor":"#000"},"colorBy":"data","label":{"formatter":"","show":true,"position":"top"},"barCategoryGap":"10%"},"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"subtext":"","shadowBlur":0,"bottom":"auto","show":true,"right":"auto","subtextStyle":{"padding":[5,0,0,0],"borderColor":"red","color":"red","borderWidth":10},"top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"},"base":{"animate":false,"interval":2000}},
			pie: {"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"backgroundColor":"transparent","color":["#449A2D","#2FA4E7","#80B1CC","#212D3F","#09A5FF","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"title":{"borderType":"solid","padding":[5,0,0,0],"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","fontSize":14,"lineHeight":14,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"},"legend":{"padding":[5,0,0,0],"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":2,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":0,"top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":2,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":12,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#666","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"label":{"borderType":"solid","rotate":0,"padding":0,"textBorderWidth":0,"backgroundColor":"transparent","borderColor":"#666","color":"inherit","show":true,"textShadowColor":"transparent","distanceToLabelLine":5,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"fontSize":12,"lineHeight":18,"textShadowOffsetX":0,"position":"outside","textShadowOffsetY":0,"textBorderType":"solid","textBorderColor":"#666","textShadowBlur":0},"labelLine":{"show":true,"length":10,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"#000"},"length2":14,"smooth":false}}},
			funnel: {"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"backgroundColor":"transparent","color":["#449A2D","#2FA4E7","#80B1CC","#212D3F","#09A5FF","#5967cc","#f75d5f","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"title":{"borderType":"solid","padding":2,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"center","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","fontSize":14,"lineHeight":12,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"#ccc","textShadowBlur":0},"shadowColor":"transparent"},"legend":{"padding":5,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"orient":"vertical","shadowBlur":0,"bottom":"auto","itemHeight":2,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"left","borderWidth":0,"width":"auto","itemWidth":2,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":20,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#000","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"label":{"borderType":"solid","rotate":0,"padding":0,"textBorderWidth":0,"backgroundColor":"transparent","borderColor":"#fff","color":"","show":true,"textShadowColor":"transparent","distanceToLabelLine":5,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"fontSize":12,"lineHeight":18,"textShadowOffsetX":0,"position":"outside","textShadowOffsetY":0,"textBorderType":"solid","textBorderColor":"#fff","textShadowBlur":0},"labelLine":{"show":true,"length":10,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"#000"},"length2":14,"smooth":false}}},
			boardBase: {"funnelNum":8,"lineNum":8,"radarNum":8,"gaugeNum":8,"barNum":8,"pieNum":8},
			gauge: {"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#fff"}},"backgroundColor":"transparent","color":["#449A2D","#2FA4E7","#80B1CC","#212D3F","#09A5FF","#5967cc","#f75d5f","#5967cc","#faa07b","#9ab7a8","#ea7ccc"],"title":{"top":"top","left":"left","textStyle":{"fontSize":14,"lineHeight":24,"color":"#333","fontWeight":600}},"series":{"pointer":{"offsetCenter":[0,"10%"],"icon":"path://M2.9,0.7L2.9,0.7c1.4,0,2.6,1.2,2.6,2.6v115c0,1.4-1.2,2.6-2.6,2.6l0,0c-1.4,0-2.6-1.2-2.6-2.6V3.3C0.3,1.9,1.4,0.7,2.9,0.7z","width":8,"length":"80%"},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"opacity":0.5,"shadowBlur":1,"shadowColor":"#000"},"roundCap":true},"anchor":{"show":true,"itemStyle":{"color":"inherit"},"size":18,"showAbove":true},"emphasis":{"disabled":false},"progress":{"show":true,"roundCap":true,"overlap":true},"splitNumber":25,"detail":{"formatter":"{value}","backgroundColor":"inherit","color":"#fff","borderRadius":3,"width":20,"fontSize":12,"height":10},"title":{"fontSize":14},"animation":true}},
			radar: {"backgroundColor":"transparent","radar":{"shape":"circle"},"color":["#365E77","#DF308C","#0CB906","#7690cb","#49ada0","#5BBAEC","#a68a28","#EE142F","#FFE9E9"],"legend":{"padding":5,"itemGap":5,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"orient":"vertical","shadowBlur":0,"bottom":"auto","itemHeight":4,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"auto","itemWidth":4,"textStyle":{"textBorderWidth":0,"color":"inherit","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{},"tooltip":{"backgroundColor":"#123","textStyle":{"color":"#7987FD"}},"title":{"top":"top","left":"left","textStyle":{"textBorderWidth":0,"color":"#365E77","textShadowColor":"transparent","fontSize":14,"lineHeight":14,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0}}},
			indexBgUrl: '',
			indexLogoUrl: '',
		};
	},
	mounted(){
		this.init();
		this.getordersCount();
		if(this.isAuth('orders','首页统计',2)){
			this.ordersChat1();
		}
		if(this.isAuth('orders','首页统计',2)){
			this.ordersChat2();
		}
		if(this.isAuth('orders','首页统计',2)){
			this.ordersChat3();
		}
		if(this.isAuth('orders','首页统计',2)){
			this.ordersChat4();
		}
		window.addEventListener('scroll', this.handleScroll)
		setTimeout(()=>{
			this.handleScroll()
		},100)
	},
	created() {
		this.$http.get('config/info?name=bIndexBackgroundImg',).then(rs=>{this.indexBgUrl = rs.data.data?rs.data.data.value:''})
		this.$http.get('config/info?name=bHomeLogo',).then(rs=>{this.indexLogoUrl = rs.data.data?rs.data.data.value:''})
	},
	computed: {
		sessionForm() {
			return JSON.parse(this.$storage.getObj('userForm'))
		},
		avatar(){
			return this.$storage.get('headportrait')?this.$storage.get('headportrait'):''
		},
	},
	methods:{
		handleScroll() {
			let arr = [
				{id:'home-title',css:'animate__'},
				{id:'statis1',css:'animate__'},
				{id:'ordersChart1',css:'animate__'},
				{id:'ordersChart2',css:'animate__'},
				{id:'ordersChart3',css:'animate__'},
				{id:'ordersChart4',css:'animate__'},
			]
			
			for (let i in arr) {
				let doc = document.getElementById(arr[i].id)
				if (doc) {
					let top = doc.offsetTop
					let win_top = window.innerHeight + window.pageYOffset
					// console.log(top,win_top)
					if (win_top > top && doc.classList.value.indexOf(arr[i].css) < 0) {
						// console.log(doc)
						doc.classList.add(arr[i].css)
					}
				}
			}
		},
		// 统计图动画
		myChartInterval(type, xAxisData, seriesData, myChart) {
			this.$nextTick(() => {
				setInterval(() => {
					let xAxis = xAxisData.shift()
					xAxisData.push(xAxis)
					let series = seriesData.shift()
					seriesData.push(series)
				
					if (type == 1) {
						myChart.setOption({
							xAxis: [{
								data: xAxisData
							}],
							series: [{
								data: seriesData
							}]
						});
					}
					if (type == 2) {
						myChart.setOption({
							yAxis: [{
								data: xAxisData
							}],
							series: [{
								data: seriesData
							}]
						});
					}
				}, $template2.back.board.bar.base.interval);
			})
		},
		changeStatQuery(arr) {
			if(arr.length==1) {
				if(arr[0] == 'users'&&this.$storage.get("sessionTable")=='users') {
					return true
				}
			}
			let role = this.$storage.get('role')
			for(let x in arr) {
				if(arr[x] == role) {
					return true
				}
			}
			return false
		},
		init(){
			if(this.$storage.get('Token')){
				this.$http({
					url: `${this.$storage.get('sessionTable')}/session`,
					method: "get"
				}).then(({ data }) => {
					if (data && data.code != 0) {
						router.push({ name: 'login' })
					}
				});
			}else{
				router.push({ name: 'login' })
			}
		},
		getordersCount() {
			this.$http({
				url: `orders/count`,
				method: "get"
			}).then(({
				data
			}) => {
				if (data && data.code == 0) {
					this.ordersCount = data.data
				}
			})
		},
		ordersChat1(e=null) {
			this.$nextTick(()=>{
				var ordersChart1 = echarts.init(document.getElementById("ordersChart1"),'macarons');
				let params = {}
				this.$http({
					url: `orders/value/goodname/buynumber`,
					method: "get",
					params
				}).then(({ data }) => {
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
						ordersChart1.setOption(option);
				
						//根据窗口的大小变动图表
						window.onresize = function() {
							ordersChart1.resize();
						};
					}else{
						this.$message({
							message: data.msg,
							type: "warning",
							duration: 1500,
						})
					}
				});
			})
		},

		ordersChat2(e=null) {
			this.$nextTick(()=>{

				var ordersChart2 = echarts.init(document.getElementById("ordersChart2"),'macarons');
				let params = {}
				this.$http({
					url: `orders/value/goodname/total`,
					method: "get",
					params
				}).then(({ data }) => {
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
						ordersChart2.setOption(option);
				
						//根据窗口的大小变动图表
						window.onresize = function() {
							ordersChart2.resize();
						};
					}else{
						this.$message({
							message: data.msg,
							type: "warning",
							duration: 1500,
						})
					}
				});
			})
		},

		ordersChat3(e=null) {
			this.$nextTick(()=>{

				var ordersChart3 = echarts.init(document.getElementById("ordersChart3"),'macarons');
				let params = {}
				this.$http({
					url: `orders/value/goodtype/buynumber`,
					method: "get",
					params
				}).then(({ data }) => {
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
							tooltip: tooltipObj,
							series: [seriesObj],
							grid: gridObj
						};
						// 使用刚指定的配置项和数据显示图表。
						ordersChart3.setOption(option);
						//根据窗口的大小变动图表
						window.onresize = function() {
							ordersChart3.resize();
						};
					}else{
						this.$message({
							message: data.msg,
							type: "warning",
							duration: 1500,
						})
					}
				});
			})
		},
		ordersChat4(e=null) {
			this.$nextTick(()=>{

				var ordersChart4 = echarts.init(document.getElementById("ordersChart4"),'macarons');
				let params = {}
				this.$http({
					url: `orders/value/goodtype/total`,
					method: "get",
					params
				}).then(({ data }) => {
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
							tooltip: tooltipObj,
							series: [seriesObj],
							grid: gridObj
						};
						// 使用刚指定的配置项和数据显示图表。
						ordersChart4.setOption(option);

						//根据窗口的大小变动图表
						window.onresize = function() {
							ordersChart4.resize();
						};
					}else{
						this.$message({
							message: data.msg,
							type: "warning",
							duration: 1500,
						})
					}
				});
			})
		},
	}
};
</script>
<style lang="scss" scoped>
	.home-content {
		padding: 0 30px 30px;
		background: url(http://codegen.caihongy.cn/20250919/e9093c14b6ae42c7ac988cde5c632c46.png) no-repeat center top / cover;
		display: flex;
		width: 100%;
		min-height: 100vh;
		flex-wrap: wrap;
		.home-title {
			padding: 10px 0 0;
			box-shadow: none;
			margin: 10px 0 0;
			display: flex;
			width: 100%;
			justify-content: center;
			align-items: center;
			transition: 0.3s;
			.titles {
				padding: 0;
				color: #333;
				font-size: 30px;
				line-height: 60px;
				span {
				}
			}
		}
		.home-title:hover {
			transform: translate3d(0, 0px, 0);
		}
		.statis-box {
			margin: 20px 0;
			background: none;
			display: flex;
			width: 100%;
			justify-content: center;
			align-items: center;
			flex-wrap: wrap;
			.statis1 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #0098EF;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis1:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis2 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #449A2D;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis2:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis3 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #0098EF;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis3:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis4 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #449A2D;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis4:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis5 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #0098EF;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis5:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis6 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #449A2D;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis6:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis7 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #0098EF;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis7:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis8 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #449A2D;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis8:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis9 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 48px;
					justify-content: center;
					align-items: center;
					height: 48px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #0098EF;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis9:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.statis10 {
				border: 1px solid #E3E3E3;
				border-radius: 0px;
				box-shadow: none;
				padding: 20px;
				margin: 10px;
				background: linear-gradient( 180deg, #D3DEEB 0%, #FAFBFD 52%, #FEFEFF 100%);
				display: flex;
				width: calc(20% - 20px);
				transition: 0.3s;
				height: 130px;
				.left {
					background: none;
					display: flex;
					width: 112px;
					justify-content: center;
					align-items: center;
					height: 96px;
					order: 2;
					.iconfont {
						border-radius: 0;
						padding: 0;
						color: #0098EF;
						background: none;
						font-weight: 600;
						width: 48px;
						font-size: 44px;
						line-height: 40px;
						text-align: center;
						height: 40px;
					}
				}
				.right {
					flex-direction: column;
					display: flex;
					width: 100%;
					justify-content: space-between;
					.num {
						margin: 5px 0;
						color: #449A2D;
						font-weight: 600;
						font-size: 30px;
						line-height: 24px;
						height: 24px;
						order: 2;
					}
					.name {
						margin: 5px 0;
						color: #212D3F;
						font-weight: 600;
						font-size: 18px;
						line-height: 24px;
						height: 24px;
					}
				}
			}
			.statis10:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
		}
		// echarts4
		.type4 {
			padding: 0;
			align-content: flex-start;
			background: none;
			display: flex;
			width: 100%;
			justify-content: space-between;
			flex-wrap: wrap;
			height: auto;
			.echarts1 {
				border-radius: 8px;
				padding: 20px;
				box-shadow: 4px 3px 10px 1px rgba(226,226,226,0.44);
				margin: 10px;
				background: rgba(255,255,255,1);
				width: calc(50% - 20px);
				transition: 0.3s;
				height: 550px;
			}
			.echarts1:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.echarts2 {
				border-radius: 8px;
				padding: 20px;
				box-shadow: 4px 3px 10px 1px rgba(226,226,226,0.44);
				margin: 10px;
				background: rgba(255,255,255,1);
				width: calc(50% - 20px);
				transition: 0.3s;
				height: 550px;
			}
			.echarts2:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.echarts3 {
				border-radius: 8px;
				padding: 20px;
				box-shadow: 4px 3px 10px 1px rgba(226,226,226,0.44);
				margin: 10px;
				background: rgba(255,255,255,1);
				width: calc(50% - 20px);
				transition: 0.3s;
				height: 550px;
			}
			.echarts3:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
			.echarts4 {
				border-radius: 8px;
				padding: 20px;
				box-shadow: 4px 3px 10px 1px rgba(226,226,226,0.44);
				margin: 10px;
				background: rgba(255,255,255,1);
				width: calc(50% - 20px);
				transition: 0.3s;
				height: 550px;
			}
			.echarts4:hover {
				box-shadow: 0 3px 0px rgba(0,0,0,.1);
				transform: translate3d(0, -6px, 0);
				z-index: 1;
				background: rgba(255,255,255,1);
			}
		}
	}
	
	.echarts-flag-2 {
		display: flex;
		flex-wrap: wrap;
		justify-content: space-between;
		padding: 10px 20px;
		background: rebeccapurple;
	
		&>div {
			width: 32%;
			height: 300px;
			margin: 10px 0;
			background: rgba(255,255,255,.1);
			border-radius: 8px;
			padding: 10px 20px;
		}
	}
	.animate__animated {
		animation-fill-mode: none;
	}
</style>
