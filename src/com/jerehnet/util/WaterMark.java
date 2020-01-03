package com.jerehnet.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public final class WaterMark {
	public WaterMark() {
	}

	/**
	 * 把图片印刷到图片上
	 * 
	 * @param pressImg
	 *            -- 水印文件
	 * @param targetImg
	 *            -- 目标文件
	 * @param x
	 *            --x坐标
	 * @param y
	 *            --y坐标
	 */
	public final static void pressImage(String pressImg, String targetImg,
			int x, int y) {
		File _file = null;
		Image src = null;
		BufferedImage image = null;
		Graphics g = null;
		File _filebiao = null;
		Image src_biao = null;
		FileOutputStream out = null;
		JPEGImageEncoder encoder = null;
		try {
			// 目标文件
			_file = new File(targetImg);
			src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			image = new BufferedImage(wideth, height,
					BufferedImage.TYPE_INT_RGB);
			g = image.createGraphics();
			g.drawImage(src, x, y, wideth, height, null);

			// 水印文件
			_filebiao = new File(pressImg);
			src_biao = ImageIO.read(_filebiao);
			int wideth_biao = src_biao.getWidth(null);
			int height_biao = src_biao.getHeight(null);
			// g.drawImage(src_biao, (wideth - wideth_biao) / 2, (height -
			// height_biao) / 2, wideth_biao, height_biao,
			// null);
			g.drawImage(src_biao, (wideth - wideth_biao),
					(height - height_biao), wideth_biao, height_biao, null);
			// g.drawImage(src_biao, 10, 10, wideth_biao, height_biao,
			// null);
			// 水印文件结束
			g.dispose();
			out = new FileOutputStream(targetImg);
			encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(image);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			_file = null;
			src = null;
			image = null;
			g = null;
			_filebiao = null;
			src_biao = null;
			out = null;
			encoder = null;
		}
	}

	/** */
	/**
	 * 打印文字水印图片
	 * 
	 * @param pressText
	 *            --文字
	 * @param targetImg
	 *            -- 目标图片
	 * @param fontName
	 *            -- 字体名
	 * @param fontStyle
	 *            -- 字体样式
	 * @param color
	 *            -- 字体颜色
	 * @param fontSize
	 *            -- 字体大小
	 * @param x
	 *            -- 偏移量
	 * @param y
	 */

	public static void pressText(String pressText, String targetImg,
			String fontName, int fontStyle, int color, int fontSize, int x,
			int y) {
		File _file = null;
		Image src = null;
		BufferedImage image = null;
		Graphics g = null;
		FileOutputStream out = null;
		JPEGImageEncoder encoder = null;
		try {
			_file = new File(targetImg);
			src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			image = new BufferedImage(wideth, height,
					BufferedImage.TYPE_INT_RGB);
			g = image.createGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);
			// String s="www.qhd.com.cn";

			// g.setColor(Color.RED);

			g.setColor(Color.LIGHT_GRAY);

			g.setFont(new Font(fontName, fontStyle, fontSize));

			g.drawString(pressText, wideth - fontSize - x, height - fontSize
					/ 2 - y);

			// g.drawString(pressText, 0, height - fontSize / 2 - y);

			g.dispose();
			out = new FileOutputStream(targetImg);
			encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(image);
			out.close();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			_file = null;
			src = null;
			image = null;
			g = null;
			out = null;
			encoder = null;
		}

	}

	public static void main(String[] args) {

		File d = new File(
				"E:\\workspace\\21sun_parts\\WebRoot\\uploadfiles\\ytxiongdi");//
		File f = null;
		File list[] = d.listFiles();// 取得代表目录中所有文件的File对象数组
		for (int i = 0; i < list.length; i++) {
			f = list[i];
			// if (f.getName().indexOf("_small.") > 0)
			// continue;
			// System.out.println(f.getName());
			Common
					.waterMark(
							"E:\\workspace\\21sun_parts\\WebRoot\\images\\watermarkLog.png",
							"E:\\workspace\\21sun_parts\\WebRoot\\uploadfiles\\ytxiongdi/"
									+ f.getName(), 0, 0);
		}
		// System.out.println("length:" + list.length);

		// Common.waterMark(
		// "E:\\workspace\\21sun_parts\\WebRoot\\images\\watermarkLog.png",
		// "E:\\workspace\\21sun_parts\\WebRoot\\uploadfiles/09072217410653_0.jpg",
		// 0, 0);
		// =====加文字的====
		// Common
		// .pressText(
		// "济宁长虹",
		// "E:\\workspace\\21sun_parts\\WebRoot\\uploadfiles/0907091725378_0.jpg",
		// "黑体", Font.BOLD, 0, 32,10,0);

	}
}