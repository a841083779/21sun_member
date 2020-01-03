package com.jerehnet.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImgManager {

	/**
	 * 图像缩放 jpg格式
	 * 
	 * @param imgsrc
	 *            :原图片文件路径
	 * @param imgdist
	 *            :生成的缩略图片文件路径
	 * @param widthdist
	 *            :生成图片的宽度
	 * @param heightdist
	 *            :生成图片的高度
	 */
	public static void reduceImg(String imgsrc, String imgdist, int widthdist,
			int heightdist) {
		try {
			File srcfile = new File(imgsrc);
			if (!srcfile.exists()) {
				return;
			}
			Image src = ImageIO.read(srcfile);

			BufferedImage tag = new BufferedImage((int) widthdist,
					(int) heightdist, BufferedImage.TYPE_INT_RGB);
			/*
			 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
			 */
			tag.getGraphics().drawImage(
					src.getScaledInstance(widthdist, heightdist,
							Image.SCALE_SMOOTH), 0, 0, null);

			FileOutputStream out = new FileOutputStream(imgdist);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(tag);
			out.close();

		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public static void reduceImgGif(String imgsrc, String imgdist,
			int widthdist, int heightdist) {
		try {
			File srcfile = new File(imgsrc);
			if (!srcfile.exists()) {
				return;
			}
			Image src = ImageIO.read(srcfile);

			BufferedImage tag = new BufferedImage((int) widthdist,
					(int) heightdist, BufferedImage.TYPE_INT_RGB);
			/*
			 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
			 */
			tag.getGraphics().drawImage(
					src.getScaledInstance(widthdist, heightdist,
							Image.SCALE_SMOOTH), 0, 0, null);

			// FileOutputStream out = new FileOutputStream(imgdist);
			// JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			// encoder.encode(tag);
			// out.close();
			ImageIO.write(tag, "gif", new File(imgdist));

		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 根据图片路径 读取图片文件
	 * 
	 * @param fileName
	 * @return
	 */
	public static BufferedImage readImage(String fileName) {
		BufferedImage bi = null;
		try {
			bi = ImageIO.read(new File(fileName));
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return bi;
	}

	/**
	 * 生成新的图片文件
	 * 
	 * @param im
	 *            输入的文件名
	 * @param formatName
	 * @param fileName
	 * @return
	 */
	public static boolean writeImage(RenderedImage im, String formatName,
			String fileName) {
		boolean result = false;
		try {
			result = ImageIO.write(im, formatName, new File(fileName));
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return result;
	}

	/**
	 * 转换图片格式 到 jpg
	 * 
	 * @param im
	 * @param fileName
	 * @return
	 */
	public static boolean writeJPEGImage(RenderedImage im, String fileName) {
		return writeImage(im, "JPEG", fileName);
	}

	/**
	 * 转换图片格式 到 gif 不知到好用不
	 * 
	 * @param im
	 * @param fileName
	 * @return
	 */
	public static boolean writeGIFImage(RenderedImage im, String fileName) {
		return writeImage(im, "GIF", fileName);
	}

	public static boolean writePNGImage(RenderedImage im, String fileName) {
		return writeImage(im, "PNG", fileName);
	}

	public static boolean writeBMPImage(RenderedImage im, String fileName) {
		return writeImage(im, "BMP", fileName);
	}

	// =====生成小图==
	public static void main(String args[]) {
		ImgManager.reduceImgGif("c:/log0011.gif", "c:/log0011_x.gif", 77, 67);

	}

}
