<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>常用栏目</title>
	<script type="text/javascript" src="/plugin/jquery/jquery.min.js"></script>
	<style type="text/css">
		.par{
			float:left;
			width: 200px;
			margin: 10px;
			border: 1px solid #ccc;
			height: 130px;
			padding: 5px;
			background: #eee;
			overflow: auto;
		}
		ul{list-style: none;}
		ul li{
			font-weight: bold;
			font-size: 16px;
		}
		a{
			text-decoration: none;
			color: #000;
		}
		.par ul{
			margin: 0;
			padding: 0;
			margin-left: 30px;
		}
		.par ul li{
			margin: 0;
			margin-top:5px;
			padding: 0;
			font-size: 14px;
			font-weight: normal;
		}
	</style>
  </head>
  
  <body>
	<div>常用栏目</div>
	<ul>
		<li class="par">供求市场
			<ul>
				<li><a href="/webadmin/market/market_list.jsp?catalogNo=700102" target="_blank">已发供求信息</a></li>
			</ul>
		</li>
		<li class="par">
			租赁网
				<ul>
					<li><a href="/webadmin/rent/rent_list.jsp" target="_blank">求出租管理</a></li>
					<li><a href="/webadmin/other/message_list.jsp?site_flag=1" target="_blank">租赁留言管理</a></li>
					<li><a href="/webadmin/rent/rent_news_list.jsp" target="_blank">租赁新闻管理</a></li>
				</ul>
		</li>
		<li class="par">
			配件网
				<ul>
					<li><a href="/webadmin/parts/buy_list.jsp" target="_blank">配件求购管理</a></li>
					<li><a href="/webadmin/parts/supply_list.jsp" target="_blank">配件供应管理</a></li>
					<li><a href="/webadmin/other/message_part_list.jsp?site_flag=4" target="_blank">配件留言管理</a></li>
				</ul>
		</li>
		<li class="par">
			二手网
				<ul>
					<li><a href="/webadmin/manage/goto.jsp?f=used" target="_blank">求购信息管理</a></li>
					<li><a href="/webadmin/manage/goto.jsp?f=used" target="_blank">出售信息管理</a></li>
				</ul>
		</li>
		<li class="par">
			人才网
				<ul>
					<li><a href="/webadmin/manage/goto.jsp?f=job_zcgl" target="_blank">职场攻略</a></li>
					<li><a href="/webadmin/manage/goto.jsp?f=job_flfg" target="_blank">法律法规</a></li>
					<li><a href="/webadmin/manage/goto.jsp?f=job_hygl" target="_blank">会员管理</a></li>
					<li><a href="/webadmin/manage/goto.jsp?f=job_rcjl" target="_blank">人才简历</a></li>
					<li><a href="/webadmin/manage/goto.jsp?f=job_mfzwsh" target="_blank">免费职位审核</a></li>
					<li><a href="/webadmin/manage/goto.jsp?f=job_czsxx" target="_blank">操作手信息</a></li>
				</ul>
		</li>
		<li class="par">
			会员管理
				<ul>
					<li><a href="/webadmin/member/member_list.jsp" target="_blank">会员管理</a></li>
					<li><a href="/webadmin/other/message_list.jsp?site_flag=3" target="_blank">访客留言</a></li>
					<li><a href="/webadmin/member/applyonline_list.jsp" target="_blank">会员申请</a></li>
				</ul>
		</li>
		<li class="par">
			招投标
				<ul>
					<li><a href="/webadmin/bidding/bidding_bulletin_list.jsp" target="_blank">招投标信息管理</a></li>
					<li><a href="/webadmin/bidding/bidding_news_list.jsp" target="_blank">招标资讯管理</a></li>
					<li><a href="/webadmin/bidding/bidding_organization_list.jsp" target="_blank">招标机构管理</a></li>
				</ul>
		</li>
		<li class="par">
			行业展会
				<ul>
					<li><a href="/webadmin/exhibition/exhibition_list.jsp" target="_blank">行业展会管理</a></li>
					<li><a href="/webadmin/exhibition/exhibition_img_list.jsp" target="_blank">展会播报</a></li>
				</ul>
		</li>
		<li class="par">
			供应商管理
				<ul>
					<li><a href="/webadmin/supply/supply_list.jsp" target="_blank">企业关键词</a></li>
					<li><a href="/webadmin/supply/company_list.jsp" target="_blank">企业大全</a></li>
				</ul>
		</li>
		<li class="par">
			关键词搜索
				<ul>
					<li><a href="/webadmin/keyword/keyword_list.jsp" target="_blank">关键词管理</a></li>
				</ul>
		</li>
		<li class="par">其它
			<ul>
				<li><a href="/webadmin/manage/goto.jsp?f=qikan" target="_blank">电子期刊</a></li>
				<li><a href="/webadmin/manage/goto.jsp?f=spec" target="_blank">专栏管理</a></li>
				<li><a href="/webadmin/link/link_list.jsp" target="_blank">友情链接管理</a></li>
				<li><a href="/webadmin/filter/keyword_list.jsp" target="_blank">过滤关键词管理</a></li>
				<li><a href="/webadmin/filter/filter_log_list.jsp" target="_blank">过滤记录</a></li>
				<li><a href="/webadmin/service/case_list.jsp" target="_blank">成功案例</a></li>
			</ul>
		</li>
	</ul>
  </body>
</html>