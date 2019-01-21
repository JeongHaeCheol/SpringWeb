package my.custom.project.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import my.custom.project.util.MediaUtils;
import my.custom.project.util.UploadFileUtils;

@Controller
public class UploadController {

	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	private UploadFileUtils uploadFileUtils = new UploadFileUtils();

	
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(@RequestParam int sel, String fileName) throws Exception {

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		logger.info("File Name: " + fileName);

		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			
			logger.info("File Name included path : " + uploadFileUtils.getUploadPath(sel) + "\\" + fileName);

			in = new FileInputStream(uploadFileUtils.getUploadPath(sel) + "\\" +  fileName);

		
			
			
			if (mType != null) {
				headers.setContentType(mType);
			} else {

				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
						"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}

		return entity;

	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(int sel, String fileName) {
		
		logger.info("delete file: " + fileName);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) {
			
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadFileUtils.getUploadPath(sel) + (front + end).replace('/', File.separatorChar)).delete();
		}
		
		new File(uploadFileUtils.getUploadPath(sel) + fileName.replace('/', File.separatorChar)).delete();
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
		
		
	}
}
