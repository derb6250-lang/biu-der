<template>
	<div :style='{"width":"100%","padding":"20px 10% 40px","margin":"10px auto","position":"relative","background":"none"}'>















		<div class="back_box">
			<el-button class="backBtn" size="mini" @click="backClick">
				<span class="icon iconfont icon-fanhui21"></span>
				<span class="text">返回</span>
			</el-button>
		</div>
		<div class="section-title" :style='{"padding":"0","borderColor":"#000","color":"#333","textAlign":"center","background":"none","borderWidth":"4px","display":"block","width":"100%","lineHeight":"60px","fontSize":"30px","borderStyle":"double","fontWeight":"500"}'>我的订单</div>
		<el-tabs v-model="activeName" @tab-click="handleClick">
			<el-tab-pane label="未支付" name="未支付"></el-tab-pane>
			<el-tab-pane label="已支付" name="已支付"></el-tab-pane>
			<el-tab-pane  label="已发货" name="已发货"></el-tab-pane>
			<el-tab-pane label="已完成" name="已完成"></el-tab-pane>
			<el-tab-pane label="已退款" name="已退款"></el-tab-pane>
			<el-tab-pane label="已取消" name="已取消"></el-tab-pane>
		</el-tabs>
		<el-table :data="tableData" style="width: 100%" :row-class-name="tableRowClassName">
			<el-table-column label="订单编号" prop="orderid"></el-table-column>
			<el-table-column label="名称" align="center" width="200px">
				<template slot-scope="scope">
					<div class="shangpin">
						<el-image style="width: 100px; height: 100px;flex: 1" :src="baseUrl + scope.row.picture" fit="fill"></el-image>
						<span style="margin-left: 10px;flex: 1" >{{ scope.row.goodname }}</span>
					</div>
				</template>
			</el-table-column>
			<el-table-column label="价格">
				<template slot-scope="scope">
					<span v-if="(scope.row.type == 1 || scope.row.type == 3)&&scope.row.price>0"><span :style='{"fontSize":"12px"}'>￥</span>{{ scope.row.price }}</span>
					<span v-if="scope.row.type == 2&&scope.row.price>0">{{ scope.row.price }}积分</span>
				</template>
			</el-table-column>
			<el-table-column label="数量" prop="buynumber"></el-table-column>
			<el-table-column label="总价">
				<template slot-scope="scope">
					<span v-if="(scope.row.type == 1 || scope.row.type == 3)&&scope.row.total>0"><span :style='{"fontSize":"12px"}'>￥</span>{{ scope.row.total }}</span>
					<span v-if="scope.row.type == 2&&scope.row.total>0">{{ scope.row.total }}积分</span>
				</template>
			</el-table-column>
			<el-table-column label="地址" prop="address"></el-table-column>
			<el-table-column label="电话" prop="tel"></el-table-column>
			<el-table-column label="收货人" prop="consignee"></el-table-column>
			<el-table-column label="下单时间" prop="addtime"></el-table-column>
			<el-table-column label="备注" prop="remark"></el-table-column>
			<el-table-column label="退货审核" prop="sfsh" v-if="changeReturnGoods()">
				<template slot-scope="scope">
					<el-tag type="success" v-if="scope.row.sfsh=='是'">已通过</el-tag>
					<el-tag type="warning" v-if="scope.row.sfsh=='待审核'">待审核</el-tag>
					<el-tag type="danger" v-if="scope.row.sfsh=='否'">未通过</el-tag>
				</template>
			</el-table-column>
			<el-table-column label="审核回复" prop="shhf"></el-table-column>
			<el-table-column label="操作" width="150">
				<template slot-scope="scope">
					<div v-if="userid == scope.row.userid">
					<el-button v-show="activeName == '未支付'" type="success" :style='{"margin":"2px auto",}' size="mini" @click="beforePay(scope.row)">支付</el-button>
					<el-button v-show="activeName == '未支付'" type="danger" :style='{"margin":"2px auto",}' size="mini" @click="cancel(scope.row)">取消</el-button>
					<el-button v-show="activeName == '已支付'" type="danger" :style='{"margin":"2px auto",}' size="mini" @click="refund(scope.row)">{{scope.row.total>0?'退款':'退订'}}</el-button>
					<el-button v-if="scope.row.logistics" type="warning" :style='{"margin":"2px auto",}' size="mini" @click="logistics(scope.row)">物流</el-button>
					<el-button v-if="activeName == '已完成'&&scope.row.sfsh==''&&changeReturnGoods()" type="danger" :style='{"margin":"2px auto",}' size="mini" @click="returnGood(scope.row)">退货</el-button>
					<el-button v-show="activeName == '已完成'" type="primary" :style='{"margin":"2px auto",}' size="mini" @click="toDetail(scope.row)">评价</el-button>
					<el-button v-show="activeName == '已发货'" type="success" :style='{"margin":"2px auto",}' size="mini" @click="confirm(scope.row)">确认收货</el-button>
					<el-button v-show="activeName == '已支付'&&btnAuth('orders/' + activeName,'二维码')" type="success" :style='{"margin":"2px auto",}' size="mini" @click="qrcodeClick(scope.row)">二维码</el-button>
					</div>
					<div v-if="scope.row[merchantName] == username">
						<el-button v-if="btnAuth('orders/' + activeName,'物流')" type="warning" size="mini" @click="logisticsUpdate(scope.row)">
							更新物流
						</el-button>
						<el-button v-if="btnAuth('orders/' + activeName,'发货')" type="primary" size="mini" @click="updateHandler(scope.row)">
							发货
						</el-button>
						<el-button v-if="btnAuth('orders/' + activeName,'确认收货')" type="danger" size="mini" @click="updateHandler2(scope.row)">
							确认收货
						</el-button>
						<el-button v-if="btnAuth('orders/' + activeName,'退货审核')&&scope.row.sfsh=='待审核'" type="danger" size="mini" @click="returnSh(scope.row)">
							退货审核
						</el-button>
					</div>
				</template>
			</el-table-column>
		</el-table>
		<div style="width: 100%;padding: 10px;background: #fff;display: flex;margin: 10px 0;justify-content: flex-end;font-size: 14px;">
			<div style="margin: 0 10px 0 0;display: flex;align-items: center;">
				<div style="background: #ffdbdb;width: 14px;height: 14px;margin: 0 10px 0 0;"></div>
				<div>购买订单</div>
			</div>
			<div style="display: flex;align-items: center;">
				<div style="background: #e6ffd3;width: 14px;height: 14px;margin: 0 10px 0 0;"></div>
				<div>销售订单</div>
			</div>
		</div>
		<el-pagination
			background
			id="pagination" class="pagination"
			:pager-count="7"
			:page-size="pageSize"
			:page-sizes="pageSizes"
			prev-text="<"
			next-text=">"
			:hide-on-single-page="true"
			:layout='["total","prev","pager","next","sizes","jumper"].join()'
			:total="total"
			:style='{"padding":"0","margin":"20px auto","whiteSpace":"nowrap","color":"#333","textAlign":"center","width":"100%","fontSize":"16px","fontWeight":"500","order":"50"}'
			@current-change="curChange"
			@size-change="sizeChange"
			@prev-click="prevClick"
			@next-click="nextClick"
			></el-pagination>

		<el-dialog title="物流信息" :visible.sync="logisticsVisible" width="30%">
			<div class="ql-snow ql-editor" v-html="logisticsText"></div>
		</el-dialog>
		<el-dialog title="退货理由" :visible.sync="returngoodVisible" width="30%">
			<el-input v-model="returnGoodForm.returnreason" type="textarea" placeholder="退货理由"></el-input>
			<el-tag v-for="(item,index) in reasonList" :key="index" :type="item.type" style="cursor: pointer;margin: 5px 5px 0 0;" @click="reasonClick(item.title)">{{item.title}}</el-tag>
			<div style="margin: 20px 0 0">
				<el-button type="primary" style="margin-left: 10px;" @click="returnGoodSave">确认</el-button>
				<el-button type="danger" style="margin-left: 10px;" @click="returngoodVisible=false">取消</el-button>
			</div>
		</el-dialog>
		<el-dialog title="二维码" :visible.sync="codeVisible" width="490px">
			<div id="qrcode"></div>
		</el-dialog>
		<el-dialog title="更新物流信息" :visible.sync="updateLogVisible" width="40%">
			<el-input v-model="updateLogForm.logistics" type="textarea" placeholder="物流信息"></el-input>
			<div style="margin: 20px 0 0">
				<el-button type="primary" style="margin-left: 10px;" @click="updateLogSave">确认</el-button>
				<el-button type="danger" style="margin-left: 10px;" @click="updateLogVisible=false">取消</el-button>
			</div>
		</el-dialog>
		<el-dialog title="退货审核" :visible.sync="returnShVisible" width="50%">
			<el-form ref="returnShForm" :model="returnShForm" label-width="80px" :rules="returnShRules">
				<el-form-item label="退货理由" prop="returnreason">
					{{returnShForm.returnreason}}
				</el-form-item>
				<el-form-item label="审核状态" prop="sfsh">
					<el-select v-model="returnShForm.sfsh" placeholder="审核状态">
						<el-option label="通过" value="是"></el-option>
						<el-option label="不通过" value="否"></el-option>
						<el-option label="待审核" value="待审核"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="内容" prop="shhf">
					<el-input type="textarea" :rows="8" v-model="returnShForm.shhf"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="returnShVisible=false">取 消</el-button>
				<el-button type="primary" @click="returnShSave">确 定</el-button>
			</span>
		</el-dialog>
		<el-dialog title="验证支付密码" :visible.sync="payPasswordVisible" width="20%">
			<el-input type="password" v-model="payPassword" placeholder="支付密码" style="width: 100%;"></el-input>
			<span slot="footer" class="dialog-footer">
				<el-button @click="payPasswordVisible=false">返回</el-button>
				<el-button @click="payConfirm" type="success">确认支付</el-button>
			</span>
		</el-dialog>
	</div>
</template>

<script>
	import config from '@/config/config';
	import QRCode from 'qrcode2';
	export default {
		data() {
			return {
				layouts: '',
				baseUrl: config.baseUrl,
				activeName: '未支付',
				tableData: [],
				total: 1,
				pageSize: 10,
				pageSizes: [],
				totalPage: 1,
				session: {},
				userTableName: localStorage.getItem('UserTableName'),
				codeVisible: false,
				logisticsVisible: false,
				logisticsText: '',
				returngoodVisible: false,
				returnGoodForm: {
					returnreason: ''
				},
				reasonList: [{
					title: '买多了',
					type: ''
				}, {
					title: '不想要了',
					type: 'info'
				}, {
					title: '与原图不符',
					type: 'warning'
				}, {
					title: '商品质量差',
					type: 'danger'
				}, ],
				merchantName: this.$config.merchantName,
				// 更新物流
				updateLogForm: {},
				updateLogVisible: false,
				returnShForm: {},
				returnShVisible: false,
				returnShRules:{
					sfsh:[{ required: true, message: '审核状态不能为空', trigger: 'blur' },],
					shhf:[{ required: true, message: '审核回复不能为空', trigger: 'blur' },],
				},
				payPasswordVisible: false,
				payPassword: '',
				payForm: {},
			}
		},
		created() {
			this.getSession();
			this.getMyOrderList(1);
		},
		computed: {
			userid(){
				return localStorage.getItem('frontUserid')
			},
			username(){
				return localStorage.getItem('username')
			},
		},
		methods: {
			tableRowClassName({
				row,
				rowIndex
			}) {
				let name = ''
				if(row.userid == this.userid) {
					name = 'buy-orders'
				}
				if(row[this.merchantName] == this.username) {
					name = 'sales-orders'
				}
				return name;
			},
			qrcodeClick(row) {
				this.codeVisible = true
				this.$nextTick(()=>{
					if(document.getElementById('qrcode').innerHTML!=null) {
						document.getElementById('qrcode').innerHTML = ''
					}
					var qrcode = new QRCode(document.getElementById('qrcode'), {
						text: row.orderid,
						width: 450,
						height: 450,
						colorDark : "#000000",
						colorLight : "#ffffff",
						correctLevel : QRCode.CorrectLevel.H
					});
				})
			},
			btnAuth(tableName,key){
				return this.isBackAuth(tableName,key)
			},
			backClick() {
				this.$router.push('/index/center')
			},
			getSession() {
				this.$http.get(this.userTableName+'/session', {emulateJSON: true}).then(res => {
					if (res.data.code == 0) {
						this.session = res.data.data;
					}
				});
			},
			handleClick(tab, event) {
				tab.activeName = event.target.outerText;
				this.getMyOrderList(1);
			},
			toDetail(row) {
				this.$router.push({path: '/index/'+row.tablename+'Detail', query: {id: row.goodid}});
			},
			handleAction(index, row) {
				if (index == '已支付' && this.session.money < row.total) {
					this.$message.error('余额不足，请先充值');
					return;
				}
	
				row.status = index;
				this.$http.post('orders/update', row).then(res => {
					if (res.data.code == 0) {
						if (index == '已支付') this.session.money -= row.total;
						if (index == '已退款' && row.type == 1) this.session.money += row.total;
						if (index == '已退款' && row.type == 2) this.session.jifen += row.total;
						if (index == '已支付' || index == '已退款') {
							this.session.money = this.session.money.toFixed(2);
							this.$http.post(this.userTableName+'/update', this.session).then(res => {});
						}
						this.$message({
							message: '操作成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								this.getMyOrderList(1);
							}
						});
					}
				});
			},
			// 退款
			refund(item) {
				this.$confirm(`${item.total>0?'确定退款吗？退款金额将返回账户中。':'是否退订？'}`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					// 获取商品详情信息
					this.$http.get(item.tablename+'/info/'+item.goodid, {}).then(res => {
						// 商品信息
						let good = res.data.data;
						// 用户当前用户信息
						let table = localStorage.getItem("UserTableName");
						this.$http.get(table+'/session', {}).then(res => {
							this.user = res.data.data;
							if(item.type==1||item.type==3) {
								// 如果该商品存在积分
								if (good.jf) {
									this.user.jf = (Number(this.user.jf) - Number(item.total)).toFixed(2);
								}
								this.user.money = (Number(this.user.money) + Number(item.total)).toFixed(2);
								// 更新用户余额
								this.$http.post(table+'/update', this.user).then(res => {
									item.status = '已退款'
									localStorage.setItem('sessionForm',JSON.stringify(this.user))
									this.$http.post(`orders/update`, item).then(res => {
										if(item.tablename == `ershoushuji`){
											// 加回库存数量
											good.alllimittimes = good.alllimittimes + item.buynumber;
											this.$http.post(`ershoushuji/update`, good).then(res => {
											});
										}
										this.$message({
											message: `${item.total>0?'退款成功':'退订成功'}`,
											type: 'success',
											duration: 1500,
											onClose: () => {
												this.getMyOrderList(1);
											}
										});
									});
								});
							} else if(item.type==2) {
								this.user.jf = Number(this.user.jf) + Number(item.total);
								// 更新用户余额
								this.$http.post(table+'/update', this.user).then(res => {
									item.status = '已退款'
									localStorage.setItem('sessionForm',JSON.stringify(this.user))
									this.$http.post(`orders/update`, item).then(res => {
										if(item.tablename == `ershoushuji`){
											// 加回库存数量
											good.alllimittimes = good.alllimittimes + item.buynumber;
											this.$http.post(`ershoushuji/update`, good).then(res => {
											});
										}
										this.$message({
											message: `${item.total>0?'退款成功':'退订成功'}`,
											type: 'success',
											duration: 1500,
											onClose: () => {
												this.getMyOrderList(1);
											}
										});
									});
								});
							}
						});
					});
				});
			},
			//物流
			logistics(row) {
				this.logisticsText = row.logistics;
				this.logisticsVisible = true;
			},
			//退货
			returnGood(item){
				this.returnGoodForm = item
				this.returngoodVisible = true
			},
			reasonClick(name) {
				if (this.returnGoodForm.returnreason) {
					this.returnGoodForm.returnreason = this.returnGoodForm.returnreason + '，' + name
				} else {
					this.returnGoodForm.returnreason = name
				}
				this.$forceUpdate()
			},
			returnGoodSave() {
				this.$confirm(`确定退货吗？审核通过后退款金额将返回账户中。`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					this.returnGoodForm.sfsh = '待审核'
					this.$http.post(`orders/update`, this.returnGoodForm).then(res => {
						this.$message({
							message: '申请成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								this.getMyOrderList(1);
								this.returngoodVisible = false
							}
						});
					})
				});
			},

			beforePay(item){
				if(localStorage.getItem('hasPayPassword')&&localStorage.getItem('hasPayPassword')==1) {
					this.payPassword = ''
					this.payPasswordVisible = true
					this.payForm = JSON.parse(JSON.stringify(item))
				}else {
					this.pay(item)
				}
			},
			payConfirm() {
				let that = this
				if(this.payPassword == this.session.paypassword) {
					this.$message({
						message: '支付密码正确！',
						type: 'success',
						duration: 1500,
						onClose(){
							that.payPasswordVisible = false
							that.pay(that.payForm)
						}
					});
				}else {
					this.$message({
						message: '支付密码错误！',
						type: 'error',
						duration: 1500
					});
				}
			},
			// 支付
			pay(item) {
				// 获取商品详情信息
				this.$http.get(item.tablename+'/info/'+item.goodid, {}).then(res => {
					// 商品信息
					let data = res.data.data;
					// 用户当前用户信息
					let table = localStorage.getItem("UserTableName");
					this.$http.get(table+'/session', {}).then(res => {
						this.user = res.data.data;
						// 判断余额是否充足
						if (Number(this.user.money) < Number(item.total)) {
							this.$message({
								message: '余额不足，请先充值',
								type: 'error',
								duration: 1500
							});
							return
						}
						// 如果该商品存在积分
						if (data.jf) {
							this.user.jf = Number((Number(this.user.jf) + Number(item.total)).toFixed(2));
						}
						this.user.money = Number((Number(this.user.money) - Number(item.total)).toFixed(2));
						// 更新用户余额
						this.$http.post(table+'/update', this.user).then(res => {
							item.status = '已支付'
							localStorage.setItem('sessionForm',JSON.stringify(this.user))
							this.$http.post(`orders/update`, item).then(res => {
								this.$message({
									message: '支付成功',
									type: 'success',
									duration: 1500,
									onClose: () => {
										this.getMyOrderList(1);
									}
								});
							});
						});
					});
				});
			},
			confirm(item){
				this.$confirm(`是否确定收货？`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					item.status = '已完成'
					this.$http.post(`orders/update`, item).then(async res => {
						await this.$http.post(`${item.tablename}/info/${item.goodid}`).then(async rs=>{
							if(rs.data.data.sales||rs.data.data.sales==0) {
								rs.data.data.sales = Number((Number(rs.data.data.sales) + Number(item.buynumber)).toFixed(0))
								await this.$http.post(`${item.tablename}/update`,rs.data.data).then(rs2=>{})
							}
						})
						this.$message({
							message: '确认收货成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								this.getMyOrderList(1);
							}
						});
					});
				});
			},
			cancel(item){
				this.$confirm(`是否取消订单？`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					item.status = '已取消'
					this.$http.post(`orders/update`, item).then(res => {
						// 获取商品详情信息
						this.$http.get(item.tablename+'/info/'+item.goodid, {}).then(res => {
							// 商品信息
							let good = res.data.data;
							if(item.tablename == `ershoushuji`){
								// 加回库存数量
								good.alllimittimes = good.alllimittimes + item.buynumber;
								this.$http.post(`ershoushuji/update`, good).then(res => {
								});
							}
							this.$message({
								message: '订单取消成功',
								type: 'success',
								duration: 1500,
								onClose: () => {
									this.getMyOrderList(1);
								}
							});
						});
					});
				});
			},
			getMyOrderList(page) {
				let params = {
					page, limit: this.pageSize,sort:'addtime',order:'desc', status: this.activeName
				}
				this.$http.get('orders/mch/list', {params: params}).then(res => {
					if (res.data.code == 0) {
						this.tableData = res.data.data.list;
						this.total = res.data.data.total;
						this.pageSize = Number(res.data.data.pageSize);
						this.totalPage = res.data.data.totalPage;
						if(this.pageSizes.length==0){
							this.pageSizes = [this.pageSize, this.pageSize*2, this.pageSize*3, this.pageSize*5];
						}
					}
				});
			},
			curChange(page) {
				this.getMyOrderList(page);
			},
			prevClick(page) {
				this.getMyOrderList(page);
			},
			sizeChange(size){
				this.pageSize = size
				this.getMyOrderList(1);
			},
			nextClick(page) {
				this.getMyOrderList(page);
			},
			logisticsUpdate(item) {
				this.updateLogForm = item
				this.updateLogVisible = true
			},
			updateLogSave() {
				this.$http.post('orders/update', this.updateLogForm).then(rs=>{
					if(rs.data.code==0) {
						this.$message({
							message: '操作成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								this.getMyOrderList(1);
								this.updateLogVisible = false
							}
						});
					}
				})
			},
			updateHandler(item) {
				this.$confirm(`是否发货？`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					item.status = '已发货'
					this.$http.post(`orders/update`, item).then(async res => {
						this.$message({
							message: '发货成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								this.getMyOrderList(1);
							}
						});
					});
				});
			},
			updateHandler2(item) {
				this.$confirm(`是否确认收货？`, "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					item.status = '已完成'
					this.$http.post(`orders/update`, item).then(async res => {
						this.$message({
							message: '发货成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								this.getMyOrderList(1);
							}
						});
					});
				});
			},
			returnSh(row) {
				this.returnShForm = JSON.parse(JSON.stringify(row))
				this.returnShVisible = true
			},
			returnShSave(){
				this.$refs["returnShForm"].validate(valid => {
					if(valid){
						if(this.returnShForm.sfsh=="是"){
							this.returnShForm.status = '已退款'
							this.$http.get(`${this.returnShForm.tablename}/info/${this.returnShForm.goodid}`).then(res=>{
								if(res.data&&res.data.code==0){
									let good = res.data.data
									// 商品存在库存。加回库存
									if(good.alllimittimes){
										good.alllimittimes = parseInt(good.alllimittimes) + parseInt(this.returnShForm.buynumber)
										this.$http.post(`${this.returnShForm.tablename}/update`,good).then(obj=>{})
									}
									this.$http.get(`${this.returnShForm.role}/info/${this.returnShForm.userid}`).then(res1=>{
										if(res1.data&&res1.data.code==0){
											let user = res1.data.data
											// 如果是积分兑换 加回积分 
											if(this.returnShForm.type==2){
												user.jf = (Number(user.jf) + Number(this.returnShForm.total)).toFixed(2)
												this.$http.post(`${this.returnShForm.role}/update`,user).then(obj=>{})
											}
											// 如果是其他形式 有积分减去积分。余额加回余额
											else{
												// 商品存在积分。加回积分
												if(good.jf){
													user.jf = (Number(user.jf) - Number(this.returnShForm.total)).toFixed(2)
												}
												if(user.jf<0) {
													user.jf = 0
												}
												// 加回余额
												user.money = (Number(user.money) + Number(this.returnShForm.total)).toFixed(2)
												this.$http.post(`${this.returnShForm.role}/update`,user).then(obj=>{})
											}
											this.$http.post('orders/update',this.returnShForm).then(res=>{
												if(res.data&&res.data.code==0){
													this.$message({
														message: "审核成功",
														type: "success",
														duration: 1500,
														onClose: () => {
															this.getMyOrderList(1);
															this.returnShVisible = false
														}
													})
												}
											})
										}
									})
								}
							})
						}else if(this.returnShForm.sfsh=='否'){
							this.$http.post('orders/update',this.returnShForm).then(res=>{
								if(res.data&&res.data.code==0){
									this.$message({
										message: "审核成功",
										type: "success",
										duration: 1500,
										onClose: () => {
											this.getMyOrderList(1);
											this.returnShVisible = false
										}
									})
								}
							})
						}
					}
				})
			},
		}
	}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.section {
		width: 1000px;
		margin: 0 auto;
	}

	.shangpin {
		display: flex;
	}
	.el-tabs /deep/ .el-tabs__nav-wrap {
		background: #fff;
		padding: 10px;
	}
	/deep/ .el-table .buy-orders {
		background: #ffdbdb50;
	}
	/deep/ .el-table .sales-orders {
		background: #e6ffd350;
	}
</style>
