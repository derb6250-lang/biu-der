<template>
	<div>
		<div class="breadcrumb-preview">
			<el-breadcrumb :separator="'>'">
				<el-breadcrumb-item class="item1" to="/"><a>首页</a></el-breadcrumb-item>
				<el-breadcrumb-item class="item2" v-for="(item, index) in breadcrumbItem" :key="index" :to="'/index/youhuihuodong?centerType=' + (centerType?'1':'0')"><a>{{item.name}}</a></el-breadcrumb-item>
				<el-breadcrumb-item class="item3"><a href="javascript:void(0);">详情</a></el-breadcrumb-item>
			</el-breadcrumb>
		</div>
		<div class="back_box">
			<el-button class="backBtn" size="mini" @click="backClick">
				<span class="icon iconfont icon-fanhui21"></span>
				<span class="text">返回</span>
			</el-button>
		</div>
		<div class="detail-preview">
			<div class="attr">
				<div class="info">
					<div class="title-item">
						<div class="detail-title">
							{{detail.huodongmingcheng}}
						</div>
					</div>
					<div class="item">
						<div class="lable">活动内容</div>
						<div class="text "  >{{detail.huodongneirong}}</div>
					</div>
					<div class="item">
						<div class="lable">活动日期</div>
						<div class="text "  >{{detail.huodongriqi}}</div>
					</div>
					<div class="item">
						<div class="lable">发布时间</div>
						<div class="text "  >{{detail.fabushijian}}</div>
					</div>
					<div class="btn_box">
						<el-button class="editBtn" v-if="btnAuth('youhuihuodong','修改')" @click="editClick">修改</el-button>
						<el-button class="delBtn" v-if="btnAuth('youhuihuodong','删除')" @click="delClick">删除</el-button>
						<el-button class="editBtn" @click="allchapterClick()" type="warning" v-if="btnAuth('youhuihuodong','章节管理')">章节管理</el-button>
					</div>
				</div>
			</div>
		
			<el-carousel v-if="detailBanner.length" trigger="click" indicator-position="inside" arrow="always" type="default" direction="horizontal" height="480px" :autoplay="false" :interval="3000" :loop="true">
				<el-carousel-item v-for="item in detailBanner" :key="item.id">
					<img :preview-src-list="[item]" v-if="item.substr(0,4)=='http'" :src="item" class="image">
					<img :preview-src-list="[baseUrl + item]" v-else :src="baseUrl + item" class="image">
				</el-carousel-item>
			</el-carousel>

			<div class="zancai">
				<div v-if="!isThumbsupnum && !isCrazilynum" class="zan" @click="thumbsupOrCrazily(21)">
					<i class="icon iconfont icon-zan07"></i>
					<span class="text">赞一下({{detail.thumbsupnum}})</span>
				</div>
				<div v-if="!isThumbsupnum && !isCrazilynum" class="cai" @click="thumbsupOrCrazily(22)">
					<i class="icon iconfont icon-cai01"></i>
					<span class="text">踩一下({{detail.crazilynum}})</span>
				</div>
				<div v-if="isThumbsupnum" class="zanActive" @click="cancelThumbsupOrCrazily(21)">
					<i class="icon iconfont icon-zan11"></i>
					<span class="text">已赞({{detail.thumbsupnum}})</span>
				</div>
				<div v-if="isCrazilynum" class="caiActive" @click="cancelThumbsupOrCrazily(22)">
					<i  class="icon iconfont icon-cai16"></i>
					<span class="text">已踩({{detail.crazilynum}})</span>
				</div>
			</div>


			<el-tabs class="detail-tabs" v-model="activeName" type="border-card" v-if="tabsNum>0" >
			</el-tabs>

		</div>
		<div class="share_view">
		</div>
	</div>
</template>

<script>
	import axios from 'axios'
	import Swiper from "swiper";
	export default {
		//数据集合
		data() {
			return {
				tablename: 'youhuihuodong',
				baseUrl: '',
				breadcrumbItem: [
					{
						name: '优惠活动'
					}
				],
				title: '',
				detailBanner: [],
				userid: Number(localStorage.getItem('frontUserid')),
				id: 0,
				detail: {},
				tabsNum: 0,
				activeName: '1',
				storeupParams: {
					name: '',
					picture: '',
					refid: 0,
					tablename: 'youhuihuodong',
					userid: Number(localStorage.getItem('frontUserid'))
				},
				isCrazilynum: false,
				isThumbsupnum: false,
				thumbsupOrCrazilyInfo: {},
				buynumber: 1,
				centerType: false,
				storeupType: false,
				shareUrl: location.href,
			}
		},
		created() {
			if(this.$route.query.centerType&&this.$route.query.centerType!=0) {
				this.centerType = true
			}
			if(this.$route.query.storeupType&&this.$route.query.storeupType!=0) {
				this.storeupType = true
			}
			
			this.init();
		},
		mounted() {
		},
		computed: {
			username() {
				return localStorage.getItem('username')
			}
		},
		//方法集合
		methods: {
			init() {
				this.id = this.$route.query.id
				this.baseUrl = this.$config.baseUrl;
				this.$http.get(this.tablename + '/detail/'  + this.id, {}).then(async res => {
					if (res.data.code == 0) {
						this.detail = res.data.data;
						this.title = this.detail.huodongmingcheng;
						if(this.detail.tupian) {
							this.detailBanner = this.detail.tupian.split(",w").length>1?[this.detail.tupian]:this.detail.tupian.split(',');
						}
						this.$forceUpdate();
						if(localStorage.getItem('frontToken')){
							this.getThumbsupOrCrazilyStatus();
						}

					}
				});
			},
			async thumbsupOrCrazily(type) {
				this.storeupParams.name = this.title;
				this.storeupParams.picture = this.detailBanner[0];
				this.storeupParams.refid = this.detail.id;
				this.storeupParams.type = String(type);
				await this.$http.post('storeup/add', this.storeupParams).then(res => {
					if (res.data.code == 0) {
						let detail = JSON.parse(JSON.stringify(this.detail))
						if (type == 21) detail.thumbsupnum = Number(detail.thumbsupnum) + 1;
						if (type == 22) detail.crazilynum = Number(detail.crazilynum) + 1;
						this.$http.post('youhuihuodong/update', detail).then(res => {
							this.detail = detail
						});
						this.getThumbsupOrCrazilyStatus();
						this.$message({
							type: 'success',
							message: '操作成功!',
							duration: 1500,
						});
						
					}
				});
				
			},
			async cancelThumbsupOrCrazily(type) {
				let delIds = new Array();
				delIds.push(this.thumbsupOrCrazilyInfo.id);
				await this.$http.post('storeup/delete', delIds).then(res => {
					if (res.data.code == 0) {
						let detail = JSON.parse(JSON.stringify(this.detail))
						if (type == 21) detail.thumbsupnum -= 1;
						if (type == 22) detail.crazilynum -= 1;
						this.$http.post('youhuihuodong/update', detail).then(res => {
							this.detail = detail
						});
						this.isThumbsupnum = false;
						this.isCrazilynum = false;
						this.$message({
							type: 'success',
							message: '取消成功!',
							duration: 1500,
						});
					}
				});
				
			},
			getThumbsupOrCrazilyStatus() {
				if(localStorage.getItem("frontToken")) {
					this.$http.get('storeup/list', {params: {page: 1, limit: 1, type: '21', refid: this.detail.id, tablename: 'youhuihuodong', userid: Number(localStorage.getItem('frontUserid'))}}).then(res => {
						if (res.data.code == 0 && res.data.data.list.length > 0) {
							this.isThumbsupnum = true;
							this.thumbsupOrCrazilyInfo = res.data.data.list[0];
						}
					});
					this.$http.get('storeup/list', {params: {page: 1, limit: 1, type: '22', refid: this.detail.id, tablename: 'youhuihuodong', userid: Number(localStorage.getItem('frontUserid'))}}).then(res => {
						if (res.data.code == 0 && res.data.data.list.length > 0) {
							this.isCrazilynum = true;
							this.thumbsupOrCrazilyInfo = res.data.data.list[0];
						}
					});
				}
			},
			curChange(page) {
				this.getDiscussList(page);
			},
			prevClick(page) {
				this.getDiscussList(page);
			},
			nextClick(page) {
				this.getDiscussList(page);
			},
			sizeChange(size){
				this.pageSize = size
				this.getDiscussList(1);
			},
			// 返回按钮
			backClick(){
				if(this.storeupType){
					history.back()
				}else{
					let params = {}
					if(this.centerType){
						params.centerType = 1
					}
					this.$router.push({path: '/index/youhuihuodong', query: params});
				}
			},
			// 下载
			download(file ){
				if(!file) {
					this.$message({
						type: 'error',
						message: '文件不存在',
						duration: 1500,
					});
					return;
				}
				let arr = file.replace(new RegExp('upload/', "g"), "")
				axios.get(this.baseUrl + '/file/download?fileName=' + arr, {
					headers: {
						token: localStorage.getItem("frontToken")
					},
					responseType: "blob"
				}).then(({
					data
				}) => {
					const binaryData = [];
					binaryData.push(data);
					const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
						type: 'application/pdf;chartset=UTF-8'
					}))
					const a = document.createElement('a')
					a.href = objectUrl
					a.download = arr
					// a.click()
					// 下面这个写法兼容火狐
					a.dispatchEvent(new MouseEvent('click', {
						bubbles: true,
						cancelable: true,
						view: window
					}))
					window.URL.revokeObjectURL(data)
				},err=>{
					axios.get((location.href.split(this.$config.name).length>1 ? location.href.split(this.$config.name)[0] :'') + this.$config.name + '/file/download?fileName=' + arr, {
						headers: {
							token: localStorage.getItem("frontToken")
						},
						responseType: "blob"
					}).then(({
						data
					}) => {
						const binaryData = [];
						binaryData.push(data);
						const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
							type: 'application/pdf;chartset=UTF-8'
						}))
						const a = document.createElement('a')
						a.href = objectUrl
						a.download = arr
						// a.click()
						// 下面这个写法兼容火狐
						a.dispatchEvent(new MouseEvent('click', {
							bubbles: true,
							cancelable: true,
							view: window
						}))
						window.URL.revokeObjectURL(data)
					})
				})
			},


			// 权限判断
			btnAuth(tableName,key){
				if(this.centerType){
					return this.isBackAuth(tableName,key)
				}else{
					return this.isAuth(tableName,key)
				}
			},
			// 修改
			editClick(){
				this.$router.push(`/index/youhuihuodongAdd?type=edit&&id=${this.detail.id}`);
			},
			// 删除
			async delClick(){
				await this.$confirm('是否删除此优惠活动？') .then(_ => {
					this.$http.post('youhuihuodong/delete', [this.detail.id]).then(async res => {
						if (res.data.code == 0) {
							this.$http.get('storeup/list',{params:{
								page: 1,
								limit: 100,
								refid: this.detail.id,
								tablename: 'youhuihuodong',
							}}).then(async obj=>{
								if(obj.data&&obj.data.code==0){
									let arr = []
									for(let x in obj.data.data.list){
										arr.push(obj.data.data.list[x].id)
									}
									if(arr.length){
										await this.$http.post('storeup/delete',arr).then(()=>{})
									}
									this.$message({
										type: 'success',
										message: '删除成功!',
										duration: 1500,
										onClose: () => {
											history.back()
										}
									});
								}
							})
						}
					});
				}).catch(_ => {});
			},
			allchapterClick (){
				let params = {
					refid: this.detail.id
				}
				if(this.centerType){
					params.centerType = 1
				}
				this.$router.push({path: '/index/chapteryouhuihuodong', query: params});
			},
			// 获取uuid
			getUUID() {
				return new Date().getTime();
			},
		},
		components: {
		}
	}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.detail-preview {
		padding: 0 10%;
		margin: 10px auto;
		display: flex;
		width: 100%;
		position: relative;
		flex-wrap: wrap;
		.attr {
			padding: 0px;
			margin: 0 0 20px;
			background: none;
			flex: 1;
			display: flex;
			position: relative;
			order: 2;
			.info {
				border-radius: 8px;
				padding: 10px;
				margin: 0;
				align-content: flex-start;
				background: #fff;
				flex: 1;
				display: flex;
				align-items: flex-start;
				flex-wrap: wrap;
				.title-item {
					border-radius: 0px;
					padding: 10px;
					margin: 0 0 10px 0;
					background: none;
					display: flex;
					width: 100%;
					border-color: #ddd;
					border-width: 4px;
					justify-content: space-between;
					align-items: center;
					border-style: double;
					.detail-title {
						padding: 0;
						color: #333;
						font-weight: 600;
						font-size: 18px;
						border-color: #009899;
						border-width: 0 0 0 0px;
						line-height: 1.5;
						border-style: solid;
					}
				}
				.item {
					padding: 5px 10px;
					margin: 0 0 0px 0;
					background: none;
					display: flex;
					width: 48%;
					border-color: #ff6f3d30;
					border-width: 0 0 0px;
					justify-content: spaceBetween;
					border-style: solid;
					.lable {
						padding: 0 10px 0 0;
						color: #333;
						white-space: nowrap;
						font-weight: 500;
						width: auto;
						font-size: 16px;
						line-height: 24px;
						text-align: right;
						height: auto;
					}
					.text {
						padding: 0 10px;
						color: #666;
						word-break: break-all;
						flex: 1;
						font-size: 14px;
						line-height: 24px;
						height: auto;
					}
					.price {
						color: #f00;
					}
					.bold {
						font-weight: bold;
					}
					.link {
						cursor: pointer;
						text-decoration: underline;
					}
				}
				.btn_box {
					padding: 10px 0;
					display: flex;
					flex-wrap: wrap;
				}
				.editBtn {
					border: 0;
					cursor: pointer;
					padding: 0 10px;
					margin: 0 0 0 10px;
					color: #fff;
					font-size: 14px;
					line-height: 40px;
					border-radius: 4px;
					outline: none;
					background: rgba(64, 158, 255, 1);
					width: auto;
					min-width: 80px;
					height: 40px;
				}
				.editBtn:hover {
					opacity: 0.7;
				}
				.delBtn {
					border: 0;
					cursor: pointer;
					padding: 0 10px;
					margin: 0 0 0 10px;
					color: #fff;
					font-size: 14px;
					line-height: 40px;
					border-radius: 4px;
					outline: none;
					background: rgba(255, 0, 0, 1.0);
					width: auto;
					min-width: 80px;
					height: 40px;
				}
				.delBtn:hover {
					opacity: 0.7;
				}
			}
		}
		.el-carousel {
			margin: 0 20px 0 0;
			width: 480px;
			height: 480px;
			order: 1;
			/deep/ .el-carousel__indicator button {
				width: 0;
				height: 0;
				display: none;
			}
			/deep/ .el-carousel__container {
				.el-carousel__arrow--left {
					width: 36px;
					font-size: 12px;
					height: 36px;
				}
				.el-carousel__arrow--left:hover {
					background: red;
				}
				.el-carousel__arrow--right {
					width: 36px;
					font-size: 12px;
					height: 36px;
				}
				.el-carousel__arrow--right:hover {
					background: red;
				}
				.el-carousel__item {
					border-radius: 10px;
					width: 100%;
					height: 100%;
					img {
						object-fit: cover;
						width: 100%;
						height: 100%;
					}
				}
			}
		
			/deep/ .el-carousel__indicators {
				padding: 0;
				margin: 0;
				z-index: 2;
				position: absolute;
				list-style: none;
				li {
					padding: 0;
					margin: 0 4px;
					background: #fff;
					display: inline-block;
					width: 12px;
					opacity: 0.4;
					transition: 0.3s;
					height: 12px;
				}
				li:hover {
					padding: 0;
					margin: 0 4px;
					background: #fff;
					display: inline-block;
					width: 24px;
					opacity: 0.7;
					height: 12px;
				}
				li.is-active {
					padding: 0;
					margin: 0 4px;
					background: #fff;
					display: inline-block;
					width: 24px;
					opacity: 1;
					height: 12px;
				}
			}
		}
		.zancai {
			padding: 0;
			margin: 10px auto;
			background: none;
			display: flex;
			width: 100%;
			justify-content: center;
			order: 3;
			.zan {
				cursor: pointer;
				border: 1px solid #eee;
				border-radius: 4px;
				padding: 10px 20px;
				margin: 0 100px 0 0;
				background: #fff;
				display: flex;
				width: auto;
				justify-content: center;
				align-items: center;
				.icon {
					margin: 0 3px;
					color: #666;
					font-size: 14px;
				}
				.text {
					margin: 0 3px;
					color: #666;
					font-size: 16px;
				}
			}
			.zan:hover {
				background: #054acc;
				border-color: #054acc;
				.icon {
					color: #fff;
				}
				.text {
					color: #fff;
				}
			}
			.zanActive {
				cursor: pointer;
				border-radius: 4px;
				padding: 10px 20px;
				margin: 0 20px 0 0;
				background: #054acc;
				display: flex;
				width: auto;
				border-color: #054acc;
				justify-content: center;
				align-items: center;
				.icon {
					color: #fff;
				}
				.text {
					color: #fff;
				}
			}
			.zanActive:hover {
				background: #054acc;
				border-color: #054acc;
				.icon {
					color: #fff;
				}
				.text {
					color: #fff;
				}
			}
			
			.cai {
				cursor: pointer;
				border: 1px solid #eee;
				border-radius: 4px;
				padding: 10px 20px;
				margin: 0;
				background: #fff;
				display: flex;
				width: auto;
				justify-content: center;
				align-items: center;
				.icon {
					margin: 0 3px;
					color: #666;
					font-size: 14px;
				}
				.text {
					margin: 0 3px;
					color: #666;
					font-size: 16px;
				}
			}
			.cai:hover {
				background: #054acc;
				border-color: #054acc;
				.icon {
					color: #fff;
				}
				.text {
					color: #fff;
				}
			}
			.caiActive {
				background: #054acc;
				border-color: #054acc;
				.icon {
					color: #fff;
				}
				.text {
					color: #fff;
				}
			}
			.caiActive:hover {
				background: #054acc;
				border-color: #054acc;
				.icon {
					color: #fff;
				}
				.text {
					color: #fff;
				}
			}
		}
		.detail-tabs {
			border: 0px solid #DCDFE6;
			box-shadow: none;
			padding: 0;
			margin: 20px auto;
			background: none;
			width: 100%;
			order: 5;
			& /deep/ .el-tabs__header .el-tabs__nav-wrap {
				margin-bottom: 0;
			}
			/deep/ .el-tabs__header {
				padding: 8px 20px;
				background: none;
				display: block;
				width: 100%;
				border-color: #ddd;
				border-width: 0 0 1px;
				line-height: 1.5;
				border-style: solid;
				text-align: center;
			}
			
			/deep/ .el-tabs__header .el-tabs__item {
				border: 0;
				padding: 0 20px;
				margin: 0 10px 0 0;
				color: #333;
				font-weight: 500;
				display: inline-block;
				font-size: 18px;
				border-color: #ff6f3c;
				line-height: 40px;
				background: none;
				border-width: 0 0 0px;
				position: relative;
				border-style: solid;
				list-style: none;
				height: 40px;
			}
			
			/deep/ .el-tabs__header .el-tabs__item:hover {
				color: #fff;
				background: #054acc;
				border-color: #fff;
			}
			
			/deep/ .el-tabs__header .el-tabs__item.is-active {
				padding: 0 20px;
				margin: 0 10px 0 0;
				color: #fff;
				background: #054acc;
				font-size: 18px;
				border-color: #fff;
				border-width: 0 0 0px;
				border-style: solid;
			}
			
			/deep/ .el-tabs__content {
				padding: 15px 5px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
			}
		}
	}
	.share_view{
		box-shadow: 0 1px 6px rgba(0,0,0,.3);
		z-index: 11;
		bottom: 20%;
		background: #fff;
		position: fixed;
		right: 0;
		.share:last-of-type{
			border:none;
		}
	}
</style>
