import VueRouter from 'vue-router'
//引入组件
import Index from '../pages'
import Home from '../pages/home/home'
import Login from '../pages/login/login'
import Register from '../pages/register/register'
import Center from '../pages/center/center'
import Messages from '../pages/messages/list'
import Storeup from '../pages/storeup/list'
import AddrList from '../pages/shop-address/list'
import AddrAdd from '../pages/shop-address/addOrUpdate'
import Order from '../pages/shop-order/list'
import OrderConfirm from '../pages/shop-order/confirm'
import Cart from '../pages/shop-cart/list'
import payList from '../pages/pay'

import yonghuList from '../pages/yonghu/list'
import yonghuDetail from '../pages/yonghu/detail'
import yonghuAdd from '../pages/yonghu/add'
import shujifenleiList from '../pages/shujifenlei/list'
import shujifenleiDetail from '../pages/shujifenlei/detail'
import shujifenleiAdd from '../pages/shujifenlei/add'
import ershoushujiList from '../pages/ershoushuji/list'
import ershoushujiDetail from '../pages/ershoushuji/detail'
import ershoushujiAdd from '../pages/ershoushuji/add'
import youhuihuodongList from '../pages/youhuihuodong/list'
import youhuihuodongDetail from '../pages/youhuihuodong/detail'
import youhuihuodongAdd from '../pages/youhuihuodong/add'
import chatmessageList from '../pages/chatmessage/list'
import chatmessageDetail from '../pages/chatmessage/detail'
import chatmessageAdd from '../pages/chatmessage/add'
import friendList from '../pages/friend/list'
import friendDetail from '../pages/friend/detail'
import friendAdd from '../pages/friend/add'
import chargerecordList from '../pages/chargerecord/list'
import chargerecordDetail from '../pages/chargerecord/detail'
import chargerecordAdd from '../pages/chargerecord/add'
import discussershoushujiList from '../pages/discussershoushuji/list'
import discussershoushujiDetail from '../pages/discussershoushuji/detail'
import discussershoushujiAdd from '../pages/discussershoushuji/add'

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
	return originalPush.call(this, location).catch(err => err)
}

//配置路由
export default new VueRouter({
	routes:[
		{
      path: '/',
      redirect: '/index/home'
    },
		{
			path: '/index',
			component: Index,
			children:[
				{
					path: 'home',
					component: Home
				},
				{
					path: 'center',
					component: Center,
				},
				{
					path: 'pay',
					component: payList,
				},
				{
					path: 'messages',
					component: Messages
				},
				{
					path: 'storeup',
					component: Storeup
				},
                {
                    path: 'shop-address/list',
                    component: AddrList
                },
                {
                    path: 'shop-address/addOrUpdate',
                    component: AddrAdd
                },
				{
					path: 'shop-order/order',
					component: Order
				},
				{
					path: 'cart',
					component: Cart
				},
				{
					path: 'shop-order/orderConfirm',
					component: OrderConfirm
				},
				{
					path: 'yonghu',
					component: yonghuList
				},
				{
					path: 'yonghuDetail',
					component: yonghuDetail
				},
				{
					path: 'yonghuAdd',
					component: yonghuAdd
				},
				{
					path: 'shujifenlei',
					component: shujifenleiList
				},
				{
					path: 'shujifenleiDetail',
					component: shujifenleiDetail
				},
				{
					path: 'shujifenleiAdd',
					component: shujifenleiAdd
				},
				{
					path: 'ershoushuji',
					component: ershoushujiList
				},
				{
					path: 'ershoushujiDetail',
					component: ershoushujiDetail
				},
				{
					path: 'ershoushujiAdd',
					component: ershoushujiAdd
				},
				{
					path: 'youhuihuodong',
					component: youhuihuodongList
				},
				{
					path: 'youhuihuodongDetail',
					component: youhuihuodongDetail
				},
				{
					path: 'youhuihuodongAdd',
					component: youhuihuodongAdd
				},
				{
					path: 'chatmessage',
					component: chatmessageList
				},
				{
					path: 'chatmessageDetail',
					component: chatmessageDetail
				},
				{
					path: 'chatmessageAdd',
					component: chatmessageAdd
				},
				{
					path: 'friend',
					component: friendList
				},
				{
					path: 'friendDetail',
					component: friendDetail
				},
				{
					path: 'friendAdd',
					component: friendAdd
				},
				{
					path: 'chargerecord',
					component: chargerecordList
				},
				{
					path: 'chargerecordDetail',
					component: chargerecordDetail
				},
				{
					path: 'chargerecordAdd',
					component: chargerecordAdd
				},
				{
					path: 'discussershoushuji',
					component: discussershoushujiList
				},
				{
					path: 'discussershoushujiDetail',
					component: discussershoushujiDetail
				},
				{
					path: 'discussershoushujiAdd',
					component: discussershoushujiAdd
				},
			]
		},
		{
			path: '/login',
			component: Login
		},
		{
			path: '/register',
			component: Register
		},
	]
})
