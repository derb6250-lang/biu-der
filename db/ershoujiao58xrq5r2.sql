/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50717 (5.7.17-log)
 Source Host           : localhost:3306
 Source Schema         : ershoujiao58xrq5r2

 Target Server Type    : MySQL
 Target Server Version : 50717 (5.7.17-log)
 File Encoding         : 65001

 Date: 14/04/2026 11:53:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货人',
  `phone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '电话',
  `isdefault` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否默认地址[是/否]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '2026-01-08 13:29:58', 11, '宇宙银河系金星1号', '金某', '13823888881', '是');
INSERT INTO `address` VALUES (2, '2026-01-08 13:29:58', 12, '宇宙银河系木星1号', '木某', '13823888882', '是');
INSERT INTO `address` VALUES (3, '2026-01-08 13:29:58', 13, '宇宙银河系水星1号', '水某', '13823888883', '是');
INSERT INTO `address` VALUES (4, '2026-01-08 13:29:58', 14, '宇宙银河系火星1号', '火某', '13823888884', '是');
INSERT INTO `address` VALUES (5, '2026-01-08 13:29:58', 15, '宇宙银河系土星1号', '土某', '13823888885', '是');
INSERT INTO `address` VALUES (6, '2026-01-08 13:29:58', 16, '宇宙银河系月球1号', '月某', '13823888886', '是');
INSERT INTO `address` VALUES (7, '2026-01-08 13:29:58', 17, '宇宙银河系黑洞1号', '黑某', '13823888887', '是');
INSERT INTO `address` VALUES (8, '2026-01-08 13:29:58', 18, '宇宙银河系地球1号', '地某', '13823888888', '是');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ershoushuji' COMMENT '商品表名',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片',
  `buynumber` int(11) NOT NULL COMMENT '购买数量',
  `price` double NULL DEFAULT NULL COMMENT '单价',
  `yonghuzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商户名称',
  `goodtype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `price`(`price`) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`price`) REFERENCES `ershoushuji` (`price`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for chargerecord
-- ----------------------------
DROP TABLE IF EXISTS `chargerecord`;
CREATE TABLE `chargerecord`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色',
  `amount` double NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '充值记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chargerecord
-- ----------------------------
INSERT INTO `chargerecord` VALUES (1, '2026-01-08 13:29:58', 1, '用户名1', '角色1', 1);
INSERT INTO `chargerecord` VALUES (2, '2026-01-08 13:29:58', 2, '用户名2', '角色2', 2);
INSERT INTO `chargerecord` VALUES (3, '2026-01-08 13:29:58', 3, '用户名3', '角色3', 3);
INSERT INTO `chargerecord` VALUES (4, '2026-01-08 13:29:58', 4, '用户名4', '角色4', 4);
INSERT INTO `chargerecord` VALUES (5, '2026-01-08 13:29:58', 5, '用户名5', '角色5', 5);
INSERT INTO `chargerecord` VALUES (6, '2026-01-08 13:29:58', 6, '用户名6', '角色6', 6);
INSERT INTO `chargerecord` VALUES (7, '2026-01-08 13:29:58', 7, '用户名7', '角色7', 7);
INSERT INTO `chargerecord` VALUES (8, '2026-01-08 13:29:58', 8, '用户名8', '角色8', 8);

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `adminid` bigint(20) NULL DEFAULT NULL COMMENT '管理员id',
  `ask` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '提问',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '回复',
  `isreply` int(11) NULL DEFAULT NULL COMMENT '是否回复',
  `isread` int(11) NULL DEFAULT 0 COMMENT '已读/未读(1:已读,0:未读)',
  `uname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `uimage` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '用户头像',
  `type` int(11) NULL DEFAULT 1 COMMENT '内容类型(1:文本,2:图片,3:视频,4:文件,5:表情)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '在线投诉' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES (1, '2026-01-08 13:29:58', 1, 1, '提问1', '回复1', 1, 1, '用户名1', 'upload/chat_uimage1.jpg,upload/chat_uimage2.jpg,upload/chat_uimage3.jpg', 1);
INSERT INTO `chat` VALUES (2, '2026-01-08 13:29:58', 2, 2, '提问2', '回复2', 2, 2, '用户名2', 'upload/chat_uimage2.jpg,upload/chat_uimage3.jpg,upload/chat_uimage4.jpg', 2);
INSERT INTO `chat` VALUES (3, '2026-01-08 13:29:58', 3, 3, '提问3', '回复3', 3, 3, '用户名3', 'upload/chat_uimage3.jpg,upload/chat_uimage4.jpg,upload/chat_uimage5.jpg', 3);
INSERT INTO `chat` VALUES (4, '2026-01-08 13:29:58', 4, 4, '提问4', '回复4', 4, 4, '用户名4', 'upload/chat_uimage4.jpg,upload/chat_uimage5.jpg,upload/chat_uimage6.jpg', 4);
INSERT INTO `chat` VALUES (5, '2026-01-08 13:29:58', 5, 5, '提问5', '回复5', 5, 5, '用户名5', 'upload/chat_uimage5.jpg,upload/chat_uimage6.jpg,upload/chat_uimage7.jpg', 5);
INSERT INTO `chat` VALUES (6, '2026-01-08 13:29:58', 6, 6, '提问6', '回复6', 6, 6, '用户名6', 'upload/chat_uimage6.jpg,upload/chat_uimage7.jpg,upload/chat_uimage8.jpg', 6);
INSERT INTO `chat` VALUES (7, '2026-01-08 13:29:58', 7, 7, '提问7', '回复7', 7, 7, '用户名7', 'upload/chat_uimage7.jpg,upload/chat_uimage8.jpg,upload/chat_uimage1.jpg', 7);
INSERT INTO `chat` VALUES (8, '2026-01-08 13:29:58', 8, 8, '提问8', '回复8', 8, 8, '用户名8', 'upload/chat_uimage8.jpg,upload/chat_uimage1.jpg,upload/chat_uimage2.jpg', 8);

-- ----------------------------
-- Table structure for chatmessage
-- ----------------------------
DROP TABLE IF EXISTS `chatmessage`;
CREATE TABLE `chatmessage`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint(20) NOT NULL COMMENT '用户ID',
  `fid` bigint(20) NOT NULL COMMENT '好友用户ID',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `format` int(11) NULL DEFAULT NULL COMMENT '格式(1:文字，2:图片)',
  `isread` int(11) NULL DEFAULT 0 COMMENT '消息已读(0:未读，1:已读)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chatmessage
-- ----------------------------

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  `url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url',
  `type` int(11) NULL DEFAULT NULL COMMENT '参数类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'picture1', 'upload/1767951047250_483.png', NULL, 1);
INSERT INTO `config` VALUES (2, 'picture2', 'upload/1767951056558_578.png', NULL, 1);
INSERT INTO `config` VALUES (3, 'picture3', 'upload/1767951065733_307.png', NULL, 1);
INSERT INTO `config` VALUES (11, 'baidu', '{\"appId\":\"49214550\",\"apiKey\":\"7Otjpv2kn0ljQk45qXOXh5MO\",\"secretKey\":\"BMfbXRbTIVaB4C3SbRTtGqDv1wHDvyXS\"}', NULL, 2);
INSERT INTO `config` VALUES (21, 'bLoginBackgroundImg', '', NULL, 3);
INSERT INTO `config` VALUES (22, 'bRegisterBackgroundImg', '', NULL, 3);
INSERT INTO `config` VALUES (23, 'bIndexBackgroundImg', '', NULL, 3);
INSERT INTO `config` VALUES (24, 'bTopLogo', '', NULL, 3);
INSERT INTO `config` VALUES (25, 'bHomeLogo', '', NULL, 3);
INSERT INTO `config` VALUES (26, 'fLoginBackgroundImg', '', NULL, 3);
INSERT INTO `config` VALUES (27, 'fRegisterBackgroudImg', '', NULL, 3);
INSERT INTO `config` VALUES (28, 'fTopLogo', '', NULL, 3);

-- ----------------------------
-- Table structure for discussershoushuji
-- ----------------------------
DROP TABLE IF EXISTS `discussershoushuji`;
CREATE TABLE `discussershoushuji`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '头像',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `score` double NULL DEFAULT NULL COMMENT '评分',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '回复内容',
  `thumbsupnum` int(11) NULL DEFAULT 0 COMMENT '赞',
  `crazilynum` int(11) NULL DEFAULT 0 COMMENT '踩',
  `istop` int(11) NULL DEFAULT 0 COMMENT '置顶(1:置顶,0:非置顶)',
  `tuserids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '赞用户ids',
  `cuserids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '踩用户ids',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评论' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discussershoushuji
-- ----------------------------

-- ----------------------------
-- Table structure for ershoushuji
-- ----------------------------
DROP TABLE IF EXISTS `ershoushuji`;
CREATE TABLE `ershoushuji`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shujimingcheng` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '羽毛球装备名称',
  `shujifenlei` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '羽毛球装备分类',
  `tupian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片',
  `zuozhe` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '卖家',
  `chubanshe` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '品牌',
  `xinjiuchengdu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '新旧程度',
  `tushujieshao` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图书介绍',
  `yonghuzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户账号',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `onelimittimes` int(11) NULL DEFAULT -1 COMMENT '单限',
  `alllimittimes` int(11) NULL DEFAULT -1 COMMENT '库存',
  `price` double NOT NULL DEFAULT 0 COMMENT '价格',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审核回复',
  `thumbsupnum` int(11) NULL DEFAULT 0 COMMENT '赞',
  `crazilynum` int(11) NULL DEFAULT 0 COMMENT '踩',
  `clicktime` datetime NULL DEFAULT NULL COMMENT '最近点击时间',
  `clicknum` int(11) NULL DEFAULT 0 COMMENT '点击次数',
  `discussnum` int(11) NULL DEFAULT 0 COMMENT '评论数',
  `totalscore` double NULL DEFAULT 0 COMMENT '评分',
  `onshelves` int(11) NULL DEFAULT 1 COMMENT '是否上架(1:上架，0:下架)',
  `storeupnum` int(11) NULL DEFAULT 0 COMMENT '收藏数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ershoushuji_price`(`price`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '二手羽毛球装备' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ershoushuji
-- ----------------------------
INSERT INTO `ershoushuji` VALUES (10, '2026-01-09 17:39:58', '护腕 & 头带套装', '羽毛球配件', 'upload/1767951550333_302.png', '李娜', 'Adidas（阿迪达斯）', '八成新', '', '102', '13445678901', -1, -1, 29, '是', '同意', 0, 0, NULL, 0, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (11, '2026-01-09 17:41:13', 'Premium 羽毛球网', '羽毛球网', 'upload/1767951651167_694.png', '王明', 'Li-Ning（李宁）', '七成新', '', '106', '13456789012', -1, -1, 59, '是', '同意', 0, 0, NULL, 1, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (12, '2026-01-09 17:42:27', 'Super Grip 握把', '羽毛球握把', 'upload/1767951725732_442.png', '陈明', 'Victor（胜利）', '九成新', '', '103', '13590123456', -1, -1, 19, '是', '同意', 0, 0, NULL, 0, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (13, '2026-01-09 17:43:48', 'BG 65 羽毛球线', '羽毛球线', 'upload/1767951792819_829.png', '王静', 'Yonex（尤尼克斯）', '八成新', '', '105', '13589012345', 5, 0, 19, '是', '同意', 0, 0, NULL, 7, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (14, '2026-01-09 17:45:02', 'Deluxe 羽毛球包', '羽毛球包', 'upload/1767951871900_997.png', '赵芳', 'Babolat（百宝力）', '九成新', '', '108', '13490123456', 1, 1, 99, '是', '同意', 0, 0, NULL, 1, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (15, '2026-01-09 17:46:49', 'Pro Tour 羽毛球服装', '羽毛球服装', 'upload/1767951987997_915.png', '李娜与', 'Li-Ning（李宁）', '全新', '', '101', '13556789012', 1, 0, 99, '是', '同意', 0, 0, NULL, 5, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (16, '2026-01-09 17:47:45', 'Aerus 3 羽毛球鞋', '羽毛球鞋', 'upload/1767952044816_406.png', '刘强', 'Victor（胜利）', '八成新', '', '107', '13434567890', 1, 1, 49, '是', '同意', 0, 0, NULL, 1, 0, 0, 1, 0);
INSERT INTO `ershoushuji` VALUES (17, '2026-01-09 17:48:50', 'Carbonex 9000 羽毛球拍', '羽毛球拍', 'upload/1767952105938_983.png', '李军', 'Yonex（尤尼克斯）', '全新', '', '104', '13467890123', 1, 0, 69, '是', '同意', 0, 0, NULL, 3, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint(20) NOT NULL COMMENT '用户ID',
  `fid` bigint(20) NOT NULL COMMENT '好友用户ID',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表名',
  `alias` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '别名',
  `type` int(11) NULL DEFAULT 0 COMMENT '类型(0:好友申请，1:好友，2:消息)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '好友表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend
-- ----------------------------

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '留言人id',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '头像',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言内容',
  `cpicture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '留言图片',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '回复内容',
  `rpicture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '回复图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言反馈' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES (1, '2026-01-08 13:29:58', 1, '李军', 'upload/messages_avatarurl1.jpg', '请问这款羽毛球拍的成色怎么样？有明显磨损吗？', 'upload/messages_cpicture1.jpg', '您好，这款拍子使用较少，表面只有轻微使用痕迹，整体成色很好。', 'upload/messages_rpicture1.jpg');
INSERT INTO `messages` VALUES (2, '2026-01-08 13:29:58', 2, '刘强', 'upload/messages_avatarurl2.jpg', '这双羽毛球鞋尺码是否标准？适合脚宽吗？', 'upload/messages_cpicture2.jpg', '尺码偏正常，脚宽的话建议选大半码，更加舒适哦。', 'upload/messages_rpicture2.jpg');
INSERT INTO `messages` VALUES (3, '2026-01-08 13:29:58', 3, '李娜与', 'upload/messages_avatarurl3.jpg', '羽毛球线的使用情况如何？拉力保持得好吗？', 'upload/messages_cpicture3.jpg', '这条线拉力保持稳定，使用次数不多，性能依然不错。', 'upload/messages_rpicture3.jpg');
INSERT INTO `messages` VALUES (4, '2026-01-08 13:29:58', 4, '赵芳', 'upload/messages_avatarurl4.jpg', '这个羽毛球包容量大吗？能放几支球拍？', 'upload/messages_cpicture4.jpg', '羽毛球包容量较大，可以放3-4支拍子和其他装备。', 'upload/messages_rpicture4.jpg');
INSERT INTO `messages` VALUES (5, '2026-01-08 13:29:58', 5, '王静', 'upload/messages_avatarurl5.jpg', '服装的面料透气性怎么样？适合夏天穿吗？', 'upload/messages_cpicture5.jpg', '服装采用高透气面料，夏天穿着非常舒适透气。', 'upload/messages_rpicture5.jpg');
INSERT INTO `messages` VALUES (6, '2026-01-08 13:29:58', 6, '陈明', 'upload/messages_avatarurl6.jpg', '握把是否换过新的胶带？手感如何？', 'upload/messages_cpicture6.jpg', '握把胶带是新换的，手感防滑且舒适，适合长时间训练。', 'upload/messages_rpicture6.jpg');
INSERT INTO `messages` VALUES (7, '2026-01-08 13:29:58', 7, '王明', 'upload/messages_avatarurl7.jpg', '你们支持线下验货吗？可以试用一下吗？', 'upload/messages_cpicture7.jpg', '目前暂不支持线下验货，您可以先咨询具体情况，支持7天无理由退换。', 'upload/messages_rpicture7.jpg');
INSERT INTO `messages` VALUES (8, '2026-01-08 13:29:58', 8, '李娜', 'upload/messages_avatarurl8.jpg', '请问有其他颜色的护腕和头带可选吗？', 'upload/messages_cpicture8.jpg', '有的，我们有黑色、白色和蓝色三种护腕和头带供您选择。', 'upload/messages_rpicture8.jpg');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goodtype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品类型',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int(11) NULL DEFAULT NULL COMMENT '购买数量',
  `price` double NULL DEFAULT NULL COMMENT '单价',
  `total` double NULL DEFAULT NULL COMMENT '总价',
  `type` int(11) NULL DEFAULT NULL COMMENT '支付类型',
  `status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `tel` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `consignee` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `userid` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ershoushuji' COMMENT '商品表名',
  `logistics` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '物流',
  `yonghuzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商户名称',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审核回复',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户角色',
  `returnreason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '退货原因',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orderid`(`orderid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (3, '2026-01-09 17:54:42', '202619175442934', 13, 'BG 65 羽毛球线', '羽毛球线', 'upload/1767951792819_829.png', 1, 19, 19, 1, '已支付', '宇宙银河系土星1号', '13823888885', '土某', '', 15, 'ershoushuji', NULL, '105', '', NULL, 'yonghu', NULL);
INSERT INTO `orders` VALUES (4, '2026-01-09 18:56:07', '2026191856719', 17, 'Carbonex 9000 羽毛球拍', '羽毛球拍', 'upload/1767952105938_983.png', 1, 69, 69, 1, '已支付', '宇宙银河系水星1号', '13823888883', '水某', '', 13, 'ershoushuji', NULL, '104', '', NULL, 'yonghu', NULL);
INSERT INTO `orders` VALUES (5, '2026-01-09 18:56:39', '202619185639360', 15, 'Pro Tour 羽毛球服装', '羽毛球服装', 'upload/1767951987997_915.png', 1, 99, 99, 1, '已支付', '宇宙银河系水星1号', '13823888883', '水某', '', 13, 'ershoushuji', NULL, '101', '', NULL, 'yonghu', NULL);

-- ----------------------------
-- Table structure for shujifenlei
-- ----------------------------
DROP TABLE IF EXISTS `shujifenlei`;
CREATE TABLE `shujifenlei`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shujifenlei` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '羽毛球装备分类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '羽毛球装备分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shujifenlei
-- ----------------------------
INSERT INTO `shujifenlei` VALUES (1, '2026-01-08 13:29:57', '羽毛球拍');
INSERT INTO `shujifenlei` VALUES (2, '2026-01-08 13:29:57', '羽毛球鞋');
INSERT INTO `shujifenlei` VALUES (3, '2026-01-08 13:29:57', '羽毛球服装');
INSERT INTO `shujifenlei` VALUES (4, '2026-01-08 13:29:57', '羽毛球包');
INSERT INTO `shujifenlei` VALUES (5, '2026-01-08 13:29:57', '羽毛球线');
INSERT INTO `shujifenlei` VALUES (6, '2026-01-08 13:29:57', '羽毛球握把');
INSERT INTO `shujifenlei` VALUES (7, '2026-01-08 13:29:57', '羽毛球网');
INSERT INTO `shujifenlei` VALUES (8, '2026-01-08 13:29:57', '羽毛球配件');

-- ----------------------------
-- Table structure for storeup
-- ----------------------------
DROP TABLE IF EXISTS `storeup`;
CREATE TABLE `storeup`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `refid` bigint(20) NULL DEFAULT NULL COMMENT '商品id',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片',
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '类型',
  `inteltype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storeup
-- ----------------------------

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `tablename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 1, 'admin', 'users', '管理员', 'w4l0yn8bfk3ewvbg3loupd0hzerfeq9i', '2026-01-08 13:34:02', '2026-01-09 20:20:35');
INSERT INTO `token` VALUES (2, 18, '102', 'yonghu', '用户', 'm6hw9eq13yitv2nniygiqavpdh1svsmo', '2026-01-08 13:34:21', '2026-01-09 18:38:14');
INSERT INTO `token` VALUES (3, 12, '107', 'yonghu', '用户', 'z5jnrxqbgvzitdtb0tghhjzd87euko4t', '2026-01-09 17:13:21', '2026-01-09 18:47:04');
INSERT INTO `token` VALUES (4, 17, '106', 'yonghu', '用户', 'ffud68v9dn0pwqdbfjohuytcm8t00wml', '2026-01-09 17:40:24', '2026-01-09 18:51:12');
INSERT INTO `token` VALUES (5, 16, '103', 'yonghu', '用户', '1sjfn1bpqf9p24ytg3m3s12m3jzbhunv', '2026-01-09 17:41:35', '2026-01-09 18:41:36');
INSERT INTO `token` VALUES (6, 15, '105', 'yonghu', '用户', 's305h3f1pkcgsjdvbf3qv55m44rd7snb', '2026-01-09 17:42:50', '2026-01-09 18:53:59');
INSERT INTO `token` VALUES (7, 14, '108', 'yonghu', '用户', 'qdi9rphynmdurm6g5ye60v1i9wt8seam', '2026-01-09 17:44:11', '2026-01-09 18:45:42');
INSERT INTO `token` VALUES (8, 13, '101', 'yonghu', '用户', '0hg2konkwr0ekh4liyl7nxbvdbqizw1s', '2026-01-09 17:46:04', '2026-01-09 20:27:36');
INSERT INTO `token` VALUES (9, 11, '104', 'yonghu', '用户', '85tlkzplo7fj5ulk1xrzv3fk0imv901p', '2026-01-09 17:48:05', '2026-01-09 18:48:06');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '管理员' COMMENT '角色',
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '2026-01-08 13:29:58', 'admin', 'admin', '管理员', 'upload/image1.jpg');

-- ----------------------------
-- Table structure for yonghu
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yonghuzhanghao` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `yonghuxingming` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户姓名',
  `mima` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `touxiang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '头像',
  `xingbie` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系方式',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审核回复',
  `money` double NULL DEFAULT 0 COMMENT '余额',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `yonghuzhanghao`(`yonghuzhanghao`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES (11, '2026-01-08 13:29:57', '104', '李军', '123456', 'upload/yonghu_touxiang1.jpg', '男', '13467890123', '是', '', 200);
INSERT INTO `yonghu` VALUES (12, '2026-01-08 13:29:57', '107', '刘强', '123456', 'upload/1767950010740_109.png', '男', '13434567890', '是', '', 200);
INSERT INTO `yonghu` VALUES (13, '2026-01-08 13:29:57', '101', '李娜与', '123456', 'upload/yonghu_touxiang3.jpg', '女', '13556789012', '是', '', 32);
INSERT INTO `yonghu` VALUES (14, '2026-01-08 13:29:57', '108', '赵芳', '123456', 'upload/yonghu_touxiang4.jpg', '女', '13490123456', '是', '', 200);
INSERT INTO `yonghu` VALUES (15, '2026-01-08 13:29:57', '105', '王静', '123456', 'upload/yonghu_touxiang5.jpg', '女', '13589012345', '是', '', 181);
INSERT INTO `yonghu` VALUES (16, '2026-01-08 13:29:57', '103', '陈明', '123456', 'upload/yonghu_touxiang6.jpg', '男', '13590123456', '是', '', 200);
INSERT INTO `yonghu` VALUES (17, '2026-01-08 13:29:57', '106', '王明', '123456', 'upload/yonghu_touxiang7.jpg', '男', '13456789012', '是', '', 200);
INSERT INTO `yonghu` VALUES (18, '2026-01-08 13:29:57', '102', '李娜', '123456', 'upload/1767949974099_365.png', '女', '13445678901', '是', '', 0.2);

-- ----------------------------
-- Table structure for youhuihuodong
-- ----------------------------
DROP TABLE IF EXISTS `youhuihuodong`;
CREATE TABLE `youhuihuodong`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huodongmingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动名称',
  `tupian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片',
  `huodongneirong` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '活动内容',
  `huodongriqi` date NULL DEFAULT NULL COMMENT '活动日期',
  `fabushijian` date NULL DEFAULT NULL COMMENT '发布时间',
  `thumbsupnum` int(11) NULL DEFAULT 0 COMMENT '赞',
  `crazilynum` int(11) NULL DEFAULT 0 COMMENT '踩',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '优惠活动' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of youhuihuodong
-- ----------------------------
INSERT INTO `youhuihuodong` VALUES (1, '2026-01-08 13:29:58', '新用户专享折扣', 'upload/1767950873530_362.png', '二手书盲盒惊喜福袋9.9元解锁3本好书', '2026-01-08', '2026-01-08', 1, 1);
INSERT INTO `youhuihuodong` VALUES (2, '2026-01-08 13:29:58', '满减狂欢周', 'upload/1767950861688_280.png', '关注店铺领券二手书满60减15长期有效', '2026-01-08', '2026-01-08', 2, 2);
INSERT INTO `youhuihuodong` VALUES (3, '2026-01-08 13:29:58', '限时秒杀抢购', 'upload/1767950848789_701.png', '儿童绘本二手书套装39.9元任选10本', '2026-01-08', '2026-01-08', 3, 3);
INSERT INTO `youhuihuodong` VALUES (4, '2026-01-08 13:29:58', '老客户回馈礼', 'upload/1767950834984_369.png', '二手教材清仓5元/本多买多减', '2026-01-08', '2026-01-08', 4, 4);
INSERT INTO `youhuihuodong` VALUES (5, '2026-01-08 13:29:58', '组合装备套餐优惠', 'upload/1767950819386_344.png', '社科类二手书全场8折会员再享折上折', '2026-01-08', '2026-01-08', 5, 5);
INSERT INTO `youhuihuodong` VALUES (6, '2026-01-08 13:29:58', '节日特别促销', 'upload/1767950805009_582.png', '青春文学二手书清仓处理2本10元', '2026-01-08', '2026-01-08', 6, 6);
INSERT INTO `youhuihuodong` VALUES (7, '2026-01-08 13:29:58', '分享有礼活动', 'upload/1767950792191_210.png', '二手书拼团特惠3人拼团享7折优惠', '2026-01-08', '2026-01-08', 7, 7);
INSERT INTO `youhuihuodong` VALUES (8, '2026-01-08 13:29:58', '购物满额免邮', 'upload/1767950778986_916.png', '精选文学类二手书买2送1包邮到家', '2026-01-08', '2026-01-08', 8, 8);
INSERT INTO `youhuihuodong` VALUES (9, '2026-01-09 19:22:15', '狂欢特惠', 'upload/1767957731004_747.png', '活动期间，所有二手羽毛球装备享受满200减30元优惠，新用户首次购买额外赠送10元优惠券，限时抢购，先到先得！', '2026-01-17', '2026-01-09', 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
