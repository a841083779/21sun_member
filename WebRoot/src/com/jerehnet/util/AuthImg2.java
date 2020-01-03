package com.jerehnet.util;

import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
import java.util.Vector;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * @author zhuliangjun
 * 
 * @describe 图片验证码
 * 
 */
public class AuthImg2 extends HttpServlet {
	private Font mFont = new Font("Arial Black", Font.PLAIN, 16);

	public void init() throws ServletException {
		super.init();
	}

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);

			String path = request.getRealPath("/");
			// System.out.println(path);
			HttpSession session = request.getSession(true);

			Random random = new Random();

			int products[] = { 1, 2, 3 };
			int product = random.nextInt(2);
			product = products[product];
			product = 1;
			String randName = "";
			if (product == 1) {
				randName = "挖掘机";
			} else if (product == 2) {
				randName = "拖泵车";
			} else if (product == 3) {
				randName = "汽车吊";
			}

			Vector v = new Vector();
			v.add("1");
			v.add("2");
			v.add("3");
			v.add("1");
			v.add("2");
			v.add("3");
			v.add("1");
			v.add("2");
			v.add("3");

			String sRand = "";

			Vector v2 = new Vector();
			for (int i = 0; i < 9; i++) {
				int jj = random.nextInt(v.size());
				String raVal = (String) v.get(jj);
				v2.add(raVal);
				// System.out.println("--"+raVal+"----"+product+"--");
				if (raVal.equals(String.valueOf(product))) {
					// System.out.println(raVal+"----"+product);
					sRand = sRand + i;
				}
				v.remove(jj);
			}
			// System.out.println(product + "-" + randName + "-" + sRand);
			session.setAttribute("regRand", sRand);
			session.setAttribute("regRandName", randName);

			String targetImg = path + "/images/reg/bg.jpg";

			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage image = new BufferedImage(wideth, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = image.createGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);

			// 水印文件
			File _filebiao = null;
			Image src_biao = null;
			int wideth_biao = 50;
			int height_biao = 50;

			for (int i = 0; i < v2.size(); i++) {
				_filebiao = new File(path + "/images/reg/" + (String) v2.get(i)
						+ "-2.gif");
				src_biao = ImageIO.read(_filebiao);
				g.drawImage(src_biao, i * 50 + 1, 1, wideth_biao, height_biao,
						null);
			}

			v = null;
			randName = null;
			products = null;

			// 水印文件结束
			g.dispose();

			OutputStream os = response.getOutputStream();
			ImageIO.write(image, "JPEG", os);
			os.flush();
			os.close();
			os = null;
			response.flushBuffer();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
	}
}
