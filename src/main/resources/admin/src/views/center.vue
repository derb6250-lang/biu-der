<template>
	<div :style='{"padding":"50px 30px 30px"}'>
		<el-form
			:style='{"border":" 1px solid #EFEFEF","padding":"104px 0","boxShadow":"4px 3px 10px 1px rgba(226,226,226,0.44)","borderRadius":"10px","flexWrap":"wrap","background":"#fff","display":"flex","justifyContent":"center"}'
			class="add-update-preview"
			ref="ruleForm"
			:model="ruleForm"
			label-width="180px"
		>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}'   v-if="flag=='yonghu'"  label="用户账号" prop="yonghuzhanghao">
					<el-input v-model="ruleForm.yonghuzhanghao" :readonly="ro.yonghuzhanghao" placeholder="用户账号" clearable></el-input>
				</el-form-item>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}'   v-if="flag=='yonghu'"  label="用户姓名" prop="yonghuxingming">
					<el-input v-model="ruleForm.yonghuxingming" :readonly="ro.yonghuxingming" placeholder="用户姓名" clearable></el-input>
				</el-form-item>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' v-if="flag=='yonghu'" label="头像" prop="touxiang">
					<file-upload
						tip="点击上传头像"
						action="file/upload"
						:limit="1"
						:multiple="false"
						:fileUrls="ruleForm.touxiang?ruleForm.touxiang:''"
						@change="yonghutouxiangUploadChange"
					></file-upload>
				</el-form-item>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' v-if="flag=='yonghu'"  label="性别" prop="xingbie">
					<el-select filterable v-model="ruleForm.xingbie" :disabled="ro.xingbie" placeholder="请选择性别">
						<el-option
							v-for="(item,index) in yonghuxingbieOptions"
							v-bind:key="index"
							:label="item"
							:value="item">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}'   v-if="flag=='yonghu'"  label="联系方式" prop="lianxifangshi">
					<el-input v-model="ruleForm.lianxifangshi" :readonly="ro.lianxifangshi" placeholder="联系方式" clearable></el-input>
				</el-form-item>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' v-if="flag=='users'" label="用户名" prop="username">
					<el-input v-model="ruleForm.username" placeholder="用户名"></el-input>
				</el-form-item>
				<el-form-item :style='{"padding":"0 ","margin":"15px 0 15px 180px","alignItems":"center","flexWrap":"wrap","display":"flex","width":"1005px","position":"relative","justifyContent":"center"}' v-if="flag=='users'" label="头像" prop="image">
					<file-upload
						tip="点击上传头像"
						action="file/upload"
						:limit="1"
						:multiple="false"
						:fileUrls="ruleForm.image?ruleForm.image:''"
						@change="usersimageUploadChange"
					></file-upload>
				</el-form-item>
				<el-form-item :style='{"width":"1005px","padding":"0","flexWrap":"wrap","justifyContent":"center","display":"flex"}'>
					<el-button class="btn3" type="primary" @click="onUpdateHandler">
						<span class="icon iconfont icon-queren15"></span>
						提交
					</el-button>
				</el-form-item>
		</el-form>
	</div>
</template>
<script>
// 校验引入
	import { 
		isNumber,
	} from "@/utils/validate";

	export default {
		data() {
			return {
				ruleForm: {},
				flag: '',
				usersFlag: false,
				yonghuxingbieOptions: [],
			};
		},
		mounted() {
			var table = this.$storage.get("sessionTable");
			this.flag = table;
			this.$http({
				url: `${this.$storage.get("sessionTable")}/session`,
				method: "get"
			}).then(({ data }) => {
				if (data && data.code === 0) {
					if(table == 'yonghu') {
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

					this.ruleForm = data.data;
				} else {
					this.$message.error(data.msg);
				}
			});
			this.yonghuxingbieOptions = "男,女".split(',')
		},
		methods: {
			yonghutouxiangUploadChange(fileUrls) {
				this.ruleForm.touxiang = fileUrls;
			},
			usersimageUploadChange(fileUrls) {
				this.ruleForm.image = fileUrls;
			},
			onUpdateHandler() {
				if((!this.ruleForm.yonghuzhanghao)&& 'yonghu'==this.flag){
					this.$message.error('用户账号不能为空');
					return
				}
				if((!this.ruleForm.yonghuxingming)&& 'yonghu'==this.flag){
					this.$message.error('用户姓名不能为空');
					return
				}
				if((!this.ruleForm.mima)&& 'yonghu'==this.flag){
					this.$message.error('密码不能为空');
					return
				}
				if(this.ruleForm.touxiang!=null) {
					this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url,"g"),"");
				}
				if('yonghu' ==this.flag && this.ruleForm.money&&(!isNumber(this.ruleForm.money))){
					this.$message.error(`余额应输入数字`);
					return
				}
				if('users'==this.flag && this.ruleForm.username.trim().length<1) {
					this.$message.error(`用户名不能为空`);
					return	
				}
				if(this.flag=='users'){
					this.ruleForm.image = this.ruleForm.image.replace(new RegExp(this.$base.url,"g"),"")
				}
				this.$http({
					url: `${this.$storage.get("sessionTable")}/update`,
					method: "post",
					data: this.ruleForm
				}).then(({ data }) => {
					if (data && data.code === 0) {
						if(this.flag=='users'){
							this.$storage.set('headportrait',this.ruleForm.image)
						}else {
							if(this.flag == 'yonghu') {
								this.$storage.set('headportrait',this.ruleForm.touxiang)
							}
						}
						this.$message({
							message: "修改信息成功",
							type: "success",
							duration: 1500,
							onClose: () => {
								window.location.reload();
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
				.iconfont {
						margin: 0 2px;
						color: #fff;
						display: none;
						font-size: 16px;
						height: 40px;
					}
	}
	
	.add-update-preview .btn3:hover {
				opacity: 0.8;
			}
	.editor>.avatar-uploader {
		line-height: 0;
		height: 0;
	}
</style>
