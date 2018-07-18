/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.1.48-log : Database - qdm119567219_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `dblog_admin` */

DROP TABLE IF EXISTS `dblog_admin`;

CREATE TABLE `dblog_admin` (
  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID，表主键',
  `account` varchar(32) NOT NULL COMMENT '管理员账号',
  `password` varchar(200) NOT NULL COMMENT '管理员密码',
  `gmt_create` datetime NOT NULL COMMENT '管理员创建时间',
  `gmt_modify` datetime NOT NULL COMMENT '管理员更新时间',
  `operator` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员操作人',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='DBLOG-管理员表';

/*Data for the table `dblog_admin` */

insert  into `dblog_admin`(`admin_id`,`account`,`password`,`gmt_create`,`gmt_modify`,`operator`) values (1,'赖道斌','$2y$10$D0iUBEcXY52ScPmRdrJmkusSbORZEcDQBmkJY9ywn1qMHzWevzrEa','2017-08-15 16:09:28','2017-08-15 16:09:31','');

/*Table structure for table `dblog_category` */

DROP TABLE IF EXISTS `dblog_category`;

CREATE TABLE `dblog_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '品类ID，表主键',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级品类ID',
  `title` varchar(32) NOT NULL COMMENT '品类标题',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '品类描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '品类状态，1为可用，0为不可用',
  `sort` int(4) NOT NULL DEFAULT '0' COMMENT '品类排序，值越小排越前',
  `image_path_file` varchar(200) NOT NULL DEFAULT '' COMMENT '品类图片',
  `gmt_create` datetime NOT NULL COMMENT '品类创建时间',
  `gmt_modify` datetime NOT NULL COMMENT '品类更新时间',
  `operator` varchar(32) NOT NULL COMMENT '品类操作人',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='DBLOG-品类表';

/*Data for the table `dblog_category` */

insert  into `dblog_category`(`category_id`,`parent_id`,`title`,`description`,`status`,`sort`,`image_path_file`,`gmt_create`,`gmt_modify`,`operator`) values (1,0,'WEB前端','HTML(5) + CSS(3) + JS',1,1,'','2017-08-15 16:39:17','2017-08-17 14:38:29','赖道斌'),(2,0,'PHP','Apache、Mysql等与PHP相关技术',1,2,'','2017-08-15 16:40:23','2017-08-17 14:38:39','赖道斌'),(3,0,'闲谈杂聊','说说自己的态度和观点',1,3,'','2017-08-15 16:40:53','2017-08-15 16:40:53','赖道斌'),(5,3,'WEB开发思路','',1,0,'/upload/category/20170817/thinking_640_400.jpg','2017-08-15 16:42:24','2017-08-17 14:21:20','赖道斌'),(6,1,'JavaScript','',1,0,'/upload/category/20170817/cate_javascript.png','2017-08-15 16:42:52','2017-08-17 14:14:18','赖道斌'),(12,3,'学习计划','',1,100,'/upload/category/20170817/learning_plan_580_340.jpg','2017-08-16 11:20:47','2017-08-17 14:22:26','赖道斌'),(13,0,'C/C++','',1,2,'','2017-08-17 14:34:39','2017-08-17 14:42:22','赖道斌'),(14,0,'Python','',0,2,'','2017-08-17 14:35:11','2017-08-17 14:35:11','赖道斌'),(15,0,'Java','',0,2,'','2017-08-17 14:35:32','2017-08-17 14:35:32','赖道斌'),(16,15,'JavaSE','',0,1,'','2017-08-17 14:36:11','2017-08-17 14:36:11','赖道斌'),(17,15,'JavaEE','',0,2,'','2017-08-17 14:36:26','2017-08-17 14:36:26','赖道斌'),(18,0,'关于我的','',0,8,'','2017-08-25 16:31:15','2017-08-25 17:14:01','赖道斌'),(19,18,'我的工作','',0,0,'','2017-08-25 16:32:03','2017-08-25 16:32:03','赖道斌'),(20,18,'赖道斌的绿皮“书”','个人学习整理笔记，记录成册，便于以后使用',1,0,'/upload/category/20180131/ldb_green_books.png','2018-01-31 13:29:20','2018-01-31 13:29:20','赖道斌');

/*Table structure for table `dblog_jobs` */

DROP TABLE IF EXISTS `dblog_jobs`;

CREATE TABLE `dblog_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dblog_jobs` */

/*Table structure for table `dblog_product` */

DROP TABLE IF EXISTS `dblog_product`;

CREATE TABLE `dblog_product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品ID，表主键',
  `category_id` int(11) NOT NULL COMMENT '产品所在品类ID',
  `title` varchar(64) NOT NULL COMMENT '产品标题',
  `description` text COMMENT '产品描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '产品状态，1为可用，0为不可用',
  `sort` int(4) NOT NULL DEFAULT '0' COMMENT '产品排序，值越小排越前',
  `image_path_file` varchar(200) NOT NULL DEFAULT '' COMMENT '产品图片',
  `page_view` int(11) NOT NULL DEFAULT '0' COMMENT 'PV：访问量',
  `gmt_create` datetime NOT NULL COMMENT '产品创建时间',
  `gmt_modify` datetime NOT NULL COMMENT '产品更新时间',
  `operator` varchar(32) NOT NULL COMMENT '产品操作人',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='DBLOG-产品表';

/*Data for the table `dblog_product` */

insert  into `dblog_product`(`product_id`,`category_id`,`title`,`description`,`status`,`sort`,`image_path_file`,`page_view`,`gmt_create`,`gmt_modify`,`operator`) values (1,2,'PHP的mysql_connect()连接失败的几个原因','<p>\r\n	呼啦啦，在本地执行mysql_connect()方法时，报了一个致命的错误【Fatal error: Call to undefined function mysql_connect() in E:\\Apache_2_4\\htdocs\\www.laidaobin.com\\includes\\config\\db_mysql.php on line 22】，很是神奇！</p>\r\n<p>\r\n	好吧，百度一下：各种答案，有的说数据库服务器没打开，有的说数据库用户名、密码错了，有的说php.ini文件的extension=php_mysql.dll没有打开； 然后这些答案在各网站 复制来粘贴去，千篇一律啊！关键是没有解决我的问题，因为我的数据库是找开的，数据库用户名和密码是正确的，php.ini配置文件中的php_mysql.dll也是打开的，苦笑中...</p>\r\n<p>\r\n	好不容易在XX网站上有看到一网友说是php.ini配置文件中【extension_dir = \"xxx\"】问题，好家伙，连接成功了。成功来之不易啊！</p>\r\n<p>\r\n	PHP的mysql_connect()连接失败的原因可以从以下几个方面排查，如下：</p>\r\n<p>\r\n	1、数据库已启动，链接数据库的地址、端口、用户名、密码正确。（地球人都知道的事，哈哈）</p>\r\n<p>\r\n	2、php.ini文件中extension_dir的值是数据库安装目录下的ext目录，例如：extension_dir = \"E:\\php_5_4_38\\ext\"，同时有开启extension = php_bz2.dll、extension = php_gd2.dll、extension = php_mysql.dll</p>\r\n<p>\r\n	我这次出错的原因就是php.ini文件中extension_dir的值错了。啊，崩溃！！</p>\r\n<p>\r\n	顺便说一下Apache服务器引用php.ini文件的目录可在Apache的httpd.conf中PHPIniDir进行配置，没找到就直接添加，例如：PHPIniDir \"E:/php_5_4_38\"。</p>',1,0,'',146,'2015-07-05 01:20:41','2017-09-01 09:28:11','赖道斌'),(2,5,'思路2015-08-26','<p>\r\n	每隔一些时间的开发经验总结：</p>\r\n<p>\r\n	 </p>\r\n<p>\r\n	1、页面无刷新的图片上传：可以使用Iframe实现，该方法使用方便简单有效</p>\r\n<p>\r\n	 </p>\r\n<p>\r\n	2、汉字的正则匹配规则：</p>\r\n<p>\r\n	PHP版本：/^[x{4E00}-x{9FA5}]+$/u</p>\r\n<p>\r\n	JS版本：/^[x{4E00}-x{9FA5}]+$/</p>\r\n<p>\r\n	从这两个版本中，我们可以发现，PHP版本的需要在后面添加u属性，JS版本的则不需要，这是亮点，也是关键点</p>\r\n<p>\r\n	 </p>\r\n<p>\r\n	3、Form表单的多文件上传：在Input控件元素添加属性multiple</p>\r\n<p>\r\n	 </p>',1,0,'/upload/product/20170816/thinking_640_400.jpg',112,'2015-08-26 09:37:26','2017-08-16 10:05:44','赖道斌'),(3,6,'jQuery垂直定位到某标签元素','<p>\r\n	jQuery垂直定位到某标签元素，经验证，功能实现简单有效</p>\r\n<p>\r\n	举例：现需要将滚动条经过1秒的时间滑动到标签元素ID为write_review_box的高度</p>\r\n<p>\r\n<pre class=\"brush: js;\">\r\n$(\'html, body\').animate({\r\n  scrollTop: $(\'#write_review_box\').offset().top + \'px\'\r\n}, 1000);\r\n</pre>\r\n</p>',1,0,'/upload/product/20170817/jquery_350_230.jpg',140,'2015-09-09 17:19:37','2017-08-17 15:32:09','赖道斌'),(4,1,'如何屏蔽由于浏览器的记录导致的文本域自动填充？','<p>\r\n	相信很多朋友都有这样类似的经历：WEB前台技术中Input标签时常会自动填充一些默认值，这些默认值从何而来，如何屏蔽，这些都是老生常谈的问题了。</p>\r\n<p>\r\n	当前正好我又一次遇到了此神奇般的问题。说它神奇，是因为在之前我就已经通过autocomplete=\"off\"表单属性做过了浏览器自动填充input的屏蔽操作，可是现在又出现了。你说神奇不神奇？</p>\r\n<p>\r\n	好吧，不管神不神奇，问题的出现总是有原因的。OK，原来是在登录网站的时候，浏览器弹出是否保存记录的时候，我选择了保存。这个时候，autocomplete=\"off\"设置可能就会失效了（与浏览器及其版本有关）。如何是好啊？？其实也是简单。</p>\r\n<p>\r\n	首先我们要知道的是，浏览器是根据input标签的type=\"password\"进行判断的。既然如此，就有两种办法解决，根据业务需要了。第一、将password类型改成其他类型。第二、加上一个无用的password类型的input，并隐藏此input标签，如：</p>\r\n<pre class=\"brush: xml;\">\r\n<input style=\"display:none;\" type=\"password\" value=\"\" /></pre>\r\n<p>\r\n	综上，我们可以知道这些默认值来源于浏览器本身缓存。为了比较完美的解决这个问题，我们可以将以上所述的两种方案一起组合使用。</p>\r\n<p>\r\n	1、添加autocomplete=\"off\"</p>\r\n<p>\r\n	2、添加一个与业务无关的隐藏密码域</p>\r\n<p>\r\n	另外，在网络资料中还看到说可以通过启用HTTPS协议阻止浏览器对表单信息进行保存。这一点或许有用，因为我也没尝试过。哈哈  >_^</p>\r\n<p>\r\n	 </p>\r\n<p>\r\n	 </p>',0,0,'',0,'2015-12-16 15:18:55','2017-08-16 09:14:38','赖道斌'),(5,6,'SeaJS简介','<p>\r\n	<strong>SeaJS是什么？</strong></p>\r\n<p>\r\n	SeaJS的作者是前淘宝UED的玉伯。</p>\r\n<p>\r\n	SeaJS是一个遵循CommonJS规范的JavaScript模块加载框架，可以实现JavaScript的模块化开发及加载机制。</p>\r\n<p>\r\n	SeaJS 遵循MIT 协议，无论个人还是公司，都可以免费自由使用。</p>\r\n<p>\r\n	 </p>\r\n<p>\r\n	<strong>为什么使用SeaJS？</strong></p>\r\n<p>\r\n	SeaJS 追求简单、自然的代码书写和组织方式，具有以下核心特性：</p>\r\n<p>\r\n	1、简单友好的模块定义规范，遵循CMD规范</p>\r\n<p>\r\n	2、自然直观的代码组织方式，依赖的自动加载、配置的简洁清晰，可以让我们更多地享受编码的乐趣</p>\r\n<p>\r\n	3、还提供常用插件，非常有助于开发调试和性能优化，并具有丰富的可扩展接口</p>\r\n<p>\r\n	 </p>',0,0,'',63,'2016-03-22 22:15:46','2017-08-16 09:15:18','赖道斌'),(6,3,'IE浏览器下给INPUT标签加一个A标签链接','<p>\r\n	今天发现一个比较神奇的问题，就是给INPUT标签加一个A标签链接，结果发现在IE浏览器下点击这个INPUT死活无法打开新的链接，当前的版本是IE8，不算太低的版本了吧。</p>\r\n<p>\r\n	上网查了一下资料，很多人也遇到过此类问题。所以了，很多人就又开始了轰击模式，对IE大大吐槽，说IE兼容性太差、技术太低什么的，比起其他主流的浏览器，如火狐、谷歌等简直弱爆了。</p>\r\n<p>\r\n	其实这些都是表象而以，在我个人看来，虽然这些情况确实是存在的，但凡事都是有两面性的。兼容性差的另一面就是严格，因为IE在解析HTML标签的时候相对严格，所以就特别需要我们在写HTML的时候更加小心严谨。就好比这个问题，为什么要给INPUT加一个A链接呢？这件事本身就比较奇怪，所以也就不能怪人家IE不去识别了吧。所以说，如果我们自己不去做一些本身就很不合情理的事情，那么还会这些神奇的问题吗？</p>\r\n<p>\r\n	所以从我们自己认真严谨开始吧。不用再抱怨吐槽，因为就算如此也是解决不了问题的。</p>',0,0,'',0,'2016-03-24 12:05:31','2017-08-16 09:11:05','赖道斌'),(7,12,'学习计划','<br/>\r\n<p><span style=\"font-weight:bold; color:#ff0000;\">时刻保持着学习的态度去生活、工作</span></p>\r\n<br/><br/>\r\n<p><b>2017下半年学习计划总要</b></p>\r\n<p>2017年08月：C语言基础知识温习</p>\r\n<p>2017年08-12月：英语读写的学习，含基础单词2000个和基础语法</p>\r\n<p>2017年08-12月：代码整洁之道《Clean Code》，学习并实践</p>\r\n<br/>\r\n<p><b>2018上半年学习计划总要</b></p>\r\n<p>每日完成10个左右的英语单词量的学习、复习，或者一两篇英语文章的阅读（防止生疏）</p>\r\n<p>不定期地重复温习PHP基础技术和C语言相关技术知识（基础很重要）</p>\r\n<p>3月份，英语学习，完成有道精品课《太极语法》</p>\r\n<p>4月份，PHP框架Laravel学习（多学习一种框架总是好的，可以学习到不同的优秀思想，拓展编程思维）</p>\r\n<p>5月份，Linux基础知识温习巩固，以及深入学习、研究</p>\r\n<p>6月份，Mysql的基础知识温习巩固，以及深入学习、研究</p>',0,0,'/upload/product/20170817/learning_plan_580_340.jpg',175,'2017-08-16 11:39:01','2018-05-02 14:11:35','赖道斌'),(8,13,'用一篇文章阐述C语言基础知识','<p><b>C语言</b>之所以命名为C，是因为C语言源自 Ken Thompson 发明的B语言，而B语言则源自BCPL语言。1972年，美国贝尔实验室的 D.M.Ritchie 在B语言的基础上最终设计出了一种新的语言，他取了BCPL的第二个字母作为这种语言的名字，这就是C语言。C语言是一种计算机编程语言，为强类型语言。何为强类型语言？<b>强类型语言</b>一旦确定了数据类型，就不能再赋值其他类型的数据，除非对数据类型进行转换。相对<b>弱类型语言</b>而言，则没有这种限制，一个变量，可以先赋值为整数，然后再赋值为字符串。</p>\r\n<br/>\r\n<p><b>数据类型</b>：基本类型（整型short/int/long、浮点型float/double、字符char）、构造类型（数组、结构体、共用体、枚举）、指针类型、空类型void。</p>\r\n<p>C语言中只有字符类型，并没有字符串这种数据类型。在C语言中，所谓的字符串实际上是字符数组。</p><br/>\r\n<p>由程序员显式进行的转换称为<b>强制类型转换</b>。除了强制类型转换，在不同数据类型的混合运算中编译器也会隐式地进行数据类型转换，称为<b>自动类型转换</b>。自动类型转换遵循下面的规则：</p>\r\n<p>1、若参与运算的数据类型不同，则先转换成同一类型，然后进行运算。</p>\r\n<p>2、转换按数据长度增加的方向进行，以保证精度不降低。例如int型和long型运算时，先把int量转成long型后再进行运算。</p>\r\n<p>3、所有的浮点运算都是以双精度进行的，即使仅含float单精度量运算的表达式，也要先转换成double型，再作运算。</p>\r\n<p>4、char型和short型参与运算时，必须先转换成int型。</p>\r\n<p>5、在赋值运算中，赋值号两边的数据类型不同时，需要把右边表达式的类型将转换为左边变量的类型。如果右边表达式的数据类型长度比左边长时，将丢失一部分数据，这样会降低精度。</p>\r\n<br/>\r\n<p><b>标识符</b>就是程序员自己定义的名字，除了变量名，还有函数名、宏名、结构体名等。C语言规定，标识符只能由字母、数字和下划线组成，并且第一个字符必须是字母或下划线。</p>\r\n<p>而<b>关键字（Keywords）</b>是由C语言规定的具有特定意义的字符串，通常也称为<b>保留字</b>，例如 int、char、long、float、unsigned 等。我们定义的标识符不能与关键字相同，否则会出现错误。</p>\r\n<br/>\r\n<p><b>注释（Comments）</b>可以出现在代码中的任何位置，用来向用户提示或解释程度的意义。程序编译时，会忽略注释，不做任何处理，就好像它不存在一样。C语言支持单行注释和多行注释：</p>\r\n<p>1、单行注释以//开头，直到本行末尾（不能换行）。</p>\r\n<p>2、多行注释以/*开头，以*/结尾，注释内容可以有一行或多行。</p>\r\n<br/>\r\n<p><b>运算符</b>是一种告诉编译器执行特定的数学或逻辑操作的符号。C语言内置了丰富的运算符，并提供了以下类型的运算符：</p>\r\n<p>1、赋值运算符（=不是等号，是赋值的意思）</p>\r\n<p>2、算术运算符（+加、-减、*乘、/除、%求余、++自加1、--自减1）</p>\r\n<p>3、关系运算符（==相等、!=不等、>大于、<小于、>=大于等于、<=小于等于）</p>\r\n<p>4、逻辑运算符（&&逻辑与、||逻辑或、!逻辑非）</p>\r\n<p>5、位运算符（&位与、|位或、^位异或、~取反、<<左移、>>右移）</p>\r\n<p>其中的<b>运算符优先级</b>，就是当有多个运算符在同一个表达式中出现时，先执行哪个运算符。如果不想按照默认的规则执行，可以加()。<b>运算符结合性</b>，就是当一个运算符多次出现时，先执行哪个运算符。先执行右边的叫右结合性，先执行左边的叫左结合性。</p>\r\n<br/>\r\n<p>程序结构：<b>顺序结构</b>，由上往下执行；<b>选择结构</b>，if..else...语句，switch语句；<b>循环结构</b>，for循环，while循环，do...while循环</p>\r\n<p>在程序设计中，为了处理方便，把具有相同类型的若干变量按有序的形式组织起来。这些按序排列的同类数据元素的集合称为<b>数组</b>。</p>\r\n<p><b>函数（Function）</b>是一段可以重复使用的代码，除了C语言自带的函数，我们也可以编写自己的函数，称为自定义函数（User-Defined Function）。</p>\r\n<br/>\r\n<p>C语言中除了以上的基本概念，还有诸如<b>指针</b>、<b>结构体</b>、<b>联合体（也叫共用体）</b>等概念。由于这些概念无法用一两句文字语言描述清楚，所以在这里知道有这些概念即可。后续我们再一一道来。</p>\r\n',1,0,'/upload/product/20170817/c_jichu_300_200.png',233,'2017-08-17 14:40:48','2017-10-18 09:58:12','赖道斌'),(9,19,'2017年8月工作效率之开发效率小结','<p>近一两个月以来，我发现工作中的一个问题非常地影响工作任务的完成进度。</p><br/>\r\n<p>是什么问题呢？这个问题就是预估的开发时间与实际的开发时间相差较大，我个人总结主要因素如下：</p>\r\n<p>1、团队之间协作力度不够（在你们的观念中，什么是团队，你们对团队的定义是什么？）</p>\r\n<p>2、对项目的现有业务不熟</p>\r\n<p>3、对自我能力、自我目标的定位不清楚</p>\r\n<p>4、遇到问题长时间无法解决时，不懂寻求帮助，死磕到底（精神可佳，但不适合工作，特别是有时间规定的时候）。</p>\r\n<p>5、Bug修复时间占比太大，例如一个需求的开发时间是1天，开发结束后Bug修复时间又花了半天，甚至更多。（该点尤其突出）</p><br/><br/>\r\n<p><b style=\"color:#f00;\">针对以上问题，我们该如何解决？？？</b></p>',0,0,'/upload/product/20170825/work_efficiency_570_360.jpg',10,'2017-08-25 16:55:38','2017-08-25 21:09:27','赖道斌'),(10,2,'PHP支持的9种原始数据类型','<p>PHP支持9种原始数据类型。</p><br/>\r\n<p>4种标量类型：</p>\r\n<p>boolean（布尔型）、interger（整型）、float（浮点型，也称作double）、string（字符串）</p><br/>\r\n<p>3种复合类型：</p>\r\n<p>array（数组）、object（对象）、callable（可调用）</p><br/>\r\n<p>2种特殊类型：</p>\r\n<p>resource（资源）、NULL（无类型）</p>',1,0,'',209,'2017-09-01 09:27:56','2017-09-01 09:27:56','赖道斌'),(11,18,'助手网址','<p><b>【Linux就该这么学】</b>http://www.linuxprobe.com/</p>',0,0,'',6,'2017-09-05 11:39:05','2017-09-05 11:40:23','赖道斌'),(12,2,'SOCKET编程简述','<p>Socket是什么？用一两句话还真是不好描述清楚。简单地来说，Socket编程是服务端与客户端相互通信的一种编程。</p><br/>\r\n<p><img src=\"/image/upload/product/20170906/php-socket_400_200.png\" /></p><br/>\r\n<p>在实际开发中，PHP Socket编程主要用到的几个函数有：</p>\r\n<p>1、<b>socket_create</b> — 创建一个套接字（通讯节点）</p>\r\n<p>2、<b>socket_bind</b> — 给套接字绑定服务名称（地址和端口）</p>\r\n<p>3、<b>socket_listen</b> — 监听套接字的连接</p>\r\n<p>4、<b>socket_accept</b> — 从套接字上获取套接字资源</p>\r\n<p>5、<b>socket_read</b> — 读取套接字资源数据</p>\r\n<p>6、<b>socket_write</b> — 将数据写入套接字中</p>\r\n<p>7、<b>socket_close</b> — 关闭套接字（资源）</p>\r\n<p>8、<b>socket_connect</b> — 客户端连接到套接字</p><br/>\r\n<p>以上主要函数中，服务端用到的函数有socket_create、socket_bind、socket_listen、socket_accept、socket_read、socket_write、socket_close，客户端面用到的函数有socket_create、socket_connect、socket_write、socket_read、socket_close。</p>\r\n<p>另外，在运行Socket相关应用程序是时，服务端的Socket程序应该先打开执行，然后再执行客户端相关Socket程序。</p>',1,0,'/upload/product/20170906/php-socket.png',245,'2017-09-06 14:47:33','2017-09-06 17:13:57','赖道斌'),(13,18,'技术新发现','<p>2017-09-06：</p>\r\n<p><b>WebSocket</b>，是基于TCP的一种新的网络协议，实现了浏览器与服务器全双工(full-duplex)通信——允许服务器主动发送信息给客户端。</p>\r\n<br/>\r\n<p>2017-09-07：</p>\r\n<p><b>WebRTC</b>，名称源自网页实时通信（Web Real-Time Communication）的缩写，是一个支持网页浏览器进行实时语音对话或视频对话的技术。</p>',0,0,'',9,'2017-09-07 16:13:55','2017-09-07 16:17:52','赖道斌'),(14,6,'图片上传时的图片预览和上传进度','这里记录的是图片上传时的图片预览功能和上传进度条（其他文件上传功能也可加以参考）。',0,0,'',43,'2017-10-17 15:12:32','2017-11-30 09:38:30','赖道斌'),(15,2,'PHP扩展安装注意事项','<p>PHP扩展下载地址，http://pecl.php.net/package/扩展名</p>\r\n<p>如需要安装PHP的Redis扩展，那么下载地址是http://pecl.php.net/package/redis</p>\r\n<br/><br/>\r\n<p>安装PHP扩展注意事项：</p>\r\n<p>1、PHP版本</p>\r\n<p>2、PHP编译运行库，如VC9/VC11/VC15</p>\r\n<p>3、安装PHP的服务器位宽，如32位、64位</p>\r\n<p>4、PHP是否为线程安全</p>',1,0,'/upload/product/20171030/Koala.jpg',162,'2017-10-30 18:35:54','2017-10-30 18:38:41','赖道斌'),(16,19,'2017年丰淘客网站项目需求任务','1、PC端改版\r\n2、M端改版\r\n3、小程序\r\n4、开店系统改版\r\n5、网站多语言翻译',0,0,'',1,'2017-11-13 15:07:30','2017-11-13 15:07:30','赖道斌'),(17,5,'编码中遇到的问题及解决','<p><b>一、服务接口调用的限流处理（特别是在大流量的时候对服务器的性能有很明显减压效果）</b></p>\r\n<p>1、启动程序阻塞模式（如果可以的话）</p>\r\n<p>2、定时定量限制</p>',0,0,'',6,'2017-11-30 09:50:26','2017-11-30 09:50:26','赖道斌'),(18,19,'工作上的一些事','<br/><br/>\r\n<b>关于网站安全问题报告，针对网站LPP、BC、HTL、FTK的以下6个点说明：</b><br/><br/>\r\n1、后台数据操作时的CSRF处理<br/>\r\n2、前台数据操作时的CSRF处理<br/>\r\n<br/>\r\n3、后台数据操作时的XSS处理<br/>\r\n4、后台数据展示时的XSS处理<br/>\r\n5、前台数据操作时的XSS处理<br/>\r\n6、前台数据展示时的XSS处理<br/>\r\n<br/>\r\n(<br/>\r\n其中：<br/>\r\n1、BC后台数据操作有统一进行XSS处理，LPP、HTL、FTK没有统一处理（部分有做、部分未做，需要统一处理）<br/>\r\n2、LPP、BC、HTL、FTK后台数据操作没有CSRF处理<br/>\r\n3、LPP、BC、HTL、FTK前台数据操作没有XSS、CSRF处理<br/>\r\n4、LPP、BC、HTL、FTK前台数据展示部分有XSS处理，部分没有<br/>\r\n)<br/><br/>\r\n（<br/>\r\n以下为参考解决方案：<br/>\r\n1、对于后台数据操作统一XSS处理，而不是分开处理，怕有遗漏<br/>\r\n2、对于后台数据操作重要部分CSRF处理（重要部分，如：管理员功能、订单编辑功能等）<br/>\r\n3、对于前后台数据展示XSS处理，可以全部处理，也可以重要部分处理（因为后台数据操作时已经有处理过了）<br/>\r\n4、对于前台数据操作重要部分CSRF处理（重要部分，如：订单确认支付）<br/>\r\n）<br/>',0,0,'',6,'2017-12-01 13:19:10','2017-12-01 13:19:54','赖道斌'),(19,18,'个人','个人',0,0,'/upload/product/20180122/ldb_zm2.jpg',0,'2018-01-22 15:07:18','2018-01-22 15:07:18','赖道斌'),(20,6,'JS实用小功能','<p><b>举例一：点击按钮事件，将分享链接复制到剪切板</b></p>\r\n<p>\r\n<pre class=\"brush: js;\">\r\nfunction click_event(){\r\n    //选中ID为J_share_url的input或textarea元素标签\r\n    document.getElementById(\'J_share_url\').select();\r\n    //将选中元素值复制到剪切板\r\n    document.execCommand(\'copy\');\r\n}\r\n</pre>\r\n</p>',1,0,'',109,'2018-01-29 18:56:08','2018-01-29 18:56:08','赖道斌'),(21,19,'2018纵腾工作计划','<p><b>2018.04</b></p>\r\n<p>\"纵腾小学\"开学啦~~~校长，DBG，带你开启学习旅途！</p>\r\n<p>小学开设课程科目：开发技术课（PHP基础与扩展、工作中涉及技术分析、其他高兴技术）、产品课（主要讲解现有系统需求说明）、英语课（主要是语法课，让语法带着单词飞）</p>\r\n<p>开课老师：三人行、必有我师。达者为师，所以每一个人都可以是老师。</p>',0,0,'',1,'2018-03-26 09:57:09','2018-03-26 09:57:09','赖道斌'),(22,5,'MySQL实用sql语句','SELECT \r\n  CONCAT(\r\n    \'ALTER TABLE \',\r\n    `TABLE_NAME`,\r\n    \' RENAME TO \',\r\n    REPLACE(`TABLE_NAME`, \'ec_\', \'gm_\'),\r\n    \';\'\r\n  ) \r\nFROM\r\n  `information_schema`.`TABLES` \r\nWHERE `TABLE_SCHEMA` = \'website_ec-base-dev\' \r\n  AND `TABLE_NAME` LIKE \'ec_%\' ;',0,0,'',7,'2018-04-09 14:47:43','2018-04-09 14:47:43','赖道斌');

/*Table structure for table `test_admin` */

DROP TABLE IF EXISTS `test_admin`;

CREATE TABLE `test_admin` (
  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID，表主键',
  `account` varchar(32) NOT NULL COMMENT '管理员账号',
  `password` varchar(200) NOT NULL COMMENT '管理员密码',
  `gmt_create` datetime NOT NULL COMMENT '管理员创建时间',
  `gmt_modify` datetime NOT NULL COMMENT '管理员更新时间',
  `operator` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员操作人',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='DBLOG-管理员表';

/*Data for the table `test_admin` */

insert  into `test_admin`(`admin_id`,`account`,`password`,`gmt_create`,`gmt_modify`,`operator`) values (1,'dblog','$2y$10$D0iUBEcXY52ScPmRdrJmkusSbORZEcDQBmkJY9ywn1qMHzWevzrEa','0000-00-00 00:00:00','0000-00-00 00:00:00','');

/*Table structure for table `test_category` */

DROP TABLE IF EXISTS `test_category`;

CREATE TABLE `test_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '品类ID，表主键',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级品类ID',
  `title` varchar(32) NOT NULL COMMENT '品类标题',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '品类描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '品类状态，1为可用，0为不可用',
  `sort` int(4) NOT NULL DEFAULT '0' COMMENT '品类排序，值越小排越前',
  `image_path_file` varchar(200) NOT NULL DEFAULT '' COMMENT '品类图片',
  `gmt_create` datetime NOT NULL COMMENT '品类创建时间',
  `gmt_modify` datetime NOT NULL COMMENT '品类更新时间',
  `operator` varchar(32) NOT NULL COMMENT '品类操作人',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='DBLOG-品类表';

/*Data for the table `test_category` */

insert  into `test_category`(`category_id`,`parent_id`,`title`,`description`,`status`,`sort`,`image_path_file`,`gmt_create`,`gmt_modify`,`operator`) values (1,0,'WEB前端','HTML + CSS + JS',1,0,'','2017-08-25 13:45:04','2017-08-25 13:45:04','dblog'),(2,0,'PHP','',1,0,'','2017-08-25 13:45:23','2017-08-25 13:45:43','dblog');

/*Table structure for table `test_product` */

DROP TABLE IF EXISTS `test_product`;

CREATE TABLE `test_product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品ID，表主键',
  `category_id` int(11) NOT NULL COMMENT '产品所在品类ID',
  `title` varchar(64) NOT NULL COMMENT '产品标题',
  `description` text COMMENT '产品描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '产品状态，1为可用，0为不可用',
  `sort` int(4) NOT NULL DEFAULT '0' COMMENT '产品排序，值越小排越前',
  `image_path_file` varchar(200) NOT NULL DEFAULT '' COMMENT '产品图片',
  `page_view` int(11) NOT NULL DEFAULT '0' COMMENT 'PV：访问量',
  `gmt_create` datetime NOT NULL COMMENT '产品创建时间',
  `gmt_modify` datetime NOT NULL COMMENT '产品更新时间',
  `operator` varchar(32) NOT NULL COMMENT '产品操作人',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DBLOG-产品表';

/*Data for the table `test_product` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
