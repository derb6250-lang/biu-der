<template>
	<div>
		<div class="register-container" :style="{'backgroundImage': indexBgUrl?`url(${$base.url + indexBgUrl})`:''}">
			<el-form v-if="pageFlag=='register'" ref="ruleForm" class="rgs-form animate__animated animate__" :model="ruleForm" :rules="rules">
				<div class="rgs-form2">
					<div class="title">二手羽毛球装备交易系统</div>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('yonghuzhanghao')?'required':''">用户账号：</div>
						<el-input  v-model="ruleForm.yonghuzhanghao" :readonly="ro.yonghuzhanghao" autocomplete="off" placeholder="用户账号"  type="text"  />
					</el-form-item>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('yonghuxingming')?'required':''">用户姓名：</div>
						<el-input  v-model="ruleForm.yonghuxingming" :readonly="ro.yonghuxingming" autocomplete="off" placeholder="用户姓名"  type="text"  />
					</el-form-item>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('mima')?'required':''">密码：</div>
						<el-input  v-model="ruleForm.mima" :readonly="ro.mima" autocomplete="off" placeholder="密码"  type="password"  />
					</el-form-item>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('mima')?'required':''">确认密码：</div>
						<el-input  v-model="ruleForm.mima2" autocomplete="off" placeholder="确认密码" type="password" :readonly="ro.mima" />
					</el-form-item>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('touxiang')?'required':''">头像：</div>
						<file-upload
							tip="点击上传头像"
							action="file/upload"
							:limit="3"
							:multiple="true"
							:fileUrls="ruleForm.touxiang?ruleForm.touxiang:''"
							@change="yonghutouxiangUploadChange"
						></file-upload>
					</el-form-item>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('xingbie')?'required':''">性别：</div>
						<el-select filterable v-model="ruleForm.xingbie" placeholder="请选择性别" :disabled="ro.xingbie">
							<el-option
								v-for="(item,index) in yonghuxingbieOptions"
								v-bind:key="index"
								:label="item"
								:value="item">
							</el-option>
						</el-select>
					</el-form-item>
					<el-form-item class="list-item" v-if="tableName=='yonghu'">
						<div class="lable" :class="changeRules('lianxifangshi')?'required':''">联系方式：</div>
						<el-input  v-model="ruleForm.lianxifangshi" :readonly="ro.lianxifangshi" autocomplete="off" placeholder="联系方式"  type="text"  />
					</el-form-item>
					<div class="register-btn">
						<div class="register-btn1">
							<button type="button" class="r-btn" @click="login()">注册</button>
						</div>
						<div class="register-btn2">
							<div class="r-login" @click="close()">取消</div>
						</div>
					</div>
				</div>
			</el-form>
		</div>
	</div>
</template>

<script>
	import 'animate.css'
export default {
	data() {
		return {
			ruleForm: {
			},
			forgetForm: {},
            pageFlag : '',
			tableName:"",
			rules: {},
			ro: {},
            yonghuxingbieOptions: [],
			indexBgUrl: '',
		};
	},
	mounted(){
		this.pageFlag = this.$route.query.pageFlag
		if(this.$route.query.pageFlag=='register'){
			
			let table = this.$storage.get("loginTable");
			this.tableName = table;
			if(this.tableName=='yonghu'){
				this.ruleForm = {
					yonghuzhanghao: '',
					yonghuxingming: '',
					mima: '',
					touxiang: '',
					xingbie: '',
					lianxifangshi: '',
					sfsh: '',
					shhf: '',
					money: '',
				}
				this.ro = {
					yonghuzhanghao: false,
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
			if ('yonghu' == this.tableName) {
				this.rules.yonghuzhanghao = [{ required: true, message: '请输入用户账号', trigger: 'blur' }]
			}
			if ('yonghu' == this.tableName) {
				this.rules.yonghuxingming = [{ required: true, message: '请输入用户姓名', trigger: 'blur' }]
			}
			if ('yonghu' == this.tableName) {
				this.rules.mima = [{ required: true, message: '请输入密码', trigger: 'blur' }]
			}
			this.yonghuxingbieOptions = "男,女".split(',')
		}
	},
	created() {
		this.$http.get('config/info?name=bRegisterBackgroundImg',).then(rs=>{this.indexBgUrl = rs.data.data?rs.data.data.value:''})
	},
	destroyed() {
		  	},
	methods: {
		changeRules(name){
			if(this.rules[name]){
				return true
			}
			return false
		},
		// 获取uuid
		getUUID () {
			return new Date().getTime();
		},
		close(){
			this.$router.push({ path: "/login" });
		},
        yonghutouxiangUploadChange(fileUrls) {
            this.ruleForm.touxiang = fileUrls;
        },

        // 多级联动参数


		// 注册
		login() {
			var url=this.tableName+"/register";
			  if(this.tableName=='yonghu'){
				  this.ruleForm.sfsh = '待审核'
			  }
			if((!this.ruleForm.yonghuzhanghao) && `yonghu` == this.tableName){
				this.$message.error(`用户账号不能为空`);
				return
			}
			if((!this.ruleForm.yonghuxingming) && `yonghu` == this.tableName){
				this.$message.error(`用户姓名不能为空`);
				return
			}
			if((!this.ruleForm.mima) && `yonghu` == this.tableName){
				this.$message.error(`密码不能为空`);
				return
			}
			if((this.ruleForm.mima!=this.ruleForm.mima2) && `yonghu` == this.tableName){
				this.$message.error(`两次密码输入不一致`);
				return
			}
            if(this.ruleForm.touxiang!=null) {
                this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url,"g"),"");
            }
			this.$http({
				url: url,
				method: "post",
				data:this.ruleForm
			}).then(({ data }) => {
				if (data && data.code === 0) {
					this.$message({
						message: "注册成功",
						type: "success",
						duration: 1500,
						onClose: () => {
							this.$router.replace({ path: "/login" });
						}
					});
				} else {
					this.$message.error(data.msg);
				}
			});
		},
	}
};
</script>

<style lang="scss" scoped>
.register-container {
	position: relative;
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
	.rgs-form {
		.rgs-form2 {
		border-radius: 24px 24px 24px 24px;
		padding: 20px 60px ;
		margin: 30px 60px;
		background:  linear-gradient( 180deg, #FFFFFF 0%, #FBFBFB 24%, #ECECEC 62%, #B8B8B8 100%);
		display: flex;
		width: 736px;
		position: relative;
		flex-wrap: wrap;
		}
		margin: 20px auto;
		background: url(http://codegen.caihongy.cn/20250811/5278ce06cfaa4968ac2cccf9f4887350.png) no-repeat center center / 100% 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		.title {
			margin: 0px 0 10px 30px;
			text-shadow: none;
			color: #000000;
			background: none;
			font-weight: 400;
			width: 100%;
			font-size: 24px;
			line-height: 44px;
		}
		.list-item {
			border-radius: 0px;
			padding: 0 0 0 130px;
			margin: 0 0 24px;
			background: none;
			width: 100%;
			position: relative;
			height: auto;
			/deep/ .el-form-item__content {
				display: block;
			}
			.lable {
				padding: 0 10px 0 0;
				color: #333333;
				white-space: nowrap;
				left: -180px;
				width: 180px;
				font-size: 22px;
				line-height: 50px;
				position: absolute !important;
				text-align: right;
				height: 63px;
			}
			.el-input {
				width: 100%;
			}
			.el-input /deep/ .el-input__inner {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 10px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				height: 50px;
			}
			.el-input /deep/ .el-input__inner:focus {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 10px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.el-input-number {
				width: 100%;
			}
			.el-input-number /deep/ .el-input__inner {
				text-align: center;
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 10px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				height: 50px;
			}
			.el-input-number /deep/ .el-input__inner:focus {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 10px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.el-input-number /deep/ .el-input-number__decrease {
				display: none;
			}
			.el-input-number /deep/ .el-input-number__increase {
				display: none;
			}
			.el-select {
				width: 100%;
			}
			.el-select /deep/ .el-input__inner {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 10px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.el-select /deep/ .el-input__inner:focus {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 10px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.el-date-editor {
				width: 100%;
			}
			.el-date-editor /deep/ .el-input__inner {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 30px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.el-date-editor /deep/ .el-input__inner:focus {
				border: 1px solid #DADFE6;
				border-radius: 4px  4px  4px  4px;
				padding: 0 30px;
				color: #333;
				background: #fff;
				width: 100%;
				font-size: 16px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				border-style: solid;
				height: 50px;
			}
			.el-date-editor.el-input {
				width: 100%;
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
				border: 1px solid #DADFE6;
				cursor: pointer;
				border-radius: 4px;
				margin: 0px 0 0;
				color: #999;
				background: #fff;
				width: 90px;
				font-size: 26px;
				line-height: 60px;
				text-align: center;
				height: 60px;
			}
			/deep/ .el-upload-list .el-upload-list__item {
				border: 1px solid #DADFE6;
				cursor: pointer;
				border-radius: 4px;
				margin: 0px 0 0;
				color: #999;
				background: #fff;
				width: 90px;
				font-size: 26px;
				line-height: 60px;
				text-align: center;
				height: 60px;
			}
			/deep/ .el-upload .el-icon-plus {
				border: 1px solid #DADFE6;
				cursor: pointer;
				border-radius: 4px;
				margin: 0px 0 0;
				color: #999;
				background: #fff;
				width: 90px;
				font-size: 26px;
				line-height: 60px;
				text-align: center;
				height: 60px;
			}
			/deep/ .el-upload__tip {
				margin: 0;
				color: #666;
				font-size: 16px;
			}
			/deep/ .el-input__inner::placeholder {
				color: #666;
				font-size: 16px;
			}
			.required {
				position: relative;
			}
			.required::after{
				color: red;
				left: 165px;
				position: absolute;
				content: "*";
			}
			.editor {
				border: 1px solid #DADFE6;
				border-radius: 4px;
				background: #fff;
				width: 100%;
				height: auto;
			}
			.editor>.avatar-uploader {
				line-height: 0;
				height: 0;
			}
		}
		.list-item.email {
			input {
				border: 1px solid #DADFE6;
				border-radius: 4px  0px  0px  4px;
				padding: 0 10px;
				color: #333;
				flex: 1;
				background: #fff;
				width: 100%;
				font-size: 16px;
				line-height: 64px;
				height: 64px;
			}
			input:focus {
				border: 1px solid #DADFE6;
				border-radius: 0px;
				padding: 0 10px;
				color: #333;
				flex: 1;
				background: none;
				width: 100%;
				font-size: 16px;
				line-height: 64px;
				height: 64px;
			}
			input::placeholder {
				color: #666;
				font-size: 16px;
			}
			button {
				cursor: pointer;
				border-radius: 4px  4px  4px  4px;
				color: #fff;
				background: linear-gradient( 180deg, #0098EF 0%, #0075B8 100%);
				display: flex;
				width: 220px;
				border-color: #d1d1d1;
				border-width: 0 0 0px;
				justify-content: center;
				align-items: center;
				border-style: solid;
				height: 64px;
			}
			button:hover {
				border-color: #d1d1d1;
				opacity: 0.8;
			}
		}
		.register-btn {
			display: flex;
			width: 100%;
			justify-content: center;
		}
		.register-btn1 {
			padding: 0;
			width: 154px;
		}
		.register-btn2 {
			margin: 0 0 0 20px;
			z-index: 1;
			text-align: right;
		}
		.r-btn {
			border: 0;
			cursor: pointer;
			border-radius: 8px  ;
			padding: 0 24px;
			box-shadow: inset 0px 3px 6px 1px #9ADAFF;
			margin: 10px 0;
			outline: none;
			color: #fff;
			background: linear-gradient( 180deg, #0098EF 0%, #0075B8 100%);
			width: 100%;
			font-size: 22px;
			height: 53px;
		}
		.r-btn:hover {
			opacity: 0.5;
		}
		.r-login {
			border: 0;
			cursor: pointer;
			padding: 0 24px;
			margin: 10px 0;
			color: #fff;
			font-size: 22px;
			line-height: 53px;
			border-radius: 8px  ;
			box-shadow: inset 0px 3px 6px 1px #9ADAFF;
			outline: none;
			background: linear-gradient( 180deg, #0098EF 0%, #0075B8 100%);
			width: 154px;
			text-align: center;
			height: 53px;
		}
		.r-login:hover {
			opacity: 0.8;
		}
	}
}
	
	::-webkit-scrollbar {
	  display: none;
	}
</style>
