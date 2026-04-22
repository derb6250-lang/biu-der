<template>
	<div>
		<div class="breadcrumb-preview">
			<el-breadcrumb :separator="'>'">
				<el-breadcrumb-item class="item1" to="/"><a>首页</a></el-breadcrumb-item>
				<el-breadcrumb-item class="item2" v-for="(item, index) in breadcrumbItem" :key="index" :to="'/index/yonghu?centerType=' + (centerType?'1':'0')"><a>{{item.name}}</a></el-breadcrumb-item>
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
						</div>
					</div>
					<div class="item">
						<div class="lable">用户账号</div>
						<div class="text "  >{{detail.yonghuzhanghao}}</div>
					</div>
					<div class="item">
						<div class="lable">用户姓名</div>
						<div class="text "  >{{detail.yonghuxingming}}</div>
					</div>
					<div class="item">
						<div class="lable">性别</div>
						<div class="text "  >{{detail.xingbie}}</div>
					</div>
					<div class="item">
						<div class="lable">联系方式</div>
						<div class="text "  >{{detail.lianxifangshi}}</div>
					</div>
					<div class="item" v-if="centerType">
						<div class="lable">审核状态</div>
						<div class="text">{{detail.sfsh=='是'?'通过':(detail.sfsh=='否'?'不通过':'待审核')}}</div>
					</div>
					<div class="item" v-if="centerType">
						<div class="lable">审核回复</div>
						<div class="text">{{detail.shhf}}</div>
					</div>
					<div class="btn_box">
						<el-button class="editBtn" v-if="btnAuth('yonghu','修改')&&detail.sfsh!='是'&&detail.sfsh!='否' " @click="editClick">修改</el-button>
						<el-button class="delBtn" v-if="btnAuth('yonghu','删除')" @click="delClick">删除</el-button>
						<el-button class="chatBtn" v-if="btnAuth('yonghu','私聊')&&detail.id!=mid" @click="chatClick">私聊</el-button>
						<el-button class="auditBtn" v-if="btnAuth('yonghu','审核') && (detail.sfsh=='待审核'||!detail.sfsh)" @click="onSH" type="warning">审核</el-button>
						<el-button class="editBtn" @click="allchapterClick()" type="warning" v-if="btnAuth('yonghu','章节管理')">章节管理</el-button>
					</div>
				</div>
			</div>
		
			<el-carousel v-if="detailBanner.length" trigger="click" indicator-position="inside" arrow="always" type="default" direction="horizontal" height="480px" :autoplay="false" :interval="3000" :loop="true">
				<el-carousel-item v-for="item in detailBanner" :key="item.id">
					<img :preview-src-list="[item]" v-if="item.substr(0,4)=='http'" :src="item" class="image">
					<img :preview-src-list="[baseUrl + item]" v-else :src="baseUrl + item" class="image">
				</el-carousel-item>
			</el-carousel>



			<el-tabs class="detail-tabs" v-model="activeName" type="border-card" v-if="tabsNum>0" >
			</el-tabs>
			<el-dialog title="审核" :visible.sync="sfshVisiable" width="50%">
				<el-form ref="shForm" :model="shForm" label-width="80px">
					<el-form-item label="审核状态">
						<el-select v-model="shForm.sfsh" placeholder="审核状态">
							<el-option label="通过" value="是"></el-option>
							<el-option label="不通过" value="否"></el-option>
							<el-option label="待审核" value="待审核"></el-option>
						</el-select>
					</el-form-item>
					<el-form-item label="内容">
						<el-input type="textarea" :rows="8" v-model="shForm.shhf"></el-input>
					</el-form-item>
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="sfshVisiable = false">取 消</el-button>
					<el-button type="primary" @click="shHandler">确 定</el-button>
				</div>
			</el-dialog>

		</div>
		<div class="share_view">
		</div>
		<el-dialog :visible.sync="chatVisible" @close="clearChat" :title="fname">
			<div class="chat-content" id="chat-content">
				<div v-bind:key="item.id" v-for="item in chatList">
					<div v-if="item.addtime" class="addtime">{{timeFormat(item.addtime)}}</div>
					<div v-if="item.uid==mid" class="right-content">
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="warning"></el-alert>
						<el-image v-else-if="item.format==2" fit="cover" :src="item.content?baseUrl + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?baseUrl + item.content:'']"></el-image>
						<video v-else-if="item.format==3" :src="baseUrl + item.content" style="width: 280px;" controls></video>
						<el-button v-else-if="item.format==4" type="primary" size="mini" @click="chatDownload(item.content)">文件预览</el-button>
						<img :src="mpic?baseUrl + mpic:require('@/assets/avator.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 0 0 10px;" />
					</div>
					<div v-else class="left-content">
						<img :src="fpic?baseUrl + fpic:require('@/assets/avator.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 10px 0 0;" />
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="success"></el-alert>
						<el-image v-else-if="item.format==2" fit="cover" :src="item.content?baseUrl + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?baseUrl + item.content:'']"></el-image>
						<video v-else-if="item.format==3" :src="baseUrl + item.content" style="width: 280px;" controls></video>
						<el-button v-else-if="item.format==4" type="primary" size="mini" @click="chatDownload(item.content)">文件预览</el-button>
					</div>
					<div class="clear-float"></div>
				</div>
			</div>
			<div slot="footer" class="dialog-footer">
				<div style="display: flex;align-items: center">
					<el-input size="small" @keydown.enter.native="addChat(null)" v-model="chatForm.content" placeholder="请输入内容" style="width: calc(100% - 240px);float: left;">
					</el-input>
					<el-button size="small" :disabled="chatForm.content?false:true" type="primary" @click="addChat(null)">发送</el-button>
					<el-upload style="display: inline-block;margin: 0 6px;" class="upload-demo" :action="uploadUrl" :on-success="uploadSuccess" accept=".jpg,.png"
						:show-file-list="false">
						<el-button size="small" type="success">上传图片</el-button>
					</el-upload>
					<el-upload class="upload-demo" :action="uploadUrl" :on-success="uploadSuccess2" accept=".mp4"
						:show-file-list="false">
						<el-button size="small" type="success">上传视频</el-button>
					</el-upload>
					<el-upload class="upload-demo" :action="uploadUrl" :on-success="uploadSuccess3"
						:show-file-list="false">
						<el-button size="small" type="success">上传文件</el-button>
					</el-upload>
				</div>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import axios from 'axios'
	import Swiper from "swiper";
	import timeMethod from '@/common/timeMethod'
	import {
		WebsocketMixin
	} from '@/mixins/WebsocketMixin'
	export default {
		mixins: [WebsocketMixin],
		//数据集合
		data() {
			return {
				tablename: 'yonghu',
				baseUrl: '',
				breadcrumbItem: [
					{
						name: '用户'
					}
				],
				title: '',
				detailBanner: [],
				userid: Number(localStorage.getItem('frontUserid')),
				id: 0,
				detail: {},
				tabsNum: 0,
				activeName: '1',
				buynumber: 1,
				sfshVisiable: false,
				shForm: {
					sfsh: '是',
					shhf: ''
				},
				centerType: false,
				storeupType: false,
				shareUrl: location.href,
				mid: Number(localStorage.getItem('frontUserid')),
				chatVisible: false,
				chatList: [],
				chatForm: {
					content: ''
				},
				uploadUrl: this.$config.baseUrl + 'file/upload',
				fpic: '',
				fname: '',
				fid: '',
				ftableName: 'yonghu',
				mpic: localStorage.getItem('frontHeadportrait'),
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
						if(res.data.data.touxiang){
							this.fpic = res.data.data.touxiang.split(',')[0]
						}else if(res.data.data.headportrait){
							this.fpic = res.data.data.headportrait.split(',')[0]
						}
						if(res.data.data.yonghuzhanghao){
							this.fname = res.data.data.yonghuzhanghao
						}
						this.fid = res.data.data.id
						this.$forceUpdate();
						if(localStorage.getItem('frontToken')){
						}

					}
				});
			},
			onSH() {
				this.sfshVisiable = true;
			},
			shHandler(){
				this.$confirm(`确定操作?`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(async () => {
					this.detail.sfsh = this.shForm.sfsh;
					this.detail.shhf = this.shForm.shhf;
					await this.$http.post(`${this.tablename}/update`, this.detail).then(async res => {
						if (res.data.code == 0) {
							this.sfshVisiable = false;
							this.$message({
								message: "操作成功",
								type: "success",
								duration: 1500,
							});
						}
					});
				});
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
					this.$router.push({path: '/index/yonghu', query: params});
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
				this.$router.push(`/index/yonghuAdd?type=edit&&id=${this.detail.id}`);
			},
			// 删除
			async delClick(){
				await this.$confirm('是否删除此用户？') .then(_ => {
					this.$http.post('yonghu/delete', [this.detail.id]).then(async res => {
						if (res.data.code == 0) {
							this.$message({
								type: 'success',
								message: '删除成功!',
								duration: 1500,
								onClose: () => {
									history.back()
								}
							});
						}
					});
				}).catch(_ => {});
			},
			chatClick() {
				this.initWebSocket(this.fid)
				this.getChatList()
				this.chatVisible = true
			},
			websocketOnopen: function() {
				
			},
			websocketOnmessage:function(e) {
				this.getChatList()
			},
			getChatList() {
				this.$http.get('chatmessage/mlist', {
					params: {
						page: 1,
						limit: 1000,
						uid: Number(localStorage.getItem('frontUserid')),
						fid: this.fid
					}
				}).then(res => {
					if (res.data && res.data.code == 0) {
						this.chatList = this.formatMessages(res.data.data.list)
						let div = document.getElementsByClassName('chat-content')[0]
						setTimeout(() => {
							if (div)
								div.scrollTop = div.scrollHeight
						}, 0)
					}
				})
			},
			formatMessages(messages) {
				let lastTime = null;
				messages.forEach((message, index) => {
					const currentTime = new Date(message.addtime).getTime();
					if (lastTime !== null) {
						const timeDiff = (currentTime - lastTime) / 1000 / 60; // 转换为分钟
						if (timeDiff < 3) {
							message.addtime = ''; // 如果小于3分钟，不显示时间
						}
					}
					lastTime = currentTime;
				});
				return messages;
			},
			timeFormat(time) {
				const Time = timeMethod.getTime(time).split("T");
				//当前消息日期属于周
				const week = timeMethod.getDateToWeek(time);
				//当前日期0时
				const nti = timeMethod.setTimeZero(timeMethod.getNowTime());
				//消息日期当天0时
				const mnti = timeMethod.setTimeZero(timeMethod.getTime(time));
				//计算日期差值
				const diffDate = timeMethod.calculateTime(nti, mnti);
				//本周一日期0时 （后面+1是去除当天时间）
				const fwnti = timeMethod.setTimeZero(timeMethod.countDateStr(-timeMethod.getDateToWeek(timeMethod
					.getNowTime()).weekID + 1));
				//计算周日期差值
				const diffWeek = timeMethod.calculateTime(mnti, fwnti);

				if (diffDate === 0) { //消息发送日期减去当天日期如果等于0则是当天时间
					return Time[1].slice(0, 5);
				} else if (diffDate < 172800000) { //当前日期减去消息发送日期小于2天（172800000ms）则是昨天-  一天最大差值前天凌晨00:00:00到今天晚上23:59:59
					return "昨天 " + Time[1].slice(0, 5);
				} else if (diffWeek >= 0) { //消息日期减去本周一日期大于0则是本周
					return week.weekName;
				} else { //其他时间则是日期
					return Time[0].slice(5, 10);
				}
			},
			clearChat(){
				this.websocketOnclose();
			},
			uploadSuccess(res) {
				if (res.code == 0) {
					this.addChat('upload/' + res.file,2)
				}
			},
			uploadSuccess2(res) {
				if (res.code == 0) {
					this.addChat('upload/' + res.file,3)
				}
			},
			uploadSuccess3(res) {
				if (res.code == 0) {
					this.addChat('upload/' + res.file,4)
				}
			},
			addChat(ask=null,type=1) {
				this.$http.get('friend/page', {
					params: {
						uid: Number(localStorage.getItem('frontUserid')),
						fid: this.fid,
					}
				}).then(obj => {
					if (obj.data && obj.data.code == 0) {
						if (!obj.data.data.list.length) {
							this.$http.post('friend/add', {
								uid: Number(localStorage.getItem('frontUserid')),
								fid: this.fid,
								name: this.fname,
								picture: this.fpic,
								type: 2,
								tablename: this.ftableName,
							}).then(res => {
								this.$http.post('friend/add', {
									uid: this.fid,
									fid: Number(localStorage.getItem('frontUserid')),
									type: 2,
									tablename: localStorage.getItem('frontSessionTable'),
									name: localStorage.getItem('username'),
									picture: this.mpic,
								}).then(res1 => {
			
								})
							})
						}
						this.$http.post('chatmessage/add', {
							uid: Number(localStorage.getItem('frontUserid')),
							fid: this.fid,
							content: ask?ask:this.chatForm.content,
							format: type
						}).then(res2 => {
							this.websocketSend(ask?ask:this.chatForm.content)
							this.chatForm = {
								content: ''
							}
							this.getChatList()
						})
					}
				})
			},
			chatDownload(url){
				if(!url){
					return false
				}
				window.open((location.href.split(this.$config.name).length>1 ? location.href.split(this.$config.name)[0] + this.$config.name + '/' + url :this.$config.baseUrl + url))
			},
			allchapterClick (){
				let params = {
					refid: this.detail.id
				}
				if(this.centerType){
					params.centerType = 1
				}
				this.$router.push({path: '/index/chapteryonghu', query: params});
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
				.chatBtn {
					border: 0;
					cursor: pointer;
					padding: 0 10px;
					margin: 0 0 0 10px;
					color: #fff;
					font-size: 14px;
					line-height: 40px;
					border-radius: 4px;
					outline: none;
					background: #2a91c7;
					width: auto;
					min-width: 80px;
					height: 40px;
				}
				.chatBtn:hover {
					opacity: 0.7;
				}
				.auditBtn {
					border: 0;
					cursor: pointer;
					padding: 0 10px;
					margin: 0 0 0 10px;
					color: #fff;
					font-size: 14px;
					line-height: 40px;
					border-radius: 4px;
					outline: none;
					background: #deaa5f;
					width: auto;
					min-width: 80px;
					height: 40px;
				}
				.auditBtn:hover {
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
	.chat-content {
		padding-bottom: 20px;
		width: 100%;
		margin-bottom: 10px;
		max-height: 300px;
		height: 300px;
		overflow-y: scroll;
		border: 1px solid #eeeeee;
		background: #fff;
	
		.addtime {
			width: 100%;
			text-align: center;
			font-size: 12px;
		}
		
		.left-content {
			float: left;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}
	
		.right-content {
			float: right;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}
	}
	
	.clear-float {
		clear: both;
	}
</style>
