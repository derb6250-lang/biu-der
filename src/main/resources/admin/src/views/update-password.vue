<template>
	<div :style='{"padding":"30px"}'>
		<el-form
			v-if="showType==1"
			:style='{"border":" 1px solid #EFEFEF","padding":"104px 0","boxShadow":"4px 3px 10px 1px rgba(226,226,226,0.44)","borderRadius":"10px","flexWrap":"wrap","background":"#fff","display":"flex","justifyContent":"center"}'
			class="add-update-preview"
			ref="ruleForm"
			:rules="rules"
			:model="ruleForm"
			label-width="180px"
		>
			<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' label="原密码" prop="password">
				<el-input type="password" v-model="ruleForm.password" ></el-input>
			</el-form-item>
			<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' label="新密码" prop="newpassword">
				<el-input type="password" v-model="ruleForm.newpassword" ></el-input>
			</el-form-item>
			<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' label="确认密码" prop="repassword">
				<el-input type="password" v-model="ruleForm.repassword" ></el-input>
			</el-form-item>
			<el-form-item :style='{"width":"1005px","padding":"0","flexWrap":"wrap","justifyContent":"center","display":"flex"}'>
				<el-button class="btn3" :style='{"cursor":"pointer","padding":"0 24px","boxShadow":"inset 0px 3px 6px 1px #9ADAFF","margin":"4px","color":"#FFFFFF","minWidth":"154px","outline":"none","borderRadius":"8px  ","background":" linear-gradient( 180deg, #0098EF 0%, #0075B8 100%)","borderWidth":"0","width":"auto","fontSize":"22px","height":"53px"}' type="primary" @click="onUpdateHandler">
					<span class="icon iconfont icon-queren15" :style='{"margin":"0 2px","fontSize":"16px","color":"#fff","display":"none","height":"40px"}'></span>
					提交
				</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
export default {
	data() {
		return {
			dialogVisible: false,
			ruleForm: {},
			payForm: {},
			user: {},
			rules: {
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
			rules2: {
				password: [
					{
						required: true,
						message: "支付密码不能为空",
						trigger: "blur"
					}
				],
				newpassword: [
					{
						required: true,
						message: "新支付密码不能为空",
						trigger: "blur"
					}
				],
				repassword: [
					{
						required: true,
						message: "确认支付密码不能为空",
						trigger: "blur"
					}
				]
			},
			showType: '1'
		};
	},
	mounted() {
		this.$http({
			url: `${this.$storage.get("sessionTable")}/session`,
			method: "get"
		}).then(({ data }) => {
			if (data && data.code === 0) {
				this.user = data.data;
			} else {
				this.$message.error(data.msg);
			}
		});
	},
	methods: {
		onLogout() {
			this.$storage.remove("Token");
			this.$router.replace({ name: "login" });
		},
		// 修改密码
		async onUpdateHandler() {
			this.$refs["ruleForm"].validate(async valid => {
				if (valid) {
					var password = "";
					if (this.user.mima) {
						password = this.user.mima;
					} else if (this.user.password) {
						password = this.user.password;
					}
					if(this.$storage.get("sessionTable")=='users'){
						if (this.ruleForm.password != password) {
							this.$message.error("原密码错误");
							return;
						}
						if (this.ruleForm.newpassword != this.ruleForm.repassword) {
							this.$message.error("两次密码输入不一致");
							return;
						}
						this.user.password = this.ruleForm.newpassword;
						this.user.mima = this.ruleForm.newpassword;
						this.$http({
							url: `${this.$storage.get("sessionTable")}/update`,
							method: "post",
							data: this.user
						}).then(({ data }) => {
							if (data && data.code === 0) {
								this.$message({
									message: "修改密码成功,下次登录系统生效",
									type: "success",
									duration: 1500,
									onClose: () => {
									}
								});
							} else {
								this.$message.error(data.msg);
							}
						});
						return false
					}
					if (this.ruleForm.password != password) {
						this.$message.error("原密码错误");
						return;
					}
					if (this.ruleForm.newpassword != this.ruleForm.repassword) {
						this.$message.error("两次密码输入不一致");
						return;
					}
					if (this.ruleForm.newpassword == this.ruleForm.password) {
						this.$message.error("新密码与原密码相同");
						return;
					}
					this.user.password = this.ruleForm.newpassword;
					this.user.mima = this.ruleForm.newpassword;
					this.$http({
						url: `${this.$storage.get("sessionTable")}/update`,
						method: "post",
						data: this.user
					}).then(({ data }) => {
						if (data && data.code === 0) {
							this.$message({
								message: "修改密码成功,下次登录系统生效",
								type: "success",
								duration: 1500,
								onClose: () => {
								}
							});
						} else {
							this.$message.error(data.msg);
						}
					});
				}
			});
		}
	}
};
</script>
<style lang="scss" scoped>
	.el-date-editor.el-input {
		width: auto;
	}
	
	.add-update-preview .el-form-item /deep/ .el-form-item__label {
	  	  padding: 0 10px;
	  	  color: #333333;
	  	  white-space: nowrap;
	  	  left: -180px;
	  	  background: none;
	  	  font-weight: 500;
	  	  width: 180px;
	  	  font-size: 16px;
	  	  line-height: 64px;
	  	  position: absolute;
	  	  text-align: right;
	  	}
	.add-update-preview .el-form-item /deep/ .el-form-item__content {
		margin-left: auto !important;
		margin: auto !important;
		display: flex;
		width: 100%;
		justify-content: flex-start;
		align-items: flex-start;
		flex-wrap: wrap;
	}
	
	.add-update-preview .el-input /deep/ .el-input__inner {
	  	  border-radius: 0;
	  	  padding: 0 12px;
	  	  box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
	  	  outline: none;
	  	  color: #333;
	  	  background: #fafafa;
	  	  width: 875px;
	  	  font-size: 16px;
	  	  border-color: #e8e9eb;
	  	  border-width: 1px;
	  	  border-style: solid;
	  	  height: 64px;
	  	}
	
	.add-update-preview .el-select /deep/ .el-input__inner {
	  	  border-radius: 0;
	  	  padding: 0 12px;
	  	  box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
	  	  outline: none;
	  	  color: #333;
	  	  background: #fafafa;
	  	  width: 875px;
	  	  font-size: 16px;
	  	  border-color: #e8e9eb;
	  	  border-width: 1px;
	  	  border-style: solid;
	  	  height: 64px;
	  	}
	
	.add-update-preview .el-date-editor /deep/ .el-input__inner {
	  	  border-radius: 0;
	  	  padding: 0 30px;
	  	  box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
	  	  outline: none;
	  	  color: #333;
	  	  background: #fafafa;
	  	  width: 875px;
	  	  font-size: 16px;
	  	  border-color: #e8e9eb;
	  	  border-width: 1px;
	  	  border-style: solid;
	  	  height: 64px;
	  	}
	
	.add-update-preview /deep/ .el-upload--picture-card {
		background: transparent;
		border: 0;
		border-radius: 0;
		width: auto;
		height: auto;
		line-height: initial;
		vertical-align: middle;
	}
	
	.add-update-preview /deep/ .el-upload-list .el-upload-list__item {
	  	  border: 1px solid #DADFE6;
	  	  cursor: pointer;
	  	  border-radius: 4px;
	  	  margin: 10px 0 0;
	  	  color: #999;
	  	  width: 90px;
	  	  font-size: 26px;
	  	  line-height: 60px;
	  	  text-align: center;
	  	  height: 60px;
	  	}
	
	.add-update-preview /deep/ .el-upload .el-icon-plus {
	  	  border: 1px solid #DADFE6;
	  	  cursor: pointer;
	  	  border-radius: 4px;
	  	  margin: 10px 0 0;
	  	  color: #999;
	  	  width: 90px;
	  	  font-size: 26px;
	  	  line-height: 60px;
	  	  text-align: center;
	  	  height: 60px;
	  	}
	
	.add-update-preview .el-textarea /deep/ .el-textarea__inner {
	  	  border-radius: 0;
	  	  padding: 0 12px;
	  	  box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
	  	  outline: none;
	  	  color: #333;
	  	  background: #fafafa;
	  	  width: 875px;
	  	  font-size: 16px;
	  	  border-color: #e8e9eb;
	  	  border-width: 1px;
	  	  border-style: solid;
	  	  height: auto;
	  	}
	
	.add-update-preview .btn3 {
				cursor: pointer;
				padding: 0 24px;
				margin: 4px;
				color: #FFFFFF;
				font-size: 22px;
				border-radius: 8px  ;
				box-shadow: inset 0px 3px 6px 1px #9ADAFF;
				outline: none;
				background:  linear-gradient( 180deg, #0098EF 0%, #0075B8 100%);
				width: auto;
				border-width: 0;
				min-width: 154px;
				height: 53px;
			}
	
	.add-update-preview .btn3:hover {
				opacity: 0.8;
			}
</style>
