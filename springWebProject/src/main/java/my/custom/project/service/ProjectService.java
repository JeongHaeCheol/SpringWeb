package my.custom.project.service;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.ProjectDao;
import my.custom.project.model.Board;
import my.custom.project.model.Project;


@Service
public class ProjectService {

	
	@Autowired
	ProjectDao projectDao;

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
	
	
	
	public void convertToHTML(Project Project) {
		String title = Project.getTitle();
		String content = Project.getContent();

		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");

		title = title.replace(" ", "&nbsp;&nbsp;");

		content = content.replace("\n", "<br>");
		Project.setTitle(title);
		Project.setContent(content);
	}


}
