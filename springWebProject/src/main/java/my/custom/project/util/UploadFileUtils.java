package my.custom.project.util;

import java.io.File;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {

	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);

	private String uploadPath = "C:\\Users\\irvin\\Desktop\\eclipse workspace\\springWebProject\\src\\main\\webapp\\resources\\";

	public String getUploadPath(int sel) {
		String path = "";

		if (sel == 0) {
			path = uploadPath + "boardUploadImage";
		} else if (sel == 1) {
			path = uploadPath + "projectUploadImage";
		}

		return path;
	}

	public String uploadFile(int sel, String originalName, byte[] fileData) throws Exception {

		String path = "";

		if (sel == 0) {
			path = uploadPath + "boardUploadImage";
		} else if (sel == 1) {
			path = uploadPath + "projectUploadImage";
		}

		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;

		File target = new File(path, savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;

	}

	
}
