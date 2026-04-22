




<template>
	<div class="addEdit-block">
		<el-form
			class="add-update-preview"
			ref="ruleForm"
			:model="ruleForm"
			:rules="rules"
			label-width="180px"
		>
			<template >
				<el-form-item class="input" v-if="type!='info'"  label="用户ID" prop="uid" >
					<el-input v-model="ruleForm.uid" placeholder="用户ID" clearable  :readonly="ro.uid"></el-input>
				</el-form-item>
				<el-form-item v-else class="input" label="用户ID" prop="uid" >
					<el-input v-model="ruleForm.uid" placeholder="用户ID" readonly></el-input>
				</el-form-item>
				<el-form-item class="input" v-if="type!='info'"  label="好友用户ID" prop="fid" >
					<el-input v-model="ruleForm.fid" placeholder="好友用户ID" clearable  :readonly="ro.fid"></el-input>
				</el-form-item>
				<el-form-item v-else class="input" label="好友用户ID" prop="fid" >
					<el-input v-model="ruleForm.fid" placeholder="好友用户ID" readonly></el-input>
				</el-form-item>
				<el-form-item class="input" v-if="type!='info'"  label="内容" prop="content" >
					<el-input v-model="ruleForm.content" placeholder="内容" clearable  :readonly="ro.content"></el-input>
				</el-form-item>
				<el-form-item v-else class="input" label="内容" prop="content" >
					<el-input v-model="ruleForm.content" placeholder="内容" readonly></el-input>
				</el-form-item>
				<el-form-item class="input" v-if="type!='info'"  label="格式(1:文字，2:图片)" prop="format" >
					<el-input v-model.number="ruleForm.format" placeholder="格式(1:文字，2:图片)" clearable  :readonly="ro.format"></el-input>
				</el-form-item>
				<el-form-item v-else class="input" label="格式(1:文字，2:图片)" prop="format" >
					<el-input v-model="ruleForm.format" placeholder="格式(1:文字，2:图片)" readonly></el-input>
				</el-form-item>
				<el-form-item class="input" v-if="type!='info'"  label="消息已读(0:未读，1:已读)" prop="isread" >
					<el-input v-model.number="ruleForm.isread" placeholder="消息已读(0:未读，1:已读)" clearable  :readonly="ro.isread"></el-input>
				</el-form-item>
				<el-form-item v-else class="input" label="消息已读(0:未读，1:已读)" prop="isread" >
					<el-input v-model="ruleForm.isread" placeholder="消息已读(0:未读，1:已读)" readonly></el-input>
				</el-form-item>
			</template>
			<el-form-item class="btn">
				<el-button class="btn3"  v-if="type!='info'" type="success" @click="onSubmit">
					<span class="icon iconfont icon-queren15"></span>
					提交
				</el-button>
				<el-button class="btn4" v-if="type!='info'" type="success" @click="back()">
					<span class="icon iconfont icon-guanbi2"></span>
					取消
				</el-button>
				<el-button class="btn5" v-if="type=='info'" type="success" @click="back()">
					<span class="icon iconfont icon-fanhui13"></span>
					返回
				</el-button>
			</el-form-item>
		</el-form>
    

	</div>
</template>
<script>
	import { 
		isIntNumer,
	} from "@/utils/validate";
	export default {
		data() {
			var validateIntNumber = (rule, value, callback) => {
				if(!value){
					callback();
				} else if (!isIntNumer(value)) {
					callback(new Error("请输入整数"));
				} else {
					callback();
				}
			};
			return {
				id: '',
				type: '',
			
			
				ro:{
					uid : false,
					fid : false,
					content : false,
					format : false,
					isread : false,
				},
			
				ruleForm: {
					uid: '',
					fid: '',
					content: '',
					format: '',
				},

				rules: {
					uid: [
						{ required: true, message: '用户ID不能为空', trigger: 'blur' },
					],
					fid: [
						{ required: true, message: '好友用户ID不能为空', trigger: 'blur' },
					],
					content: [
					],
					format: [
						{ validator: validateIntNumber, trigger: 'blur' },
					],
					isread: [
						{ validator: validateIntNumber, trigger: 'blur' },
					],
				},
			};
		},
		props: ["parent"],
		computed: {
			sessionForm() {
				return JSON.parse(this.$storage.getObj('userForm'))
			},
			sessionTable() {
				return this.$storage.get('sessionTable')
			},



		},
		components: {
		},
		created() {
		},
		methods: {
			// 下载
			download(file){
				window.open(`${file}`)
			},
			// 初始化
			init(id,type ) {
				if (id) {
					this.id = id;
					this.type = type;
				}
				if(this.type=='info'||this.type=='else'||this.type=='msg'){
					this.info(id);
				}else if(this.type=='logistics'){
					for(let x in this.ro) {
						this.ro[x] = true
					}
					this.logistics=false;
					this.info(id);
				}else if(this.type=='cross'){
					var obj = this.$storage.getObj('crossObj');
					for (var o in obj){
						if(o=='uid'){
							this.ruleForm.uid = obj[o];
							this.ro.uid = true;
							continue;
						}
						if(o=='fid'){
							this.ruleForm.fid = obj[o];
							this.ro.fid = true;
							continue;
						}
						if(o=='content'){
							this.ruleForm.content = obj[o];
							this.ro.content = true;
							continue;
						}
						if(o=='format'){
							this.ruleForm.format = obj[o];
							this.ro.format = true;
							continue;
						}
						if(o=='isread'){
							this.ruleForm.isread = obj[o];
							this.ro.isread = true;
							continue;
						}
					}
				}
			
			},
			// 多级联动参数

			info(id) {
				this.$http({
					url: `chatmessage/info/${id}`,
					method: "get"
				}).then(({ data }) => {
					if (data && data.code === 0) {
						this.ruleForm = data.data;
						//解决前台上传图片后台不显示的问题
						let reg=new RegExp('../../../upload','g')//g代表全部
					} else {
						this.$message.error(data.msg);
					}
				});
			},

			// 提交
			async onSubmit() {
					var objcross = this.$storage.getObj('crossObj');
					if(!this.ruleForm.id) {
						delete this.ruleForm.userid
					}
					await this.$refs["ruleForm"].validate(async valid => {
						if (valid) {
							if(this.type=='cross'){
								var statusColumnName = this.$storage.get('statusColumnName');
								var statusColumnValue = this.$storage.get('statusColumnValue');
								if(statusColumnName!='') {
									var obj = this.$storage.getObj('crossObj');
									if(statusColumnName && !statusColumnName.startsWith("[")) {
										for (var o in obj){
											if(o==statusColumnName){
												obj[o] = statusColumnValue;
											}
										}
										var table = this.$storage.get('crossTable');
										await this.$http({
											url: `${table}/update`,
											method: "post",
											data: obj
										}).then(({ data }) => {});
									}
								}
							}
							await this.$http({
								url: `chatmessage/${!this.ruleForm.id ? "save" : "update"}`,
								method: "post",
								data: this.ruleForm
							}).then(async ({ data }) => {
								if (data && data.code === 0) {
									this.$message({
										message: "操作成功",
										type: "success",
										duration: 1500,
										onClose: () => {
											this.parent.showFlag = true;
											this.parent.addOrUpdateFlag = false;
											this.parent.chatmessageCrossAddOrUpdateFlag = false;
											this.parent.search();
										}
									});
								} else {
									this.$message.error(data.msg);
								}
							});
						}
					});
			},
			// 获取uuid
			getUUID () {
				return new Date().getTime();
			},
			// 返回
			back() {
				this.parent.showFlag = true;
				this.parent.addOrUpdateFlag = false;
				this.parent.chatmessageCrossAddOrUpdateFlag = false;
			},
		}
	};
</script>
<style lang="scss" scoped>
	.addEdit-block {
		padding: 30px;
	}
	.add-update-preview {
		border:  1px solid #EFEFEF;
		border-radius: 10px;
		padding: 104px 0;
		box-shadow: 4px 3px 10px 1px rgba(226,226,226,0.44);
		background: #fff;
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
	}
	.amap-wrapper {
		width: 100%;
		height: 500px;
	}
	
	.search-box {
		position: absolute;
	}
	
	.el-date-editor.el-input {
		width: auto;
	}
	.add-update-preview /deep/ .el-form-item {
		padding: 0 ;
		margin: 15px 0 15px 180px;
		display: flex;
		width: 1005px;
		justify-content: center;
		align-items: center;
		position: relative;
		flex-wrap: wrap;
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
	.add-update-preview /deep/ .el-form-item.editorBox {
		padding: 0 ;
		margin: 15px 0 15px 180px;
		display: flex;
		width: 1005px;
		justify-content: flex-start;
		align-items: center;
		position: relative;
		flex-wrap: wrap;
	}
	.add-update-preview .el-form-item.editorBox /deep/ .el-form-item__label {
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
	
	.add-update-preview .el-form-item.editorBox /deep/ .el-form-item__content {
		margin-left: auto !important;
		margin: auto !important;
		width: auto !important;
	}
	.add-update-preview /deep/.el-form-item.editorBox .editor {
		border:  1px solid #DADFE6;
		box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		max-width: 100% !important;
		background: #fff;
		width: 875px;
		height: auto;
	}
	.add-update-preview /deep/.el-form-item.editorBox .editor .ql-toolbar {
		border: 1px solid #eee;
		background: none;
		border-width: 1px 1px 0;
	}
	.add-update-preview /deep/.el-form-item.editorBox .editor .ql-container {
		border: 1px solid #eee;
		background: none;
		min-height: 200px;
	}
	.add-update-preview /deep/.el-form-item.editorBox .editor .ql-container .ql-blank::before {
		color: #000;
	}
	
	.add-update-preview /deep/ .el-form-item.textBox {
		padding: 0 ;
		margin: 15px 0 15px 180px;
		display: flex;
		width: 1005px;
		justify-content: flex-start;
		align-items: center;
		position: relative;
		flex-wrap: wrap;
	}
	.add-update-preview .el-form-item.textBox /deep/ .el-form-item__label {
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
	
	.add-update-preview .el-form-item.textBox /deep/ .el-form-item__content {
		margin-left: auto !important;
		margin: auto !important;
		display: flex;
		width: 100%;
		justify-content: flex-start;
		align-items: flex-start;
		flex-wrap: wrap;
	}
	.add-update-preview /deep/.el-form-item.textBox span.text {
		display: inline-block;
		font-size: 16px;
	}
	
	.add-update-preview .el-input {
		flex: 1;
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
	.add-update-preview .el-input /deep/ .el-input__inner[readonly="readonly"] {
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
	.add-update-preview .el-input-number {
		text-align: left;
		flex: 1;
	}
	.add-update-preview .el-input-number /deep/ .el-input__inner {
		text-align: left;
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
	.add-update-preview .el-input-number /deep/ .is-disabled .el-input__inner {
		text-align: left;
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
	.add-update-preview .el-input-number /deep/ .el-input-number__decrease {
		display: none;
	}
	.add-update-preview .el-input-number /deep/ .el-input-number__increase {
		display: none;
	}
	.add-update-preview .el-select {
		width: auto;
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
	.add-update-preview .el-select /deep/ .is-disabled .el-input__inner {
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
	.add-update-preview .el-date-editor {
		width: auto;
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
	.add-update-preview .el-date-editor /deep/ .el-input__inner[readonly="readonly"] {
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
	.add-update-preview .viewBtn {
		border-radius: 0;
		padding: 0 12px;
		box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		outline: none;
		color: #0098EF;
		background: linear-gradient( 180deg, #FFFFFF 0%, #FBFBFB 24%, #ECECEC 62%, #B8B8B8 100%);
		width: 875px;
		font-size: 16px;
		border-color: #e8e9eb;
		border-width: 1px;
		border-style: solid;
		height: 64px;
		.iconfont {
			margin: 0 2px;
			color: #fff;
			display: none;
			font-size: 14px;
			height: 40px;
		}
	}
	.add-update-preview .viewBtn:hover {
		opacity: 0.8;
	}
	.add-update-preview .downBtn {
		border-radius: 0;
		padding: 0 12px;
		box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		outline: none;
		color: #0098EF;
		background: linear-gradient( 180deg, #FFFFFF 0%, #FBFBFB 24%, #ECECEC 62%, #B8B8B8 100%);
		width: 875px;
		font-size: 16px;
		border-color: #e8e9eb;
		border-width: 1px;
		border-style: solid;
		height: 64px;
		.iconfont {
			margin: 0 2px;
			color: #fff;
			display: none;
			font-size: 14px;
			height: 40px;
		}
	}
	.add-update-preview .downBtn:hover {
		opacity: 0.8;
	}
	.add-update-preview .unBtn {
		border-radius: 0;
		padding: 0 12px;
		box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		outline: none;
		color: #0098EF;
		background: linear-gradient( 180deg, #FFFFFF 0%, #FBFBFB 24%, #ECECEC 62%, #B8B8B8 100%);
		width: 875px;
		font-size: 16px;
		border-color: #e8e9eb;
		border-width: 1px;
		border-style: solid;
		height: 64px;
		.iconfont {
			margin: 0 2px;
			color: #fff;
			display: none;
			font-size: 14px;
			height: 40px;
		}
	}
	.add-update-preview .unBtn:hover {
		opacity: 0.8;
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
	
	.add-update-preview /deep/ .upload .upload-img {
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
	.add-update-preview /deep/ .el-upload__tip {
		padding: 0 10px;
		color: #333;
		font-size: 15px;
	}
	.add-update-preview /deep/ .el-form-item.fileupload {
		padding: 0 ;
		margin: 15px 0 15px 180px;
		display: flex;
		width: 1005px;
		justify-content: flex-start;
		align-items: center;
		position: relative;
		flex-wrap: wrap;
	}
	.add-update-preview .el-form-item.fileupload /deep/ .el-form-item__label {
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
	
	.add-update-preview .el-form-item.fileupload /deep/ .el-form-item__content {
		margin-left: auto !important;
		margin: auto !important;
		display: flex;
		width: 100%;
		justify-content: flex-start;
		align-items: flex-start;
		flex-wrap: wrap;
	}
	.add-update-preview .el-form-item.fileupload /deep/ .el-upload-dragger {
		border-radius: 0;
		padding: 10px 12px;
		box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
		outline: none;
		color: #333;
		background: #fafafa;
		width: 875px;
		font-size: 24px;
		border-color: #e8e9eb;
		border-width: 1px;
		border-style: solid;
		height: auto;
	}
	.add-update-preview .el-form-item.fileupload .el-upload-dragger /deep/ .el-icon-upload {
		margin: 0;
		color: #206cb480;
		font-size: 66px;
		line-height: 1;
	}
	.add-update-preview .el-form-item.fileupload .el-upload-dragger /deep/ .el-upload__text {
		color: #606266;
		textalign: center;
		fontsize: 14px;
		line-height: 1;
	}
	.add-update-preview .el-form-item.fileupload .el-upload-dragger /deep/ .el-upload__text em {
		fontstyle: normal;
		color: #409EFF;
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
	.add-update-preview .el-textarea /deep/ .el-textarea__inner[readonly="readonly"] {
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
	.add-update-preview /deep/ .el-form-item.btn {
		padding: 0;
		display: flex;
		width: 1005px;
		justify-content: center;
		flex-wrap: wrap;
		.btn1 {
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
		.btn1:hover {
			opacity: 0.8;
		}
		.btn2 {
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
		.btn2:hover {
			opacity: 0.8;
		}
		.btn3 {
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
		.btn3:hover {
			opacity: 0.8;
		}
		.btn4 {
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
		.btn4:hover {
			opacity: 0.8;
		}
		.btn5 {
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
		.btn5:hover {
			opacity: 0.8;
		}
	}
	.add-update-preview .el-form-item.btn /deep/ .el-form-item__label {
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
	
	.add-update-preview .el-form-item.btn /deep/ .el-form-item__content {
		margin-left: auto !important;
		margin: auto !important;
		display: flex;
		width: 100%;
		justify-content: flex-start;
		align-items: flex-start;
		flex-wrap: wrap;
	}
</style>
