<template>
	<div class="center-preview">
		<div class="center-title">{{ title }}</div>
		<div class="center-info">
			<div class="center-info-title">个人信息</div>

			<div class="img-box" v-if="userTableName=='yonghu'">
				<img :src="sessionForm.touxiang?baseUrl + sessionForm.touxiang:require('@/assets/avator.png')">
			</div>
			<div class="info-item1" v-if="userTableName=='yonghu'">
				<span class="icon iconfont "></span>
				<div class="label">用户账号：</div>
				<div class="text">{{sessionForm.yonghuzhanghao}}</div>
			</div>
			<div class="info-item2" v-if="userTableName=='yonghu'">
				<span class="icon iconfont "></span>
				<div class="label">用户姓名：</div>
				<div class="text">{{sessionForm.yonghuxingming}}</div>
			</div>
			<div class="info-item3" v-if="userTableName=='yonghu'">
				<span class="icon iconfont "></span>
				<div class="label">性别：</div>
				<div class="text">{{sessionForm.xingbie}}</div>
			</div>
			<div class="info-item4" v-if="userTableName=='yonghu'">
				<span class="icon iconfont "></span>
				<div class="label">联系方式：</div>
				<div class="text">{{sessionForm.lianxifangshi}}</div>
			</div>
			<div class="info-item5" v-if="userTableName=='yonghu'">
				<span class="icon iconfont "></span>
				<div class="label">是否审核：</div>
				<div class="text">{{sessionForm.sfsh}}</div>
			</div>
			<div class="info-item6" v-if="userTableName=='yonghu'">
				<span class="icon iconfont "></span>
				<div class="label">余额：</div>
				<div class="text">{{sessionForm.money}}</div>
			</div>
		
		</div>
	
		<div class="center-box">
			<div class="center-tab-view">
				<div class="center-tab" :class="activeName=='个人中心'?'is-active':''" @click="handleClick('个人中心')">个人中心</div>
				<div class="center-tab" :class="activeName=='修改密码'?'is-active':''" @click="handleClick('修改密码')">修改密码</div>
				<div class="center-tab" :class="activeName=='聊天记录'?'is-active':''" @click="handleClick('聊天记录')" v-if="changeHasChat()" style="position: relative">
					聊天记录
					<div v-if="redNum>0" style="background: red;color: #fff;border-radius: 50%;font-size: 12px;position: absolute; top: 0;right: 0;width: 20px;height: 20px;line-height: 20px;text-align: center;">{{redNum}}</div>
				</div>
				<div class="center-tab" v-if="hasBack(item.menu,item.child[0].tableName)" v-for="(item,index) in menuList" :key="index" @mouseenter="centerTabEnter(item.child[0].tableName)" @mouseleave="centerTabEnter('')" @click="menuClick(item.child[0],item.child.length)">
					<template v-if="item.child.length==1">
						{{item.child[0].menu}}
					</template>
					<template v-else>
						{{item.menu}}
						<transition name="el-zoom-in-top">
							<div class="center-second-tab-view" v-if="showActive=='show' + item.child[0].tableName">
								<div class="center-second-tab" v-for="(items,indexs) in item.child" :key="indexs" @click="menuClick(items)">
									{{items.menu}}
								</div>
							</div>
						</transition>
					</template>
				</div>
				<div class="center-tab" :class="activeName=='我的订单'?'is-active':''" @click="handleClick('我的订单')">我的订单</div>
				<div class="center-tab" :class="activeName=='我的地址'?'is-active':''" @click="handleClick('我的地址')">我的地址</div>


			</div>
			<div class="center-content-box">
				<div class="center-content-view" v-show="activeName=='个人中心'">
					<el-form class="center-preview-pv" ref="sessionForm" :model="sessionForm" :rules="rules" label-width="180px">
						<el-form-item class="center-item" v-if="userTableName=='yonghu'" label="用户账号" prop="yonghuzhanghao">
							<el-input v-model="sessionForm.yonghuzhanghao" placeholder="用户账号" :disabled="ro.yonghuzhanghao"></el-input>
						</el-form-item>
						<el-form-item class="center-item" v-if="userTableName=='yonghu'" label="用户姓名" prop="yonghuxingming">
							<el-input v-model="sessionForm.yonghuxingming" placeholder="用户姓名" :disabled="ro.yonghuxingming"></el-input>
						</el-form-item>
						<el-form-item class="center-item" v-if="userTableName=='yonghu'" label="头像" prop="touxiang">
							<file-upload
								tip="点击上传头像"
								action="file/upload"
								:limit="1"
								:multiple="true"
								:fileUrls="sessionForm.touxiang?sessionForm.touxiang:''"
								@change="yonghutouxiangHandleAvatarSuccess"
								></file-upload>
						</el-form-item>
						<el-form-item class="center-item" v-if="userTableName=='yonghu'" label="性别" prop="xingbie">
							<el-select filterable v-model="sessionForm.xingbie" placeholder="请选择性别" :disabled="ro.xingbie">
								<el-option v-for="(item, index) in dynamicProp.xingbie" :key="index" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
						<el-form-item class="center-item" v-if="userTableName=='yonghu'" label="联系方式" prop="lianxifangshi">
							<el-input v-model="sessionForm.lianxifangshi" placeholder="联系方式" :disabled="ro.lianxifangshi"></el-input>
						</el-form-item>
						<el-form-item class="center-item" v-if="userTableName=='yonghu'" label="余额">
							<div class="balance-item">
								<el-input v-model="sessionForm.money" placeholder="余额" readonly></el-input>
								<div class="balanceBtn" @click="dialogFormVisibleMoney = true">
									<span class="icon iconfont icon-chujia13"></span>
									<span class="text">点我充值</span>
								</div>
							</div>
						</el-form-item>
						<el-form-item class="center-btn-item">
							<div class="updateBtn" type="primary" @click="onSubmit('sessionForm')">
								<span class="icon iconfont icon-yanziwancheng"></span>
								<span class="text">保存信息</span>
							</div>
							<div class="closeBtn" type="danger" @click="logout">
								<span class="icon iconfont icon-fanhui19"></span>
								<span class="text">退出登录</span>
							</div>
						</el-form-item>
					</el-form>
				</div>
				<div class="center-content-view" v-show="activeName=='修改密码'">
					<el-form v-if="psdType==1" class="center-preview-pv" ref="passwordForm" :model="passwordForm" :rules="passwordRules" label-width="180px">
						<el-form-item class="center-item" label="原密码" prop="password">
							<el-input type="password" v-model="passwordForm.password" placeholder="原密码"></el-input>
						</el-form-item>
						<el-form-item class="center-item" label="新密码" prop="newpassword">
							<el-input type="password" v-model="passwordForm.newpassword" placeholder="新密码"></el-input>
						</el-form-item>
						<el-form-item class="center-item" label="确认密码" prop="repassword">
							<el-input type="password" v-model="passwordForm.repassword" placeholder="确认密码"></el-input>
						</el-form-item>
						<el-form-item class="center-btn-item">
							<div class="updateBtn" type="primary" @click="updatePassword">
								<span class="icon iconfont icon-yanziwancheng"></span>
								<span class="text">修改密码</span>
							</div>
						</el-form-item>
					</el-form>
				</div>
				<div class="center-content-view" v-show="activeName=='聊天记录'">
					<div class="z-box">
						<div class="section-content" v-for="item in recordList" :key="item.id" @click.stop="chatClick(item)">
							<div class="chat-left">
								<img :src="item.picture?baseUrl + item.picture:require('@/assets/avator.png')">
								<div class="chat-info">
									<div class="chat-name">{{item.name}}</div>
									<div class="chat-text">
										<div class="chat-noread" v-if="item.notreadnum">{{item.notreadnum}}</div>
										{{item.content.split('/').length>1&&item.content.split('/')[0]=='upload'?'[图片]':item.content}}
									</div>
								</div>
							</div>
							<div class="chat-btn">
								<div class="friendBtn2" @click.stop="chatDel(item)">删除</div>
							</div>
						</div>
						<div class="noList" v-if="!recordList.length">
							暂无聊天记录
						</div>
					</div>
				</div>
			</div>
		</div>
		<el-dialog title="用户充值" :visible.sync="dialogFormVisibleMoney" width="726px" center>
			<el-form :model="chongzhiForm">
				<el-form-item label="充值金额" label-width="120px">
					<el-input type="number" v-model="chongzhiForm.money" autocomplete="off" placeholder="充值金额"></el-input>
				</el-form-item>
				<el-form-item label-width="120px">
					<el-radio-group v-model="chongzhiForm.radio">
						<el-radio style="margin-bottom: 30px" label="微信支付">
							<el-image
								style="width: 60px; height: 60px;vertical-align: middle;"
								:src="require('@/assets/weixin.png')"
								fit="fill"></el-image>
							<span style="display: inline-block;margin-left: 10px">微信支付</span>
						</el-radio>
						<el-radio label="支付宝支付">
							<el-image
								style="width: 60px; height: 60px;vertical-align: middle;"
								:src="require('@/assets/zhifubao.png')"
								fit="fill"></el-image>
							<span style="display: inline-block;margin-left: 10px">支付宝支付</span>
						</el-radio>
						<el-radio label="中国建设银行支付">
							<el-image
								style="width: 120px; height: 60px;vertical-align: middle;"
								:src="require('@/assets/jianshe.png')"
								fit="fill"></el-image>
						</el-radio>
						<el-radio label="中国农业银行支付">
							<el-image
								style="width: 126px; height: 60px;vertical-align: middle;"
								:src="require('@/assets/nongye.png')"
								fit="fill"></el-image>
						</el-radio>
						<el-radio label="中国银行支付">
							<el-image
								style="width: 140px; height: 60px;vertical-align: middle;"
								:src="require('@/assets/zhongguo.png')"
								fit="fill"></el-image>
						</el-radio>
						<el-radio label="交通银行支付">
							<el-image
								style="width: 120px; height: 60px;vertical-align: middle;"
								:src="require('@/assets/jiaotong.png')"
								fit="fill"></el-image>
						</el-radio>
					</el-radio-group>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisibleMoney = false">取 消</el-button>
				<el-button type="primary" @click="chongzhi">确认充值</el-button>
				<el-button type="primary" @click="qrCodeClick(1)">二维码充值</el-button>
			</div>
		</el-dialog>
		<el-dialog :visible.sync="chatVisible" @close="clearChat" :title="nowname">
			<div class="chat-content" id="chat-content">
				<div v-bind:key="item.id" v-for="item in chatList">
					<div v-if="item.addtime" class="addtime">{{timeFormat(item.addtime)}}</div>
					<div v-if="item.uid==sessionForm.id" class="right-content">
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="warning"></el-alert>
						<el-image v-else-if="item.format==2" fit="cover" :src="item.content?baseUrl + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?baseUrl + item.content:'']"></el-image>
						<video v-else-if="item.format==3" :src="baseUrl + item.content" style="width: 280px;" controls></video>
						<el-button v-else-if="item.format==4" type="primary" size="mini" @click="chatDownload(item.content)">文件预览</el-button>
						<img :src="mypic?baseUrl + mypic:require('@/assets/avator.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 0 0 10px;" />
					</div>
					<div v-else class="left-content">
						<img :src="nowfpic?baseUrl + nowfpic:require('@/assets/avator.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 10px 0 0;" />
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
					<el-input size="small" @keydown.enter.native="addChat(null)" v-model="chatForm.content" placeholder="请输入内容" style="width: calc(100% - 180px);float: left;">
					</el-input>
					<el-button size="small" :disabled="chatForm.content?false:true" type="primary" @click="addChat(null)">发送</el-button>
					<el-upload accept=".jpg,.png" style="display: inline-block;margin: 0 0 0 6px;" class="upload-demo" :action="uploadUrl" :on-success="uploadSuccess"
						:show-file-list="false">
						<el-button size="small" type="success">上传图片</el-button>
					</el-upload>
					<el-upload class="upload-demo" style="display: inline-block;margin: 0 0 0 6px;" :action="uploadUrl" :on-success="uploadSuccess2" accept=".mp4"
						:show-file-list="false">
						<el-button size="small" type="success">上传视频</el-button>
					</el-upload>
					<el-upload class="upload-demo" style="display: inline-block;margin: 0 0 0 6px;" :action="uploadUrl" :on-success="uploadSuccess3"
						:show-file-list="false">
						<el-button size="small" type="success">上传文件</el-button>
					</el-upload>
				</div>
			</div>
		</el-dialog>
		<el-dialog title="支付" :visible.sync="qrCodeVisible" width="30%">
			<img src="@/assets/QRcode.png" style="width: 100%"></img>
			<div>
				<el-button type="primary" style="margin-left: 10px;" @click="qrCodeSave">确认支付</el-button>
				<el-button type="danger" style="margin-left: 10px;" @click="qrCodeVisible=false">取消</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import config from '@/config/config';
	import menu from '@/config/menu';
	import Vue from 'vue';
	import timeMethod from '@/common/timeMethod'
	import {
		WebsocketMixin
	} from '@/mixins/WebsocketMixin'
	export default {
		mixins: [WebsocketMixin],
		//数据集合
		data() {
			return {
				title: '个人中心',
				showActive: '',
				activeName: '个人中心',
				baseUrl: config.baseUrl,
				sessionForm: {},
				ro: {},
				passwordForm: {},
				psdType: '1',
				passwordRules: {
					password: [
						{
							required: true,
							message: "密码不能为空",
							trigger: "blur"
						}
					],
					newpassword: [
						{
							required: true,
							message: "新密码不能为空",
							trigger: "blur"
						}
					],
					repassword: [
						{
							required: true,
							message: "确认密码不能为空",
							trigger: "blur"
						}
					]
				},
				rules: {},
				chongzhiForm: {
					money: '',
					radio: ''
				},
				menuList: [],
				disabled: false,
				dialogFormVisibleMoney: false,
				qrCodeVisible: false,
				qrCodeType: '',
				uploadUrl: config.baseUrl + 'file/upload',
				imageUrl: '',
				headers: {Token: localStorage.getItem('frontToken')},
				userTableName: localStorage.getItem('UserTableName'),
				dynamicProp: {},
				redNum: 0,
				recordList: [],
				chatVisible: false,
				nowfid: 0,
				nowfpic:'',
				nowname: '',
				mypic: localStorage.getItem('frontHeadportrait'),
				chatList: [],
				chatForm: {
					content: ''
				},
				hasChatList: [
					'yonghu',
				],
			}
		},
		async created() {
			let menus = menu.list()
			for(let x in menus){
				if(menus[x].tableName == this.userTableName){
					for(let i in menus[x].backMenu){
						if(menus[x].backMenu[i].child&&menus[x].backMenu[i].child.length&&menus[x].backMenu[i].child[0].tableName.indexOf('exam')!=-1){
							menus[x].backMenu.splice(i,1)
						}
					}
					this.menuList = menus[x].backMenu
				}
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'yonghuzhanghao', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'yonghuxingming', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'mima', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'touxiang', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'xingbie', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'lianxifangshi', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'sfsh', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'shhf', null);
			}
			if ('yonghu' == this.userTableName) {
				this.$set(this.sessionForm, 'money', null);
			}

			if ('yonghu' == this.userTableName) {
				if (this.rules['yonghuzhanghao']){
					this.rules['yonghuzhanghao'].push({ required: true, message: '请输入用户账号', trigger: 'blur' })
				}else if(!this.rules['yonghuzhanghao']) {
					this.$set(this.rules, 'yonghuzhanghao', [{ required: true, message: '请输入用户账号', trigger: 'blur' }]);
				}
				if (this.rules['yonghuxingming']){
					this.rules['yonghuxingming'].push({ required: true, message: '请输入用户姓名', trigger: 'blur' })
				}else if(!this.rules['yonghuxingming']) {
					this.$set(this.rules, 'yonghuxingming', [{ required: true, message: '请输入用户姓名', trigger: 'blur' }]);
				}
				if (this.rules['mima']){
					this.rules['mima'].push({ required: true, message: '请输入密码', trigger: 'blur' })
				}else if(!this.rules['mima']) {
					this.$set(this.rules, 'mima', [{ required: true, message: '请输入密码', trigger: 'blur' }]);
				}
				this.$set(this.rules, 'money', [{ required: false, validator: this.$validate.isNumber, trigger: 'blur' }]);
				this.ro = {
					yonghuzhanghao: true,
					yonghuxingming: false,
					mima: false,
					touxiang: false,
					xingbie: false,
					lianxifangshi: false,
					sfsh: false,
					shhf: false,
					money: false,
				}
			}

			this.init();
			await this.$http.get(`${localStorage.getItem('UserTableName')}/session`, {emulateJSON: true}).then(async res => {
				if (res.data.code == 0) {
					this.sessionForm = res.data.data
				}
			});
			if(this.changeHasChat()) {
				this.getRecordList2()
			}
		},
		//方法集合
		methods: {
			init() {
				if ('yonghu' == this.userTableName) {
					this.dynamicProp.xingbie = '男,女'.split(',');
				}
			},
			setSession(){
				localStorage.setItem('sessionForm',JSON.stringify(this.sessionForm))
			},
			onSubmit(formName) {
				if(`yonghu` == this.userTableName && this.sessionForm.touxiang!=null){
					this.sessionForm.touxiang = this.sessionForm.touxiang.replace(new RegExp(this.$config.baseUrl,"g"),"");
				}
				this.$refs[formName].validate((valid) => {
					if (valid) {
						this.$http.post(this.userTableName + '/update', this.sessionForm).then(res => {
							if (res.data.code == 0) {
								this.setSession()
								this.$message({
									message: '更新成功',
									type: 'success',
									duration: 1500
								});
							}
						});
					} else {
						return false;
					}
				});
			},
			yonghutouxiangHandleAvatarSuccess(fileUrls) {
				this.sessionForm.touxiang = fileUrls;
			},
			chongzhi() {
				if (this.chongzhiForm.money == '') {
					this.$message({
						message: '请输入充值金额',
						type: 'error',
						duration: 1500
					});
					return;
				}
				if (this.chongzhiForm.money <= 0) {
					this.$message({
						message: '请输入正确的充值金额',
						type: 'error',
						duration: 1500
					});
					return;
				}
				if (this.chongzhiForm.radio == '') {
					this.$message({
						message: '请选择充值方式',
						type: 'error',
						duration: 1500
					});
					return;
				}
				if(!this.sessionForm.money) {
					this.sessionForm.money = parseFloat(this.chongzhiForm.money)
				}else{
					this.sessionForm.money = parseFloat(this.sessionForm.money) + parseFloat(this.chongzhiForm.money);
				}
				
				this.$http.post(this.userTableName + '/update', this.sessionForm).then(res => {
					if (res.data.code == 0) {
						this.$http.post('chargerecord/add',{
							username: localStorage.getItem("username"),
							role: localStorage.getItem("frontRole"),
							amount: parseFloat(this.chongzhiForm.money),
							userid: this.sessionForm.id
						}).then(rs=>{
							this.setSession()
							this.$message({
								message: '充值成功',
								type: 'success',
								duration: 1500,
								onClose: () => {
									this.dialogFormVisibleMoney = false;
								}
							});
						})
					}
				});
			},
			qrCodeClick(type=1){
				if(type==1) {
					if (this.chongzhiForm.money == '') {
						this.$message({
							message: '请输入充值金额',
							type: 'error',
							duration: 1500
						});
						return;
					}
					if (this.chongzhiForm.money <= 0) {
						this.$message({
							message: '请输入正确的充值金额',
							type: 'error',
							duration: 1500
						});
						return;
					}
				}
				this.qrCodeType = type
				this.qrCodeVisible = true
			},
			qrCodeSave(){
				if(this.qrCodeType==1) {
					if(!this.sessionForm.money) {
						this.sessionForm.money = parseFloat(this.chongzhiForm.money)
					}else{
						this.sessionForm.money = parseFloat(this.sessionForm.money) + parseFloat(this.chongzhiForm.money);
					}
					
					this.$http.post(this.userTableName + '/update', this.sessionForm).then(res => {
						if (res.data.code == 0) {
							this.$http.post('chargerecord/add',{
								username: localStorage.getItem("username"),
								role: localStorage.getItem("frontRole"),
								amount: parseFloat(this.chongzhiForm.money),
								userid: this.sessionForm.id
							}).then(rs=>{
								this.setSession()
								this.$message({
									message: '充值成功',
									type: 'success',
									duration: 1500,
									onClose: () => {
										this.chongzhiForm.money = ''
										this.dialogFormVisibleMoney = false;
										this.qrCodeVisible = false;
									}
								});
							})
						}
					});
				}
			},
			handleClick(name) {
				switch(name) {
					case '个人中心':
						this.activeName = name
						this.$router.push('/index/center');
						break;
					case '修改密码':
						this.activeName = name
						this.passwordForm = {
							password: '',
							newpassword: '',
							repassword: '',
						}
						this.psdType = '1'
						this.$forceUpdate()
						break;
					case '聊天记录':
						this.activeName = name
						this.getRecordList()
						break;
					case '我的订单':
						this.$router.push('/index/shop-order/order');
						break;
					case '我的地址':
						this.$router.push('/index/shop-address/list');
						break;
					case '我的点赞':
						localStorage.setItem('storeupType', 21);
						this.$router.push('/index/storeup');
						break;
					case '我的收藏':
						localStorage.setItem('storeupType', 1);
						this.$router.push('/index/storeup');
						break;
					case '我的评论':
						localStorage.setItem('storeupType', 81);
						this.$router.push('/index/storeup');
						break;
				}

				this.title = event.target.outerText;
			},
			changeHasChat(){
				let table = localStorage.getItem('frontSessionTable')
				for(let x in this.hasChatList){
					if(this.hasChatList[x]==table){
						return true
					}
				}
				return false
			},
			getRecordList() {
				this.$http.get('friend/page2', {
					params: {
						uid: Number(localStorage.getItem('frontUserid')),
						type: 2
					}
				}).then(res => {
					if (res.data && res.data.code == 0) {
						this.recordList = res.data.data.list
					}
				})
			},
			getRecordList2() {
				this.$http.get('friend/page2', {
					params: {
						uid: Number(localStorage.getItem('frontUserid')),
						type: 2
					}
				}).then(res => {
					if (res.data && res.data.code == 0) {
						let num = 0
						for(let x in res.data.data.list) {
							num += Number(res.data.data.list[x].notreadnum)
						}
						this.redNum = num
					}
				})
			},
			chatClick(row) {
				this.nowfid = row.fid
				this.nowfpic = row.picture
				this.nowname = row.name
				this.initWebSocket(this.nowfid)
				this.getChatList()
				this.chatVisible = true
			},
			chatDel(row){
				this.$confirm('是否删除聊天记录？').then(_ => {
					let arr = []
					let brr = []
					this.$http.get('chatmessage/list',{params: {
						page: 1,
						limit: 10000,
						uid: Number(localStorage.getItem('frontUserid')),
						fid: row.fid
					}}).then(rs=>{
						if(rs.data.data.list.length){
							for(let x in rs.data.data.list){
								arr.push(rs.data.data.list[x].id)
							}
						}
						this.$http.get('chatmessage/list',{params: {
							page: 1,
							limit: 10000,
							uid: row.fid,
							fid: Number(localStorage.getItem('frontUserid'))
						}}).then(rs2=>{
							if(rs2.data.data.list.length){
								for(let x in rs2.data.data.list){
									arr.push(rs2.data.data.list[x].id)
								}
							}
							if(arr.length){
								this.$http.post('chatmessage/delete',arr).then(()=>{})
							}
							this.$http.get('friend/list',{params: {
								page: 1,
								limit: 10000,
								uid: row.fid,
								fid: Number(localStorage.getItem('frontUserid')),
								type: 0
							}}).then(rs3=>{
								if(rs3.data.data.list.length){
									for(let x in rs3.data.data.list){
										brr.push(rs3.data.data.list[x].id)
									}
								}
								this.$http.get('friend/list',{params: {
									page: 1,
									limit: 10000,
									fid: row.fid,
									uid: Number(localStorage.getItem('frontUserid')),
									type: 0
								}}).then(rs4=>{
									if(rs4.data.data.list.length){
										for(let x in rs4.data.data.list){
											brr.push(rs4.data.data.list[x].id)
										}
									}
									this.$http.get('friend/list',{params: {
										page: 1,
										limit: 10000,
										fid: row.fid,
										uid: Number(localStorage.getItem('frontUserid')),
										type: 2
									}}).then(rs5=>{
										if(rs5.data.data.list.length){
											for(let x in rs5.data.data.list){
												brr.push(rs5.data.data.list[x].id)
											}
										}
										this.$http.get('friend/list',{params: {
											page: 1,
											limit: 10000,
											uid: row.fid,
											fid: Number(localStorage.getItem('frontUserid')),
											type: 2
										}}).then(rs6=>{
											if(rs6.data.data.list.length){
												for(let x in rs6.data.data.list){
													brr.push(rs6.data.data.list[x].id)
												}
											}
											this.$http.post('friend/delete',brr).then(()=>{
												this.$message.success('删除成功')
												this.getRecordList()
											})
										})
									})
								})
							})
						})
					})
				}).catch(_ => {});
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
						fid: this.nowfid
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
				this.chatList = []
				this.getRecordList()
				this.getRecordList2()
			},
			uploadSuccess(res) {
				if (res.code == 0) {
					this.addChat('upload/' + res.file,2);
				}
			},
			uploadSuccess2(res) {
				if (res.code == 0) {
					this.addChat('upload/' + res.file,3);
				}
			},
			uploadSuccess3(res) {
				if (res.code == 0) {
					this.addChat('upload/' + res.file,4);
				}
			},
			addChat(ask=null) {
				this.$http.post('chatmessage/add', {
					uid: Number(localStorage.getItem('frontUserid')),
					fid: this.nowfid,
					content: ask?ask:this.chatForm.content,
					format: ask?2:1
				}).then(res2 => {
					this.websocketSend(ask?ask:this.chatForm.content)
					this.chatForm = {
						content: ''
					}
					this.getChatList()
				})
			},
			chatDownload(url){
				if(!url){
					return false
				}
				window.open((location.href.split(this.$config.name).length>1 ? location.href.split(this.$config.name)[0] + this.$config.name + '/' + url :this.$config.baseUrl + url))
			},
			async updatePassword(){
				this.$refs["passwordForm"].validate(async valid => {
					if (valid) {
						var password = "";
						if (this.sessionForm.mima) {
							password = this.sessionForm.mima;
						} else if (this.sessionForm.password) {
							password = this.sessionForm.password;
						}
						if (this.userTableName == 'yonghu') {
						}
						if (this.passwordForm.password != password) {
							this.$message.error("原密码错误");
							return;
						}
						if (this.passwordForm.newpassword != this.passwordForm.repassword) {
							this.$message.error("两次密码输入不一致");
							return;
						}
						if (this.passwordForm.newpassword == this.passwordForm.password) {
							this.$message.error("新密码与原密码相同！");
							return;
						}
						this.sessionForm.password = this.passwordForm.newpassword;
						this.sessionForm.mima = this.passwordForm.newpassword;
						this.$http.post(`${this.userTableName}/update`,this.sessionForm).then(({data})=>{
							if (data && data.code === 0) {
								this.$message({
									message: "修改密码成功,下次登录系统生效",
									type: "success",
									duration: 1500,
									onClose: () => {
									}
								});
								this.setSession()
							} else {
								this.$message.error(data.msg);
							}
						});
					}
				})
			},
			logout() {
				localStorage.clear();
				Vue.http.headers.common['Token'] = "";
				this.$router.push('/index/home');
				this.activeIndex = '0'
				localStorage.setItem('keyPath', this.activeIndex)
				this.$forceUpdate()
				this.$message({
					message: '登出成功',
					type: 'success',
					duration: 1500,
				});
			},
			hasBack(name,tablename){
				if(name=='订单管理') {
					return false
				}
				if(name.indexOf('章节')!=-1&&tablename.substring(0,7)=='chapter') {
					return false
				}
				return true
			},
			menuClick(row,length=1) {
				if(length==1) {
					if(row.tableName=='storeup') {
						localStorage.setItem('storeupType', row.menuJump);
						this.$router.push('/index/storeup');
						return false
					}
					this.$router.push(`/index/${row.tableName}?centerType=1`);
				}
			},
			centerTabEnter(name){
				this.showActive = name?('show' + name):''
			},
		}
	}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.center-preview {
		padding: 0 10%;
		margin: 10px auto 30px;
		background: none;
		display: flex;
		width: 100%;
		justify-content: flex-start;
		align-items: flex-start;
		position: relative;
		flex-wrap: wrap;
		.center-title {
			padding: 0;
			color: #333;
			background: none;
			font-weight: 500;
			display: block;
			width: 100%;
			font-size: 30px;
			border-color: #000;
			border-width: 4px;
			line-height: 60px;
			border-style: double;
			text-align: center;
		}
		.center-info {
			border: 0px solid #eee;
			padding: 10px 10px 10px 200px;
			margin: 20px 0px 0 0;
			color: #555;
			display: none;
			font-size: 15px;
			min-height: 180px;
			flex-wrap: wrap;
			border-radius: 0px;
			box-shadow: none;
			align-content: center;
			background: #f8f8f8;
			width: 100%;
			align-items: center;
			position: relative;
			height: auto;
			order: 0;
			.center-info-title {
				color: #666;
				font-weight: 500;
				font-size: 22px;
				border-color: #efefef;
				line-height: 40px;
				top: 10px;
				left: 35px;
				width: 100%;
				border-width: 0px 0;
				position: absolute;
				border-style: solid;
				text-align: left;
				height: 40px;
			}
			.img-box {
				top: 50px;
				left: 20px;
				width: auto;
				font-size: 0;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				position: absolute;
				border-style: solid;
				height: auto;
				img {
					border-radius: 120px;
					margin: 10px auto;
					object-fit: contain;
					display: block;
					width: 100px;
					border-color: #efefef;
					border-width: 0 0 0px 0;
					border-style: solid;
					height: 100px;
				}
			}
			.info-item1 {
				padding: 0 0px;
				display: inline-block;
				width: 30%;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				line-height: 40px;
				border-style: solid;
				height: auto;
				.icon {
					padding: 0 5px;
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.label {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
			}
			.info-item2 {
				padding: 0 0px;
				display: inline-block;
				width: 30%;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				line-height: 40px;
				border-style: solid;
				height: auto;
				.icon {
					padding: 0 5px;
					color: inherit;
					display: inline-block;
				}
				.label {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
			}
			.info-item3 {
				padding: 0 0px;
				display: inline-block;
				width: 30%;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				line-height: 40px;
				border-style: solid;
				height: auto;
				.icon {
					padding: 0 5px;
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.label {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
			}
			.info-item4 {
				padding: 0 0px;
				display: inline-block;
				width: 30%;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				line-height: 40px;
				border-style: solid;
				height: auto;
				.icon {
					padding: 0 5px;
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.label {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
			}
			.info-item5 {
				padding: 0 0px;
				display: inline-block;
				width: 30%;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				line-height: 40px;
				border-style: solid;
				height: auto;
				.icon {
					padding: 0 5px;
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.label {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
			}
			.info-item6 {
				padding: 0 0px;
				display: inline-block;
				width: 30%;
				border-color: #efefef;
				border-width: 0 0 0px 0;
				line-height: 40px;
				border-style: solid;
				height: auto;
				.icon {
					padding: 0 5px;
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.label {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
				.text {
					color: inherit;
					display: inline-block;
					font-size: inherit;
				}
			}
		}
		.center-box {
			border-radius: 10px;
			padding: 0;
			margin: 20px 0 0;
			background: none;
			display: flex;
			width: 100%;
			flex-wrap: wrap;
			.center-tab-view {
				border: 1px solid #000;
				margin: 20px 30px 0 0;
				background: #fff;
				width: 260px;
				min-height: 100vh;
				height: auto;
				order: 0;
			}
			.center-tab-view .center-tab {
				border: 0;
				padding: 0 20px;
				margin: 0 0px 0px 0;
				color: #333;
				font-weight: 500;
				display: inline-block;
				font-size: 16px;
				border-color: #eee;
				line-height: 48px;
				float: left;
				background: none;
				border-width: 0px 0 0;
				position: relative;
				border-style: solid;
				list-style: none;
				min-width: 100%;
				height: 48px;
				.center-second-tab-view {
					padding: 0 20px;
					z-index: 999;
					top: 0;
					left: 100%;
					background: #fff;
					width: 100%;
					position: absolute;
					.center-second-tab {
						color: #666;
						width: 100%;
						font-size: 15px;
						border-color: #eee;
						border-width: 0 0 1px;
						border-style: solid;
					}
					.center-second-tab:hover {
						cursor: pointer;
						color: #054acc;
					}
				}
			}
			.center-tab-view .center-tab:hover {
				cursor: pointer;
				padding: 0 20px;
				color: #fff;
				background: #054acc;
				font-weight: 500;
				font-size: 16px;
				line-height: 48px;
				position: relative;
				height: 48px;
			}
			.center-tab-view .center-tab.is-active {
				cursor: pointer;
				padding: 0 20px;
				margin: 0 0px 0px 0;
				color: #fff;
				background: #054acc;
				font-weight: 500;
				font-size: 16px;
				line-height: 48px;
				position: relative;
				float: left;
				min-width: 100%;
				height: 48px;
			}
			.center-content-box {
				padding: 30px 15% 30px 3%;
				overflow: hidden;
				background: #fff;
				flex: 1;
				width: 100%;
				clear: both;
			}
			.center-content-view {
				width: 100%;
			}
			.center-preview-pv {
				.center-item.el-form-item {
					padding: 0px;
					margin: 0 0 24px;
					background: none;
					/deep/ .el-form-item__label {
						padding: 0 10px 0 0;
						color: #666;
						white-space: nowrap;
						font-weight: 500;
						width: 180px;
						font-size: 16px;
						line-height: 40px;
						text-align: right;
					}
					.el-form-item__content {
						margin-left: 180px;
					}
					.el-input {
						width: 100%;
					}
					.el-input /deep/ .el-input__inner {
						border: 1px solid #eee;
						border-radius: 0px;
						padding: 0 12px;
						box-shadow: none;
						outline: none;
						color: #333;
						width: 100%;
						font-size: 16px;
						height: 40px;
					}
					.el-input /deep/ .el-input__inner[readonly="readonly"] {
						border: 0px solid #ddd;
						cursor: not-allowed;
						border-radius: 4px;
						padding: 0 12px;
						box-shadow: none;
						outline: none;
						color: rgba(85, 85, 127, 1.0);
						width: 100%;
						font-size: 16px;
						height: 40px;
					}
					.el-select {
						width: 100%;
					}
					.el-select /deep/ .el-input__inner {
						border: 1px solid #eee;
						border-radius: 0px;
						padding: 0 10px;
						box-shadow: none;
						outline: none;
						color: #333;
						width: 100%;
						font-size: 16px;
						height: 40px;
					}
					.el-select /deep/ .is-disabled .el-input__inner {
						border: 0px solid #ddd;
						cursor: not-allowed;
						border-radius: 4px;
						padding: 0 10px;
						box-shadow: none;
						outline: none;
						color: #333;
						background: #eee;
						width: 100%;
						font-size: 16px;
						height: 40px;
					}
					.el-date-editor {
						width: 100%;
					}
					.el-date-editor /deep/ .el-input__inner {
						border: 1px solid #eee;
						border-radius: 0px;
						padding: 0 10px 0 30px;
						box-shadow: none;
						outline: none;
						color: #333;
						width: 100%;
						font-size: 16px;
						height: 40px;
					}
					.el-date-editor /deep/ .el-input__inner[readonly="readonly"] {
						border: 0;
						cursor: not-allowed;
						border-radius: 4px;
						padding: 0 10px 0 30px;
						box-shadow: none;
						outline: none;
						color: #333;
						background: #eee;
						width: 100%;
						font-size: 16px;
						height: 40px;
					}
					/deep/ .el-upload--picture-card {
						background: transparent;
						border: 0;
						border-radius: 0;
						width: auto;
						height: auto;
						line-height: initial;
						vertical-align: middle;
					}
					/deep/ .upload .upload-img {
						border: 1px solid #eee;
						cursor: pointer;
						border-radius: 0px;
						color: #999;
						width: 80px;
						font-size: 26px;
						line-height: 80px;
						text-align: center;
						height: 80px;
					}
					/deep/ .el-upload-list .el-upload-list__item {
						border: 1px solid #eee;
						cursor: pointer;
						border-radius: 0px;
						color: #999;
						width: 80px;
						font-size: 26px;
						line-height: 80px;
						text-align: center;
						height: 80px;
						font-size: 14px;
						line-height: 1.8;
					}
					/deep/ .el-upload .el-icon-plus {
						border: 1px solid #eee;
						cursor: pointer;
						border-radius: 0px;
						color: #999;
						width: 80px;
						font-size: 26px;
						line-height: 80px;
						text-align: center;
						height: 80px;
					}
					/deep/ .el-upload__tip {
						color: #666;
						font-size: 15px;
					}
					/deep/ .el-input__inner::placeholder {
						color: #123;
						font-size: 16px;
					}
					.editor {
						border: 0px solid #ddd;
						border-radius: 4px;
						box-shadow: none;
						outline: none;
						color: #333;
						width: 100%;
						font-size: 14px;
						line-height: 32px;
					}
					.editor /deep/.ql-toolbar {
						border: 1px solid #eee;
						background: none;
						border-width: 1px 1px 0;
					}
					.editor /deep/.ql-container {
						border: 1px solid #eee;
						background: none;
						min-height: 180px;
					}
					.editor /deep/.ql-container .ql-blank::before {
						color: #999;
					}
					.balance-item {
						display: block;
						.el-input {
							width: auto;
						}
						.el-input /deep/ .el-input__inner {
							border: 1px solid #eee;
							border-radius: 0px;
							padding: 0 12px;
							box-shadow: none;
							outline: none;
							color: #333;
							background: #fff;
							display: inline-block;
							width: 200px;
							font-size: 16px;
							height: 40px;
						}
						.balanceBtn {
							border: 0px solid #eee;
							cursor: pointer;
							border-radius: 4px;
							padding: 0 15px;
							margin: 0 20px 0 10px;
							outline: none;
							background: #054acc;
							display: inline-block;
							width: auto;
							font-size: 14px;
							line-height: 40px;
							height: 40px;
							.icon {
								color: #fff;
							}
							.text {
								color: #fff;
								font-size: 16px;
							}
						}
						.balanceBtn:hover {
							opacity: 0.8;
							.icon {
							}
							.text {
							}
						}
					}
				}
				.center-btn-item {
					padding: 0;
					margin: 40px auto 0;
					background: none;
					width: 100%;
					.updateBtn {
						border: 0;
						cursor: pointer;
						border-radius: 4px;
						padding: 0 15px;
						margin: 0 20px 0 0;
						outline: none;
						background: #054acc;
						display: inline-block;
						width: auto;
						font-size: 16px;
						line-height: 40px;
						height: 40px;
						.icon {
							color: rgba(255, 255, 255, 1);
						}
						.text {
							color: rgba(255, 255, 255, 1);
						}
					}
					.updateBtn:hover {
						opacity: 0.7;
						.icon {
							color: #fff;
						}
						.text {
							color: #fff;
						}
					}
					.closeBtn {
						border: 1px solid #ddd;
						cursor: pointer;
						border-radius: 4px;
						padding: 0 15px;
						margin: 0 20px 0 0;
						outline: none;
						background: #eee;
						display: inline-block;
						width: auto;
						font-size: 16px;
						line-height: 40px;
						height: 40px;
						.icon {
							color: #333;
						}
						.text {
							color: #333;
						}
					}
					.closeBtn:hover {
						opacity: 0.7;
						.icon {
						}
						.text {
						}
					}
				}
				.el-date-editor.el-input {
					width: auto;
				}
			}
		}
	}
	.z-box {
		padding: 0;
		margin: 0 auto;
		background: none;
		width: 100%;
		.section-content {
			cursor: pointer;
			padding: 20px;
			margin: 0 0 20px;
			color: #333;
			display: flex;
			border-color: #eee;
			box-shadow: none;
			background: #fff;
			width: 100%;
			justify-content: space-between;
			border-width: 0 0 1px;
			align-items: center;
			position: relative;
			border-style: solid;
			.chat-left {
				display: flex;
				align-items: center;
				img {
					border-radius: 5px;
					width: 60px;
					transition: all .4s;
					height: 60px;
				}
				.chat-info {
					margin: 0 0 0 10px;
					flex-direction: column;
					display: flex;
					align-items: flex-start;
					.chat-name {
						color: #888;
						flex: 1;
						font-weight: bold;
						font-size: 14px;
						transition: all .4s;
					}
					.chat-text {
						color: #888;
						flex: 1;
						display: flex;
						font-size: 12px;
						line-height: 1.5;
						align-items: center;
						transition: all .4s;
						.chat-noread {
							border-radius: 50%;
							padding: 0 5px;
							margin: 0 2px 0 0;
							color: #fff;
							background: #f00;
							width: auto;
							font-size: 12px;
							line-height: 16px;
							text-align: center;
							height: 16px;
						}
					}
				}
			}
			.chat-btn {
				flex-direction: column;
				display: flex;
				.friendBtn1 {
					padding: 0px 10px;
					margin: 0px;
					color: #fff;
					background: rgba(75, 223, 201,1);
					text-decoration: none;
					width: 80px;
					font-size: 12px;
					line-height: 30px;
					text-align: center;
					height: 30px;
				}
				.friendBtn1:hover {
					background: rgba(75, 223, 201,.5);
				}
				.friendBtn2 {
					padding: 0px 10px;
					margin: 0px;
					color: #fff;
					background: rgba(255, 85, 0, 1.0);
					text-decoration: none;
					width: 80px;
					font-size: 12px;
					line-height: 30px;
					text-align: center;
					height: 30px;
				}
				.friendBtn2:hover {
					background: rgba(255, 85, 0, 0.5);
				}
			}
		}
		.section-content:hover {
			color: #fff;
			background: #DF847F10;
			.chat-left {
				img {
					border-radius: 5px;
				}
				.chat-info {
					.chat-name {
						color: #000;
					}
					.chat-text {
						color: #000;
						font-size: 13px;
					}
				}
			}
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
	.noList {
		color: #9e9e9e;
		width: 100%;
		text-align: center;
		padding: 60px 0;
	}
</style>
