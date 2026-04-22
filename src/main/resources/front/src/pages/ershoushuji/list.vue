<template>
	<div>
		<div class="breadcrumb-preview">
			<el-breadcrumb :separator="'>'">
				<el-breadcrumb-item class="item1" to="/"><a>首页</a></el-breadcrumb-item>
				<el-breadcrumb-item class="item2" v-for="(item, index) in breadcrumbItem" :key="index"><a>{{item.name}}</a></el-breadcrumb-item>
			</el-breadcrumb>
		</div>
		<div v-if="centerType " class="back_box">
			<el-button class="backBtn" size="mini" @click="backClick">
				<span class="icon iconfont icon-fanhui21"></span>
				<span class="text">返回</span>
			</el-button>
		</div>
		<div class="list-preview">
			<div class="category-3">
				<div class="item" :class="swiperIndex == '-1' ? 'active' : ''" @click="getList(1, '全部')" :plain="isPlain">
					<div class="text">全部</div>
				</div>
				<div class="item" :class="swiperIndex == index ? 'active' : ''" v-for="(item, index) in fenlei" :key="index" @click="getList(1, item[feileiColumn], 'btn' + index)" :ref="'btn' + index" plain>
					<img v-if="item.image" :src="baseUrl + (item.image?item.image.split(',')[0]:'')">
					<div class="text">{{item[feileiColumn]}}</div>
				</div>
			</div>
			<el-form :inline="true" :model="formSearch" class="list-form-pv">
				<el-form-item class="list-item" >
					<div class="lable">羽毛球装备名称：</div>
					<el-input v-model="formSearch.shujimingcheng" placeholder="羽毛球装备名称" @keydown.enter.native="getList(1, curFenlei)" clearable></el-input>
				</el-form-item>
				<el-form-item class="list-item" >
					<div class="lable">价格：</div>
					<el-input v-model="formSearch.pricestart" placeholder="最小价格" clearable></el-input>
				</el-form-item>
				<el-form-item class="list-item" >
					<el-input v-model="formSearch.priceend" placeholder="最大价格" clearable></el-input>
				</el-form-item>
				<div class="list-btn-box">
					<el-button class="list-search-btn" v-if=" true " type="primary" @click="getList(1, curFenlei)">
						<span class="icon iconfont icon-fangdajing07"></span>
						搜索
					</el-button>
					<el-button class="list-add-btn" v-if="btnAuth('ershoushuji','新增')" type="primary" @click="add('/index/ershoushujiAdd')">
						<span class="icon iconfont icon-tianjia14"></span>
						新增
					</el-button>
  
				</div>
			</el-form>
			<div class="sort_view">
				<el-button class="price-sort-btn" @click="sortClick('price')">
					<span class="icon iconfont icon-chujia13" v-if="sortType!='price'"></span>
					<span class="icon iconfont icon-jiantou35" v-else-if="sortType=='price'&&sortOrder=='desc'"></span>
					<span class="icon iconfont icon-jiantou36" v-else-if="sortType=='price'&&sortOrder=='asc'"></span>
					<span class="text">价格</span>
				</el-button>
				<el-button class="click-sort-btn" @click="sortClick('clicknum')">
					<span class="icon iconfont icon-liulan13" v-if="sortType!='clicknum'"></span>
					<span class="icon iconfont icon-jiantou35" v-else-if="sortType=='clicknum'&&sortOrder=='desc'"></span>
					<span class="icon iconfont icon-jiantou36" v-else-if="sortType=='clicknum'&&sortOrder=='asc'"></span>
					<span class="text">点击量</span>
				</el-button>
				<el-button class="collect-sort-btn" @click="sortClick('storeupnum')">
					<span class="icon iconfont icon-shoucang10" v-if="sortType!='storeupnum'"></span>
					<span class="icon iconfont icon-jiantou35" v-else-if="sortType=='storeupnum'&&sortOrder=='desc'"></span>
					<span class="icon iconfont icon-jiantou36" v-else-if="sortType=='storeupnum'&&sortOrder=='asc'"></span>
					<span class="text">收藏数</span>
				</el-button>
				<el-button class="like-sort-btn" @click="sortClick('thumbsupnum')">
					<span class="icon iconfont icon-zan10" v-if="sortType!='thumbsupnum'"></span>
					<span class="icon iconfont icon-jiantou35" v-else-if="sortType=='thumbsupnum'&&sortOrder=='desc'"></span>
					<span class="icon iconfont icon-jiantou36" v-else-if="sortType=='thumbsupnum'&&sortOrder=='asc'"></span>
					<span class="text">点赞数</span>
				</el-button>
				<el-button class="score-sort-btn" @click="sortClick('totalscore')">
					<span class="icon iconfont icon-kaitongfuwu" v-if="sortType!='totalscore'"></span>
					<span class="icon iconfont icon-jiantou35" v-else-if="sortType=='totalscore'&&sortOrder=='desc'"></span>
					<span class="icon iconfont icon-jiantou36" v-else-if="sortType=='totalscore'&&sortOrder=='asc'"></span>
					<span class="text">评分</span>
				</el-button>
			</div>
			<div class="list">
				<div class="list5">
					<div v-for="(item,index) in dataList" :key="index" class="list-item" @click.stop="toDetail(item)" >
						<div class="imgbox">
							<img @click.stop="imgPreView(item.tupian)" v-if="item.tupian && item.tupian.substr(0,4)=='http'&&item.tupian.split(',w').length>1" :src="item.tupian" class="image" />
							<img @click.stop="imgPreView(item.tupian.split(',')[0])" v-else-if="item.tupian && item.tupian.substr(0,4)=='http'" :src="item.tupian.split(',')[0]" class="image" />
							<img @click.stop="imgPreView(baseUrl + (item.tupian?item.tupian.split(',')[0]:''))" v-else :src="baseUrl + (item.tupian?item.tupian.split(',')[0]:'')" class="image" />
						</div>
						<div class="infoBox">
							<div class="name">{{item.shujimingcheng}}</div>
							<div class="name">{{item.shujifenlei}}</div>
							<div class="price">￥<span class="price_text">{{item.price}}</span></div>
							<div class="bottomInfo">
								<div class="time_item">
									<span class="icon iconfont icon-shijian21"></span>
									<span class="label">发布时间：</span>
									<span class="text">{{item.addtime.split(' ')[0]}}</span>
								</div>
								<div class="publisher_item">
									<span class="icon iconfont icon-geren16"></span>
									<span class="label">发布人：</span>
									<span class="text">{{item.yonghuzhanghao}}</span>
								</div>
								<div class="like_item">
									<span class="icon iconfont icon-zan10"></span>
									<span class="label">点赞数：</span>
									<span class="text">{{item.thumbsupnum}}</span>
								</div>
								<div class="collect_item">
									<span class="icon iconfont icon-shoucang10"></span>
									<span class="label">收藏量：</span>
									<span class="text">{{item.storeupnum}}</span>
								</div>
								<div class="view_item">
									<span class="icon iconfont icon-chakan2"></span>
									<span class="label">点击量：</span>
									<span class="text">{{item.clicknum}}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

	
			<el-pagination
				background
				id="pagination"
				class="pagination"
				:pager-count="7"
				:page-size="pageSize"
				prev-text="<"
				next-text=">"
				:hide-on-single-page="true"
				:layout='["total","prev","pager","next","sizes","jumper"].join()'
				:total="total"
				:page-sizes="pageSizes"
				@current-change="curChange"
				@size-change="sizeChange"
				@prev-click="prevClick"
				@next-click="nextClick"
				></el-pagination>
		</div>
		<el-dialog title="预览图" :visible.sync="previewVisible" width="50%">
			<img :src="previewImg" alt="" style="width: 100%;">
		</el-dialog>
	</div>
</template>
<script>
	import axios from 'axios';
	export default {
		//数据集合
		data() {
			return {
				layouts: '',
				swiperIndex: -1,
				baseUrl: '',
				breadcrumbItem: [
					{
						name: '二手羽毛球装备'
					}
				],
				formSearch: {
					shujimingcheng: '',
					price: '',
				},
				fenlei: [],
				feileiColumn: '',
				dataList: [],
				total: 1,
				pageSize: 15,
				pageSizes: [],
				totalPage: 1,
				curFenlei: '全部',
				isPlain: false,
				indexQueryCondition: '',
				timeRange: [],
				centerType:false,
				previewImg: '',
				previewVisible: false,
				sortType: 'id',
				sortOrder: 'desc',
			}
		},
		async created() {
			if(this.$route.query.centerType&&this.$route.query.centerType!=0){
				this.centerType = true
			}
			this.baseUrl = this.$config.baseUrl;
			if(this.centerType) {
			}
			await this.getFenlei();
			let fenlei = '全部'
			if(this.$route.query.homeFenlei){
				fenlei = this.$route.query.homeFenlei
			}
			this.getList(1, fenlei);
		},
		watch:{
			$route(newValue){
				this.getList(1, newValue.query.homeFenlei);
			}
		},
		computed: {
			role(){
				return localStorage.getItem('frontRole');
			},
			username() {
				return localStorage.getItem('username')
			}
		},
		//方法集合
		methods: {
			queryChange(arr){
				for(let x in arr) {
					if(arr[x] == this.role) {
						return true
					}
				}
				return false
			},
			add(path) {
				let query = {}
				if(this.centerType){
					query.centerType = 1
				}
				this.$router.push({path: path,query:query});
			},
			async getFenlei() {
				await this.$http.get('shujifenlei/list',{params: {sort: 'shujifenlei',order: 'desc'}}).then(res => {
					if (res.data.code == 0) {
						this.fenlei = res.data.data.list
					}
				});
				this.feileiColumn = 'shujifenlei'
			},
			getList(page, fenlei, ref = '') {
				if(fenlei == '全部') this.swiperIndex = -1;
				for(let i=0;i<this.fenlei.length;i++) {
					if(fenlei == this.fenlei[i][this.feileiColumn]) {
						this.swiperIndex = i;
						break;
					}
				}
				if(fenlei){
					this.curFenlei = fenlei;
				}
				let params = {
					page,
					limit: this.pageSize,
				};
				if(!this.centerType) {
					params.onshelves = 1
				}
				let searchWhere = {};
				if (this.formSearch.shujimingcheng != '') searchWhere.shujimingcheng = '%' + this.formSearch.shujimingcheng + '%';
				if(this.formSearch.pricestart!='' && this.formSearch.pricestart!=undefined ){
					searchWhere.pricestart = this.formSearch.pricestart
				}
				if(this.formSearch.priceend!='' && this.formSearch.priceend!=undefined){
					searchWhere.priceend = this.formSearch.priceend
				}
				if(!this.centerType){
					params['sfsh'] = '是';
				}
				if (this.curFenlei != '全部') searchWhere.shujifenlei = this.curFenlei;
				let user = JSON.parse(localStorage.getItem('sessionForm'))
				if (this.sortType) searchWhere.sort = this.sortType
				if (this.sortOrder) searchWhere.order = this.sortOrder
				this.$http.get(`ershoushuji/${this.centerType?'page':'list'}`, {params: Object.assign(params, searchWhere)}).then(res => {
					if (res.data.code == 0) {
						this.dataList = res.data.data.list;
						this.total = Number(res.data.data.total);
						this.pageSize = Number(res.data.data.pageSize);
						this.totalPage = res.data.data.totalPage;
						if(this.pageSizes.length==0){
							this.pageSizes = [this.pageSize, this.pageSize*2, this.pageSize*3, this.pageSize*5];
						}
					}
				});
			},
			sortClick(type){
				if(this.sortType==type){
					if(this.sortOrder == 'desc'){
						this.sortOrder = 'asc'
					}else{
						this.sortOrder = 'desc'
					}
				}else{
					this.sortType = type
					this.sortOrder = 'desc'
				}
				this.getList(1, '全部')
			},
			curChange(page) {
				this.getList(page,this.curFenlei);
			},
			prevClick(page) {
				this.getList(page,this.curFenlei);
			},
			sizeChange(size){
				this.pageSize = size
				this.getList(1,this.curFenlei);
			},
			nextClick(page) {
				this.getList(page,this.curFenlei);
			},
			imgPreView(url){
				this.previewImg = url
				this.previewVisible = true
			},
			toDetail(item) {
				let params = {
					id: item.id
				}
				if(this.centerType){
					params.centerType = 1
				}
				this.$router.push({path: '/index/ershoushujiDetail', query: params});
			},
			btnAuth(tableName,key){
				if(this.centerType){
					return this.isBackAuth(tableName,key)
				}else{
					return this.isAuth(tableName,key)
				}
			},
			backClick() {
				this.$router.push({path: '/index/center'});
			},

			discussClick (row){
				let params = {
					refid: row.id
				}
				if(this.centerType){
					params.centerType = 1
				}
				this.$router.push({path: '/index/discussershoushuji', query: params});
			},
			chapterClick (row){
				let params = {
					refid: row.id
				}
				if(this.centerType){
					params.centerType = 1
				}
				this.$router.push({path: '/index/chapterershoushuji', query: params});
			},
		}
	}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.list-preview {
		padding: 0 10%;
		margin: 0px auto;
		align-content: flex-start;
		background: none;
		display: flex;
		width: 100%;
		align-items: flex-start;
		position: relative;
		flex-wrap: wrap;
		.category-3 {
			border: 4px double #000;
			padding: 0;
			margin: 20px 30px 0 0;
			background: #fff;
			display: flex;
			width: 260px;
			justify-content: center;
			flex-wrap: wrap;
			height: auto;
			order: 3;
			.item {
				cursor: pointer;
				padding: 0 20px;
				margin: 0;
				color: #333;
				background: none;
				width: 100%;
				border-color: #eee;
				border-width: 0px 0 0;
				line-height: 64px;
				border-style: double;
				height: auto;
				img {
					margin: 0 5px 0 0;
					object-fit: cover;
					display: inline-block;
					width: 44px;
					height: 44px;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: 15px;
					line-height: 44px;
				}
			}
			.item:hover {
				color: #fff;
				background: #054acc;
			}
			.item.active {
				color: #fff;
				background: #054acc;
			}
		}
		.list-form-pv {
			padding: 0;
			margin: 10px auto;
			background: none;
			display: flex;
			width: 100%;
			border-color: #ddd;
			border-width: 0px;
			justify-content: center;
			align-items: center;
			border-style: solid;
			flex-wrap: wrap;
			height: auto;
			.list-item {
				margin: 0 5px 0 0;
				/deep/.el-form-item__content {
					display: flex;
				}
				.lable {
					padding: 0;
					color: #333;
					white-space: nowrap;
					display: inline-block;
					width: auto;
					line-height: 42px;
				}
				.el-input {
					width: 100%;
				}
				.datetimerange {
					border: 1px solid #ddd;
					border-radius: 2px;
					padding: 3px 0px;
					outline: none;
					background: #fff;
					width: auto;
					justify-content: center;
				}
				.el-input /deep/ .el-input__inner {
					border: 1px solid #ddd;
					border-radius: 2px;
					padding: 0 10px;
					margin: 0;
					outline: none;
					color: #333;
					width: 140px;
					font-size: 14px;
					line-height: 42px;
					height: 42px;
				}
				.el-select {
					width: 100%;
				}
				.el-select /deep/ .el-input__inner {
				}
				.el-date-editor {
					width: 100%;
				}
				.el-date-editor /deep/ .el-input__inner {
					border: 1px solid #ddd;
					border-radius: 2px;
					padding: 0 30px;
					margin: 0;
					outline: none;
					color: #333;
					width: 140px;
					font-size: 14px;
					line-height: 42px;
					height: 42px;
				}
			}
			.list-btn-box {
				display: flex;
			}
			.list-search-btn {
				cursor: pointer;
				border: 0;
				border-radius: 4px;
				padding: 0px 10px;
				margin: 0 10px 0 0;
				outline: none;
				color: #fff;
				background: #054acc;
				width: auto;
				font-size: 14px;
				line-height: 42px;
				height: 42px;
				.icon {
					margin: 0 3px 0 0;
					color: #fff;
					font-size: 14px;
				}
			}
			.list-add-btn {
				cursor: pointer;
				border: 0;
				border-radius: 4px;
				padding: 0px 10px;
				margin: 0 10px 0 0;
				outline: none;
				color: #f28d00;
				background: #f28d0030;
				width: auto;
				font-size: 14px;
				line-height: 42px;
				height: 42px;
				.icon {
					margin: 0 3px 0 0;
					color: #f28d00;
					font-size: 14px;
				}
			}
		}
		.sort_view {
			border: 0px solid #ddd;
			padding: 0;
			margin: 10px auto;
			color: #333;
			background: #fff;
			width: 100%;
			font-size: 16px;
			text-align: center;
			order: 2;
			.price-sort-btn {
				border: 0;
				border-radius: 8px;
				padding: 0 10px;
				margin: 0 5px;
				color: inherit;
				background: none;
				font-size: inherit;
				.icon {
					margin: 0 2px 0 0;
					line-height: 40px;
				}
				.text {
					line-height: 40px;
				}
			}
			.click-sort-btn {
				border: 0;
				border-radius: 8px;
				padding: 0 10px;
				margin: 0 5px;
				color: inherit;
				background: none;
				font-size: inherit;
				.icon {
					margin: 0 2px 0 0;
					line-height: 40px;
				}
				.text {
					line-height: 40px;
				}
			}
			.collect-sort-btn {
				border: 0;
				border-radius: 8px;
				padding: 0 10px;
				margin: 0 5px;
				color: inherit;
				background: none;
				font-size: inherit;
				.icon {
					margin: 0 2px 0 0;
					line-height: 40px;
				}
				.text {
					line-height: 40px;
				}
			}
			.like-sort-btn {
				border: 0;
				border-radius: 8px;
				padding: 0 10px;
				margin: 0 5px;
				color: inherit;
				background: none;
				font-size: inherit;
				.icon {
					margin: 0 2px 0 0;
					line-height: 40px;
				}
				.text {
					line-height: 40px;
				}
			}
			.score-sort-btn {
				border: 0;
				border-radius: 8px;
				padding: 0 10px;
				margin: 0 5px;
				color: inherit;
				background: none;
				font-size: inherit;
				.icon {
					margin: 0 2px 0 0;
					line-height: 40px;
				}
				.text {
					line-height: 40px;
				}
			}
		}
		.list {
			margin: 20px 0 0;
			background: none;
			flex: 1;
			width: calc(100% - 350px);
			order: 4;
			.index-pv1 .animation-box {
				transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
				z-index: initial;
			}
				
			.index-pv1 .animation-box:hover {
				transform: rotate(0) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
				-webkit-perspective: 1000px;
				perspective: 1000px;
				transition: 0.3s;
				z-index: 1;
			}
				
			.index-pv1 .animation-box img {
				transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			}
			
			.index-pv1 .animation-box img:hover {
				transform: rotate(0) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
				-webkit-perspective: 1000px;
				perspective: 1000px;
				transition: 0.3s;
			}
			.list5 {
				margin: 0px auto 20px -10px;
				color: #999;
				display: flex;
				width: calc(100% + 20px);
				font-size: 14px;
				flex-wrap: wrap;
				.list-item {
					border: 0px solid #eee;
					border-radius: 0px;
					padding: 0px;
					margin: 0 10px 20px;
					overflow: hidden;
					background: #fff;
					display: block;
					width: calc(25% - 20px);
					position: relative;
					.imgbox {
						border-radius: 4px;
						overflow: hidden;
						width: auto;
						.image {
							filter: saturate(150%);
							border-radius: 4px;
							transform: rotate(0deg);
							margin: 0 0 5px;
							object-fit: cover;
							display: block;
							width: 100%;
							opacity: 0.9;
							height: 275px;
						}
					}
					.infoBox {
						padding: 0px;
						left: 0px;
						bottom: 0;
						background: none;
						width: 100%;
						font-size: 14px;
						position: inherit;
						transition: all 0.5s;
						.name {
							overflow: hidden;
							color: #333;
							white-space: nowrap;
							width: 100%;
							font-size: 16px;
							line-height: 24px;
							text-overflow: ellipsis;
							text-align: center;
						}
						.price {
							color: #f00;
							width: 100%;
							font-size: 14px;
							text-align: center;
							.price_text {
								color: #f00;
								font-size: 18px;
							}
						}
						.bottomInfo {
							display: flex;
							justify-content: center;
							flex-wrap: wrap;
							.time_item {
								padding: 0;
								margin: 0 10px 0 0;
								.icon {
									margin: 0 2px 0 0;
									line-height: 1.5;
								}
								.label {
									line-height: 1.5;
								}
								.text {
									line-height: 1.5;
								}
							}
							.publisher_item {
								padding: 0;
								margin: 0 10px 0 0;
								.icon {
									margin: 0 2px 0 0;
									line-height: 1.5;
								}
								.label {
									line-height: 1.5;
								}
								.text {
									line-height: 1.5;
								}
							}
							.like_item {
								padding: 0;
								margin: 0 10px 0 0;
								.icon {
									margin: 0 2px 0 0;
									line-height: 1.5;
								}
								.label {
									line-height: 1.5;
								}
								.text {
									line-height: 1.5;
								}
							}
							.collect_item {
								padding: 0;
								margin: 0 10px 0 0;
								.icon {
									margin: 0 2px 0 0;
									line-height: 1.5;
								}
								.label {
									line-height: 1.5;
								}
								.text {
									line-height: 1.5;
								}
							}
							.view_item {
								padding: 0;
								.icon {
									margin: 0 2px 0 0;
									line-height: 1.5;
								}
								.label {
									line-height: 1.5;
								}
								.text {
									line-height: 1.5;
								}
							}
						}
					}
				}
				.list-item:hover {
					cursor: pointer;
					background: none;
					.imgbox {
						.image {
							transform: scale(1.05);
							ilter: saturate(100%);
							opacity: 1;
							transition: all 200ms linear;
						}
					}
					.infoBox {
						bottom: 0px;
						background: none;
						font-size: 14px;
						.name {
						}
						.price {
							.price_text {
							}
						}
						.bottomInfo {
							display: flex;
							justify-content: center;
							flex-wrap: wrap;
							.time_item {
								.icon {
								}
								.label {
								}
								.text {
								}
							}
							.publisher_item {
								.icon {
								}
								.label {
								}
								.text {
								}
							}
							.like_item {
								.icon {
								}
								.label {
								}
								.text {
								}
							}
							.collect_item {
								.icon {
								}
								.label {
								}
								.text {
								}
							}
							.view_item {
								.icon {
								}
								.label {
								}
								.text {
								}
							}
						}
					}
				}
			}
		}
	}
</style>
