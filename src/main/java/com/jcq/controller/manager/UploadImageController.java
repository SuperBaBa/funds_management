package com.jcq.controller.manager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jcq.util.LoadPropertiesDataUtil;
import com.jcq.util.RandomUtil;
import com.jcq.util.StringUtil;


/**
 * 上传图片的controller
 * @author jcq
 *
 */
@Controller
@RequestMapping(value="/resource/upload")

public class UploadImageController {
	@ResponseBody
	@RequestMapping(value="/images",method = RequestMethod.POST)
	public Map<String, Object> images (@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> params = new HashMap<String, Object>();
		if (file == null){
            System.out.println("未获得上传文件!");			
			return null;
		}  
		try{
			 String filetype = request.getParameter("filetype")+"";
			 System.out.println("filetype:"+filetype);
			 String basePath = "";
			 if("image".equals(filetype)){
				 basePath = LoadPropertiesDataUtil.getValue("lixy.uploading.url.image");
			 }else if("file".equals(filetype)){
				 basePath = LoadPropertiesDataUtil.getValue("lixy.uploading.url.file");
			 }
			 if(basePath == null || "".equals(basePath)){
				 basePath = "d:/lixy/static";  //与properties文件中lyz.uploading.url相同，未读取到文件数据时为basePath赋默认值
			 }
			 System.out.println("filename:"+file.getOriginalFilename());
			 String ext = StringUtil.getExt(file.getOriginalFilename());
			 String fileName = String.valueOf(System.currentTimeMillis()).concat("_").concat(RandomUtil.getRandom(6)).concat(".").concat(ext);
			 StringBuilder sb = new StringBuilder();
			 //拼接保存路径
			 sb.append(basePath).append("/").append(fileName);
			 
			 String visitUrl = basePath.concat("/"+fileName);
			 File f = new File(sb.toString());
			 if(!f.exists()){
				 f.getParentFile().mkdirs();
			 }
			 OutputStream out = new FileOutputStream(f);
			 FileCopyUtils.copy(file.getInputStream(), out);
			 params.put("state", "SUCCESS");
			 params.put("url", visitUrl);
			 params.put("size", file.getSize());
			 params.put("original", fileName);
			 params.put("type", file.getContentType());
			 params.put("filename", file.getOriginalFilename());
			 System.out.println("url:"+visitUrl+" original:"+fileName+" filename:"+file.getOriginalFilename()+" type:"+file.getContentType());
		} catch (Exception e){
			 params.put("state", "ERROR");
			 e.printStackTrace();
		}
		 return params;
	}}

