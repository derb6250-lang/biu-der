<template>
	<div>
		<div class="login-container" :style="{'backgroundImage': indexBgUrl?`url(${$base.url + indexBgUrl})`:''}">
			<el-form class="login_form animate__animated animate__">
				<div class="login_form2">
					<div class="title-container">二手羽毛球装备交易系统登录</div>
					<div v-if="loginType==1" class="list-item">
						<div class="lable">
							账号：
						</div>
						<input placeholder="请输入账号：" name="username" type="text" v-model="rulesForm.username">
					</div>
					<div v-if="loginType==1" class="list-item">
						<div class="lable">
							密码：
						</div>
						<div class="password-box">
							<input placeholder="请输入密码：" name="password" :type="showPassword?'text':'password'" v-model="rulesForm.password">
							<span class="icon iconfont" :class="showPassword?'icon-liulan13':'icon-liulan17'" @click="showPassword=!showPassword"></span>
						</div>
					</div>

					<div class="list-item " v-if="roles.length>1&&loginType<=2">
						<div class="lable">
							角色：
						</div>
						<div prop="loginInRole" class="list-type">
							<el-radio v-if="loginType==1||(loginType==2&&item.role!='users')" v-for="item in roles" v-bind:key="item.roleName" v-model="rulesForm.role" :label="item.roleName">{{item.roleName}}</el-radio>
						</div>
					</div>

		
					<div class="login-btn">
						<div class="login-btn1">
							<el-button v-if="loginType==1||loginType==3||loginType==4" type="primary" @click="login()" class="loginInBt">登录</el-button>
						</div>
						<div class="login-btn2">
						</div>
						<div class="login-btn3">
						</div>
					</div>
				</div>
			</el-form>
		</div>
	</div>
</template>
<script>
	import 'animate.css'
	import menu from "@/utils/menu";
	export default {
		data() {
			return {
				verifyCheck2: false,
				flag: false,
				baseUrl:this.$base.url,
				loginType: 1,
				rulesForm: {
					username: "",
					password: "",
					role: "",
				},
				menus: [],
				roles: [],
				tableName: "",
				showPassword: false,
				indexBgUrl: '',
			};
		},
		mounted() {
			let menus = menu.list();
			this.menus = menus;

			for (let i = 0; i < this.menus.length; i++) {
				if (this.menus[i].hasBackLogin=='是') {
					this.roles.push(this.menus[i])
				}
			}

		},
		created() {
			this.$http.get('config/info?name=bLoginBackgroundImg',).then(rs=>{this.indexBgUrl = rs.data.data?rs.data.data.value:''})
		},
		destroyed() {
		},
		components: {
		},
		methods: {

			//注册
			register(tableName){
				this.$storage.set("loginTable", tableName);
				this.$router.push({path:'/register',query:{pageFlag:'register'}})
			},
			// 登陆
			login() {
				if(this.loginType==1) {

					if (!this.rulesForm.username) {
						this.$message.error("请输入用户名");
						return;
					}
					if (!this.rulesForm.password) {
						this.$message.error("请输入密码");
						return;
					}
					if(this.roles.length>1) {
						if (!this.rulesForm.role) {
							this.$message.error("请选择角色");
							return;
						}
					
						for (let i = 0; i < this.roles.length; i++) {
							if (this.roles[i].roleName == this.rulesForm.role) {
								this.tableName = this.roles[i].tableName;
							}
						}
					} else {
						this.tableName = this.roles[0].tableName;
						this.rulesForm.role = this.roles[0].roleName;
					}
				}
		
				this.loginPost()
			},
			loginPost() {
				this.$http({
					url: `${this.tableName}/login?username=${this.rulesForm.username}&password=${this.rulesForm.password}`,
					method: "post"
				}).then(({ data }) => {
					if (data && data.code === 0) {
						this.$storage.set("Token", data.token);
						this.$storage.set("role", this.rulesForm.role);
						this.$storage.set("sessionTable", this.tableName);
						this.$storage.set("adminName", this.rulesForm.username);
						this.$nextTick(()=>{
							this.$http({
								url: this.tableName + '/session',
								method: "get"
							}).then(({
								data
							}) => {
								if (data && data.code === 0) {
									if(this.tableName == 'yonghu') {
										this.$storage.set('headportrait',data.data.touxiang)
									}
									if(this.tableName == 'users') {
										this.$storage.set('headportrait',data.data.image)
									}
									this.$storage.set('userForm',JSON.stringify(data.data))
									this.$storage.set('userid',data.data.id);
								} else {
									let message = this.$message
									message.error(data.msg);
								}
								this.$router.replace({ path: "/" });
							});
						})
					}
					else {
						this.$message.error(data.msg);
					}
				});
			},
		}
	}
</script>

<style lang="scss" scoped>
.login-container {
	min-height: 100vh;
	position: relative;
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
	background: url(http://codegen.caihongy.cn/20250811/2e894aa374da45dd84f96016b8ebc886.png);
	background-repeat: no-repeat !important;
	background-size: cover !important;
	background: url(http://codegen.caihongy.cn/20250811/2e894aa374da45dd84f96016b8ebc886.png);
	display: flex;
	width: 100%;
	min-height: 100vh;
	justify-content: center;
	align-items: center;
	background-position: center center;
	position: relative;

	.login_form {
		background: url(http://codegen.caihongy.cn/20250811/5278ce06cfaa4968ac2cccf9f4887350.png) no-repeat center center / 100% 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		.login_form2 {
			border-radius: 24px 24px 24px 24px;
			padding: 70px 40px 20px 20px;
			margin: 30px 60px;
			background: linear-gradient( 180deg, #FFFFFF 0%, #FBFBFB 24%, #ECECEC 62%, #B8B8B8 100%);
			display: flex;
			width: 706px;
			position: relative;
			flex-wrap: wrap;
		}
		.title-container {
			color: #212D3F;
			top: -17%;
			left: -51%;
			background: none;
			font-weight: bold;
			width: 200%;
			font-size: 32px;
			font-family: Segoe UI, Segoe UI;
			position: absolute;
			text-align: center;
			height: auto;
			order: -2;
		}
		.list-item {
			border: none;
			border-radius: 0px;
			padding: 0 20px;
			margin: 10px auto ;
			background: none;
			display: flex;
			width: 100%;
			align-items: center;
			.lable {
				color: #333333;
				width: 100px;
				font-size: 22px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				line-height: 50px;
				border-style: solid;
				text-align: right;
				height: 64px;
			}
			input {
				border: 1px solid #DADFE6;
				padding: 0 10px;
				color: #333;
				font-size: 16px;
				border-color: #d1d1d1;
				border-radius: 0px;
				box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: none;
				flex: 1;
				width: 100%;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			input:focus {
				border: 1px solid #DADFE6;
				padding: 0 10px;
				color: #333;
				font-size: 16px;
				border-color: #d1d1d1;
				border-radius: 0px;
				box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: none;
				flex: 1;
				width: 100%;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.password-box {
				flex: 1;
				display: flex;
				width: 100%;
				position: relative;
				align-items: center;
				input {
					border: 1px solid #DADFE6;
					padding: 0 10px;
					color: #333;
					font-size: 16px;
					border-color: #d1d1d1;
					border-radius: 0px;
					box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
					background: none;
					flex: 1;
					width: 100%;
					border-width: 0 0 0px;
					border-style: solid;
					height: 50px;
				}
				input:focus {
					border: 1px solid #DADFE6;
					padding: 0 10px;
					color: #333;
					font-size: 16px;
					border-color: #d1d1d1;
					border-radius: 0px;
					box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
					background: none;
					flex: 1;
					width: 100%;
					border-width: 0 0 0px;
					border-style: solid;
					height: 50px;
				}
				.iconfont {
					cursor: pointer;
					z-index: 1;
					color: #000;
					top: 0;
					font-size: 16px;
					line-height: 60px;
					position: absolute;
					right: 10px;
				}
			}
			input::placeholder {
				color: #666;
				font-size: 16px;
			}
		}
		.list-type {
			margin: 0px auto;
			background: none;
			display: flex;
			width: 80%;
			line-height: 32px;
			align-items: center;
			flex-wrap: wrap;
			height: 64px;
			/deep/ .el-radio__input .el-radio__inner {
				background: rgba(53, 53, 53, 0);
				font-size: 22px;
				border-color: #212D3F;
			}
			/deep/ .el-radio__input.is-checked .el-radio__inner {
				background: #1B70FB;
				font-size: 22px;
				border-color: #1B70FB;
			}
			/deep/ .el-radio__label {
				color: #212D3F;
				font-size: 22px;
			}
			/deep/ .el-radio__input.is-checked+.el-radio__label {
				color: #212D3F;
				font-size: 22px;
			}
		}
		.login-btn {
			margin: 0 30px;
			background: none;
			display: flex;
			width: 100%;
			flex-wrap: wrap;
			.login-btn1 {
				margin: 0 0 10px 0;
				display: flex;
				width: 100%;
				justify-content: center;
			}
			.login-btn2 {
				margin: 10px 0 20px;
				z-index: 9;
				order: 5;
			}
			.login-btn3 {
				z-index: 1;
				top: 36px;
				width: 100%;
				text-align: right;
				order: 5;
			}
			.loginInBt {
				border: 0;
				cursor: pointer;
				border-radius: 0px;
				box-shadow: inset 0px 3px 6px 1px #9ADAFF;
				margin: 0 auto;
				outline: none;
				color: #FFFFFF;
				background: linear-gradient( 180deg, #0098EF 0%, #0075B8 100%);
				font-weight: 400;
				width: 250px;
				font-size: 22px;
				height: 53px;
			}
			.loginInBt:hover {
				opacity: 0.8;
			}
			.register {
				border: 0;
				cursor: pointer;
				border-radius: 0px;
				padding: 0 24px;
				margin: 0 10px;
				outline: none;
				color: #0D56C9;
				background: none;
				font-weight: 400;
				font-size: 18px;
				height: 50px;
			}
			.register:hover {
				opacity: 0.8;
			}
			.forget {
				border: 0;
				cursor: pointer;
				border-radius: 0px;
				padding: 0 10px;
				margin: 0 0 15px 5px;
				outline: none;
				color: #136BFB;
				background: none;
				width: auto;
				font-size: 15px;
				height: 36px;
			}
			.forget:hover {
				opacity: 0.8;
			}
		}
	}
}

</style>
