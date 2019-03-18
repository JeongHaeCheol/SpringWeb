package my.custom.project.service;

import java.io.File;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.ProjectDao;
import my.custom.project.model.Board;
import my.custom.project.model.Project;
import my.custom.project.util.UploadFileUtils;

@Service
public class ProjectService {

	@Autowired
	ProjectDao projectDao;

	private static final Logger logger = LoggerFactory.getLogger(ProjectService.class);

	private UploadFileUtils uploadFileUtils = new UploadFileUtils();

	public List<Project> getProjects() {
		return projectDao.getProjects();
	}

	public Project getProject(int projectNo) {
		return projectDao.getProject(projectNo);
	}

	public void create(Project project) {
		convertToHTML(project);
		projectDao.create(project);
	}

	public Project readToReversedHTML(int projectNo) {
		Project project = this.getProject(projectNo);
		reverseToHTML(project);
		return project;
	}

	public void convertToHTML(Project project) {
		String title = project.getTitle();
		String content = project.getContent();
		String envOrTech = project.getEnvOrTech();

		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");

		title = title.replace(" ", "&nbsp;&nbsp;");

		content = content.replace("\n", "<br>");
		envOrTech = envOrTech.replace("\n", "<br>");
		project.setTitle(title);
		project.setContent(content);
		project.setEnvOrTech(envOrTech);
	}

	public void reverseToHTML(Project project) {
		String title = project.getTitle();
		String content = project.getContent();
		String envOrTech = project.getEnvOrTech();

		title = title.replace("&lt", "<");
		title = title.replace("&gt", ">");

		title = title.replace("&nbsp;&nbsp;", " ");

		content = content.replace("<br>", "\n");
		envOrTech = envOrTech.replace("<br>", "\n");
		project.setTitle(title);
		project.setContent(content);
		project.setEnvOrTech(envOrTech);
	}

	public void update(Project project) {
		
		Project originProject = projectDao.getProject(project.getProjectNo());
		originProject.setTitle(project.getTitle());
		originProject.setContent(project.getContent());
		originProject.setEnvOrTech(project.getEnvOrTech());
		originProject.setSumnailFileName(project.getSumnailFileName());

		String[] nameArr = originProject.getImageFileNames().trim().split(";");

		for (String name : nameArr) {

			if (!name.equals("")) {

				String filePath = uploadFileUtils.getUploadPath(1) + "\\" + name;

				File file = new File(filePath);

				if (file.exists()) {

					boolean result = file.delete();

					if (result) {
						logger.info(name + " File Delete Success"); // 성공
					} else {
						logger.info(name + " File Delete Fail"); // 실패
					}
				} else {
					logger.info(name + " File Not Found"); // 미존재
				}

			}
		}

		originProject.setImageFileNames(project.getImageFileNames());
		convertToHTML(originProject);

		projectDao.update(originProject);

	}

}
