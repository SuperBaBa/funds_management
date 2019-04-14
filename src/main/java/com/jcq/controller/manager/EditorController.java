package com.jcq.controller.manager;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;

@Controller
@Scope("prototype")
@RequestMapping("/editor")
public class EditorController {
	@RequestMapping(value = "upload", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String uploads(HttpServletRequest request, @RequestParam("myFileName") MultipartFile file) {
		byte[] bytes = null;
		String uploadDir = request.getSession().getServletContext().getRealPath("/upload/image/");
		String fileName = file.getOriginalFilename();// 得到上传的文件名
		String filePath = uploadDir + fileName;
		BufferedOutputStream bos = null;
		FileOutputStream fos = null;
		System.out.println(uploadDir);
		System.out.println(filePath);
		try {
			bytes = file.getBytes();
			File temp = new File(filePath);
			if (!temp.exists()) {
				temp.createNewFile();
			}
			System.out.println(temp.getAbsolutePath());
			fos = new FileOutputStream(temp);
			bos = new BufferedOutputStream(fos);
			bos.write(bytes);
			bos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bos != null) {
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					if (fos != null) {
						try {
							fos.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		System.out.println(request.getContextPath() + fileName);
		// 根据wangEditor的服务端接口，造一个JSON对象返回
		JSONObject json = new JSONObject();
		JSONArray array = new JSONArray();
		array.add(request.getContextPath()+"/upload/image/" + fileName);// 将图片的引用url放入JSON返回给富文本编辑器进行回显
		json.put("errno", 0);
		json.put("data", array);
		return json.toString();
	}
}