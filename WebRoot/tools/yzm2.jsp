<%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" pageEncoding="UTF-8"%>
<%@page import="java.awt.geom.AffineTransform"%>
<%!
Color getRandColor(int fc,int bc){//给定范围获得随机颜色
        Random random = new Random();
        if(fc>255) fc=255;
        if(bc>255) bc=255;
        int r=fc+random.nextInt(bc-fc);
        int g=fc+random.nextInt(bc-fc);
        int b=fc+random.nextInt(bc-fc);
        return new Color(r,g,b);
        }
%>
<%
//设置页面不缓存
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

// 在内存中创建图象
// 通过这里可以修改图片大小
int width=120, height=40;
BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

Graphics2D g2d = image.createGraphics();


// 获取图形上下文
// g相当于笔
//Graphics g = image.getGraphics();

//生成随机类
Random random = new Random();

// 设定背景色
g2d.setColor(getRandColor(200,250));
// 画一个实心的长方，作为北京
g2d.fillRect(0, 0, width, height);

//设定字体
//g2d.setFont(new Font("宋体",Font.PLAIN,20));

//画边框
//g.setColor(new Color());
//g.drawRect(0,0,width-1,height-1);


// 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
g2d.setColor(getRandColor(160,200));
for (int i=0;i<290;i++)
{
	int x = random.nextInt(width);
	int y = random.nextInt(height);
        int xl = random.nextInt(12);
        int yl = random.nextInt(12);
        g2d.drawLine(x,y,x+xl,y+yl);
}

// 取随机产生的认证码(4位数字)
//String rand = request.getParameter("rand");
//rand = rand.substring(0,rand.indexOf("."));
String sRand="";
// 如果要使用中文，必须定义字库，可以使用数组进行定义
// 这里直接写中文会出乱码，必须将中文转换为unicode编码
//百家姓
//String[] str = {"\u738b","\u674e","\u5f20","\u5218","\u9648","\u6768","\u9ec4","\u5434","\u8d75","\u5468","\u5f90","\u5b59","\u9a6c","\u6731","\u80e1","\u6797","\u90ed","\u4f55","\u9ad8","\u7f57","\u90d1","\u6881","\u8c22","\u5b8b","\u5510","\u8bb8","\u9093","\u51af","\u97e9","\u66f9","\u66fe","\u5f6d","\u8427","\u8521","\u6f58","\u7530","\u8463","\u8881","\u4e8e","\u4f59","\u53f6","\u848b","\u675c","\u82cf","\u9b4f","\u7a0b","\u5415","\u4e01","\u6c88","\u4efb","\u59da","\u5362","\u5085","\u949f","\u59dc","\u5d14","\u8c2d","\u5ed6","\u8303","\u6c6a","\u9646","\u91d1","\u77f3","\u6234","\u8d3e","\u97e6","\u590f","\u90b1","\u65b9","\u4faf","\u90b9","\u718a","\u5b5f","\u79e6","\u767d","\u6c5f","\u960e","\u859b","\u5c39","\u6bb5","\u96f7","\u9ece","\u53f2","\u9f99","\u9676","\u8d3a","\u987e","\u6bdb","\u90dd","\u9f9a","\u90b5","\u4e07","\u94b1","\u4e25","\u8d56","\u8983","\u6d2a","\u6b66","\u83ab","\u5b54"};

//数字
String[] str = {"\u4e00","\u4e8c","\u4e09","\u56db","\u4e94","\u516d","\u4e03","\u516b","\u4e5d","\u5341","\u767e","\u5343","\u4e07"};


//String[] str = {"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9"} ;


//准备一些字库备用
Font[] fonts = new Font[]{new Font("新宋体",Font.PLAIN,30),new Font("宋体",Font.PLAIN,30),new Font("楷体_GB2312",Font.PLAIN,30),new Font("黑体",Font.PLAIN,30),new Font("仿宋体_GB2312",Font.PLAIN,30)};
//旋转字体类
AffineTransform at = new AffineTransform();


for (int i=0;i<2;i++){
	int number = random.nextInt(3)-1;  
	double role = number*random.nextDouble()*(Math.PI/2);
	at.setToRotation(role,16*i+9,16);
	//g2d.setTransform(at);
	g2d.setFont(fonts[random.nextInt(1)]);
    String rand=str[random.nextInt(str.length)];
    sRand+=rand;
    // 将认证码显示到图象中
    g2d.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));//调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
    g2d.drawString(rand,46*i+20,26);
    
}
// 将认证码存入SESSION
session.setAttribute("loginRand",sRand);


// 图象生效
g2d.dispose();

// 输出图象到页面
ImageIO.write(image, "JPEG", response.getOutputStream());
out.clear();
out = pageContext.pushBody();
%> 