<template>
	<div class="main-content" :style='{"padding":"50px 30px 30px"}'>
		<!-- 列表页 -->
		<div v-if="!showFlag" style="width: 100%;">
			<el-form :style='{"width":"100%","padding":"0","margin":"0 0 20px"}' :inline="true" :model="searchForm" class="center-form-pv">
				<el-row :style='{"padding":"20px 20px 10px","borderRadius":"8px  8px  8px  8px","flexWrap":"wrap","background":"#F5F5F5","display":"flex","width":"100%","position":"relative"}'>
					<div :style='{"margin":"0 1% 10px 0","display":"flex"}'>
						<label :style='{"margin":"0 10px 0 0","whiteSpace":"nowrap","color":"#666","display":"none","lineHeight":"40px","fontSize":"16px","fontWeight":"500","height":"40px"}' class="item-label">是否回复</label>
						<el-select v-model="searchForm.isreply" placeholder="请选择">
							<el-option label="已回复" :value="0"></el-option>
							<el-option label="未回复" :value="1"></el-option>
						</el-select>
					</div>
					<div :style='{"margin":"0 1% 10px 0","display":"flex"}'>
						<label :style='{"margin":"0 10px 0 0","whiteSpace":"nowrap","color":"#666","display":"none","lineHeight":"40px","fontSize":"16px","fontWeight":"500","height":"40px"}' class="item-label">是否已读</label>
						<el-select v-model="searchForm.isread" placeholder="请选择">
							<el-option label="已读" :value="1"></el-option>
							<el-option label="未读" :value="0"></el-option>
						</el-select>
					</div>
					<el-button class="search" :style='{"border":"1px solid #09A5FF","cursor":"pointer","padding":"0 12px 0 10px","boxShadow":" inset 0px 3px 6px 1px #9ADAFF","outline":"none","color":"#fff","borderRadius":"8px 8px 8px 8px","background":" linear-gradient( 180deg, #0098EF 0%, #0075B8 100%)","width":"122px","fontSize":"16px","height":"42px"}' type="success" @click="search()">
						<span class="icon iconfont icon-fangdajing01" :style='{"margin":"0 0px","fontSize":"16px","color":"#fff","height":"40px"}'></span>
						查询
					</el-button>
				</el-row>
			</el-form>
			<div>
				<el-table
					:stripe='false'
					:style='{"padding":"0","borderColor":"#EFEFEF","borderRadius":"10px","borderWidth":"0px 0 0 0px","background":"#fff","width":"100%","borderStyle":"solid"}'
					:data="dataList"
					:border='false'
					v-loading="dataListLoading"
					style="width: 100%;"
					>
					<el-table-column
						:resizable='true' :sortable='true'
						prop="allnode"
						header-align="center"
						align="center"
						sortable
						label="用户"
						>
						<template slot-scope="scope">
							<div style="display: flex;align-items: center;">
								<img :src="scope.row.uimage?$base.url + scope.row.uimage.split(',')[0]:require('@/assets/img/avator.png')" style="width: 80px;height: 80px;border-radius: 50%;margin: 0 5px 0 0;" alt="" />
								{{scope.row.uname}}
							</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="ask" :formatter="askFormat" header-align="center" align="center" sortable label="新消息"></el-table-column>
					<el-table-column
						:resizable='true' :sortable='true'
						prop="allnode"
						header-align="center"
						align="center"
						sortable
						label="是否回复"
						width="150"
						>
						<template slot-scope="scope">
							<el-tag v-if="scope.row.isreply==1" type="success">未回复</el-tag>
							<el-tag v-if="scope.row.isreply==0" type="info">已回复</el-tag>
						</template>
					</el-table-column>
					<el-table-column
						:resizable='true' :sortable='true'
						prop="allnode"
						header-align="center"
						align="center"
						sortable
						label="是否已读"
						width="150"
						>
						<template slot-scope="scope">
							<el-tag v-if="scope.row.isread==1" type="success">已读</el-tag>
							<el-tag v-if="scope.row.isread==0" type="info">未读</el-tag>
						</template>
					</el-table-column>
					<el-table-column
						header-align="center"
						align="center"
						width="150"
						label="操作"
						>
						<template slot-scope="scope">
							<el-button
								type="text"
								:style='{"border":"0px solid #22c08e","cursor":"pointer","padding":"0 10px","margin":"0 5px 5px 0","outline":"none","color":"#0098EF","borderRadius":"6px","background":"none","width":"auto","fontSize":"14px","height":"32px","order":"-1"}'
								size="small"
								@click="addOrUpdateHandler(scope.row)"
							>回复</el-button>
						</template>
					</el-table-column>
				</el-table>
			
				<el-pagination
					@size-change="sizeChangeHandle"
					@current-change="currentChangeHandle"
					:current-page="pageIndex"
					:page-sizes="[10, 50, 100, 200]"
					:page-size="pageSize"
					:total="totalPage"
					:layout="layouts.join()"
					prev-text="<"
					next-text=">"
					:hide-on-single-page="false"
					:style='{"padding":"0","margin":"20px 0 0","whiteSpace":"nowrap","color":"#333","display":"flex","width":"100%","fontWeight":"500","justifyContent":"center"}'
				></el-pagination>
			</div>
		</div>
		<!-- 添加/修改页面  将父组件的search方法传递给子组件-->
		<add-or-update v-else :parent="this" ref="addOrUpdate"></add-or-update>
	</div>
</template>
<script>
	import AddOrUpdate from "./chat-add-or-update";
	import { setInterval, clearInterval } from 'timers';
	export default {
		data() {
			return {
				layouts: ["total","prev","pager","next","sizes","jumper"],
				searchForm: {
					isreply:1,
					isread: 0
				},
				dataList: [],
				pageIndex: 1,
				pageSize: 10,
				totalPage: 0,
				dataListLoading: false,
				showFlag: false,
				dataListSelections: [],
				inter: null,
			};
		},
		created() {
			var that = this;
			that.getDataList();
			var inter = setInterval(function(){
				that.getDataList();
			},5000);
			this.inter = inter;
		},
		destroyed(){
			clearInterval(this.inter);
		},
		components: {
			AddOrUpdate
		},
		methods: {
			askFormat(row, column) {
				if (row.ask && row.type==2) {
					return '[图片]'
				} else if(row.ask&&row.type==3) {
					return '[视频]'
				} else if(row.ask&&row.type==4) {
					return '[文件]'
				} else {
					return row.ask
				}
			},
			search() {
				this.pageIndex = 1
				this.getDataList()
			},
			getDataList() {
				let params = {
					page: this.pageIndex,
					limit: this.pageSize,
					sort: 'id',
				}
				params.isreply = this.searchForm.isreply
				params.isread = this.searchForm.isread
				this.dataListLoading = true;
				this.$http({
					url: this.$api.chatpage,
					method: "get",
					params: params
				}).then(({ data }) => {
					if (data && data.code === 0) {
						this.dataList = data.data.list;
						this.totalPage = data.data.total;
					} else {
						this.dataList = [];
						this.totalPage = 0;
					}
					this.dataListLoading = false;
				});
			},
			// 每页数
			sizeChangeHandle(val) {
				this.pageSize = val;
				this.pageIndex = 1;
				this.getDataList();
			},
			// 当前页
			currentChangeHandle(val) {
				this.pageIndex = val;
				this.getDataList();
			},
			// 回复
			addOrUpdateHandler(row) {
				this.showFlag = true;
				this.$nextTick(() => {
					this.$refs.addOrUpdate.init(row.userid);
				});
			}
		}
	};
</script>
<style lang="scss" scoped>
	.table-content {
		background: transparent;
	}
	
	.center-form-pv .el-select {
				width: 100%;
			}
	
	.center-form-pv .el-select /deep/ .el-input__inner {
				border:  1px solid #0098EF;
				border-radius: 4px;
				padding: 0 10px;
				box-shadow: none;
				outline: none;
				color:  #0098EF;
				width: 100%;
				font-size: 16px;
				height: 41px;
			}
	
	// table
	.el-table /deep/ .el-table__header-wrapper thead {
				color: #0098EF;
				background: linear-gradient( 180deg, #FCFCFC 0%, #E5E5E5 100%);
				font-weight: 500;
				width: 100%;
			}
	
	.el-table /deep/ .el-table__header-wrapper thead tr {
				background: none;
			}
	
	.el-table /deep/ .el-table__header-wrapper thead tr th {
				padding: 12px 0;
				background: none;
				border-color: #999999;
				border-width: 0;
				border-style: solid;
				text-align: center;
			}
	
	.el-table /deep/ .el-table__header-wrapper thead tr th .cell {
				padding: 0 0 0 5px;
				word-wrap: normal;
				color: #0098EF;
				white-space: normal;
				font-weight: bold;
				display: flex;
				vertical-align: middle;
				font-size: 15px;
				line-height: 24px;
				text-overflow: ellipsis;
				word-break: break-all;
				width: 100%;
				justify-content: flex-start;
				align-items: center;
				position: relative;
				min-width: 110px;
			}
	
	
	.el-table /deep/ .el-table__body-wrapper {
				position: relative;
			}
	.el-table /deep/ .el-table__body-wrapper tbody {
				width: 100%;
			}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr {
				background: #fff;
			}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td {
				padding: 4px 0;
				color: #555;
				background: none;
				border-color: #999999;
				border-width: 0 0px 1px 0;
				border-style: solid;
				text-align: left;
			}
	
	
	.el-table /deep/ .el-table__body-wrapper tbody tr:hover td {
				padding: 4px 0;
				color: #000;
				background: #f4f8fe;
				border-color: #999999;
				border-width: 0 0px 1px 0;
				border-style: solid;
				text-align: left;
			}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td {
				padding: 4px 0;
				color: #555;
				background: none;
				border-color: #999999;
				border-width: 0 0px 1px 0;
				border-style: solid;
				text-align: left;
			}
	
	.el-table /deep/ .el-table__body-wrapper tbody tr td .cell {
				padding: 0 0 0 5px;
				overflow: hidden;
				color: #212D3F;
				word-break: break-all;
				white-space: normal;
				font-size: inherit;
				line-height: 24px;
				text-overflow: ellipsis;
			}
	
	// pagination
	.main-content .el-pagination /deep/ .el-pagination__total {
				margin: 0 20px 0 0;
				color: #333333;
				font-weight: 600;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				line-height: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .btn-prev {
				border: 1px solid #333333;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #212D3F;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #fff;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .btn-next {
				border: 1px solid #333333;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #212D3F;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #fff;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .btn-prev:disabled {
				border: 1px solid #333333;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #212D3F;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #eee;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .btn-next:disabled {
				border: 1px solid #333333;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #212D3F;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #eee;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pager {
				padding: 0;
				margin: 0;
				display: inline-block;
				vertical-align: top;
			}
	
	.main-content .el-pagination /deep/ .el-pager .number {
				border: 1px solid #333333;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #333333;
				font-weight: 600;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				line-height: 40px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #fff;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pager .number:hover {
				border: 1px solid #333333;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #212D3F;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				line-height: 40px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #fff;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pager .number.active {
				border: 1px solid #0098EF;
				cursor: not-allowed;
				padding: 0;
				margin: 0 5px;
				color: #0098EF;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				line-height: 40px;
				border-radius: 8px  8px  8px  8px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				background: #fff;
				width: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes {
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				line-height: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input {
				margin: 0 5px;
				width: 100px;
				position: relative;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input .el-input__inner {
				border: 1px solid #333333;
				cursor: pointer;
				padding: 0 25px 0 8px;
				color: #333333;
				font-weight: 600;
				display: inline-block;
				font-size: 15px;
				line-height: 40px;
				border-radius: 3px;
				box-shadow:  inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input span.el-input__suffix {
				top: 0;
				position: absolute;
				right: 0;
				height: 100%;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__sizes .el-input .el-input__suffix .el-select__caret {
				cursor: pointer;
				color: #333333;
				width: 25px;
				font-size: 15px;
				line-height: 28px;
				text-align: center;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__jump {
				margin: 0 0 0 24px;
				color: #333333;
				font-weight: 600;
				display: inline-block;
				vertical-align: top;
				font-size: 15px;
				line-height: 40px;
				height: 40px;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__jump .el-input {
				border-radius: 3px;
				padding: 0 2px;
				margin: 0 2px;
				display: inline-block;
				width: 50px;
				font-size: 15px;
				line-height: 18px;
				position: relative;
				text-align: center;
				height: 28px;
			}
	
	.main-content .el-pagination /deep/ .el-pagination__jump .el-input .el-input__inner {
				border: 1px solid #333333;
				cursor: pointer;
				padding: 0 3px;
				color: #333333;
				font-weight: 600;
				display: inline-block;
				font-size: 15px;
				line-height: 40px;
				border-radius: 8px;
				box-shadow: inset 0px 3px 6px 1px rgba(0,0,0,0.16);
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 40px;
			}
</style>
