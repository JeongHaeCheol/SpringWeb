package my.custom.project.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import my.custom.project.model.Project;
import my.custom.project.service.ProjectService;
import my.custom.project.util.UploadFileUtils;

@Controller
@RequestMapping("/projects/*")
public class ProjectsListController {

	private static final Logger logger = LoggerFactory.getLogger(ProjectsListController.class);

	@Autowired
	ProjectService projectService;

	private UploadFileUtils uploadFileUtils = new UploadFileUtils();

	@RequestMapping("list")
	public String getProjectList(Model model) {

		List<Project> projectList = projectService.getProjects();
		model.addAttribute("projectList", projectList);

		return "projects/list";
	}

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String addProject(Project project, Model model) {
		return "projects/add";
	}

	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String addProjectPost(@Valid Project project, MultipartHttpServletRequest mtfRequest,
			@RequestParam("imageFiles") MultipartFile[] file) {

		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();
		project.setWriter(name);

		String saveFilenames = "";
		String sumnailFileName = "";

		for (MultipartFile imageFile : file) {
			String savedName = "";

			if (!imageFile.getOriginalFilename().equals("")) {
				try {
					savedName = uploadFileUtils.uploadFile(1, imageFile.getOriginalFilename(), imageFile.getBytes());
					if(sumnailFileName.equals("")) {
						sumnailFileName = savedName;
					}
				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
				saveFilenames += ";" + savedName;
			}

		}
		project.setSumnailFileName(sumnailFileName);
		project.setImageFileNames(saveFilenames);

		projectService.create(project);

		return "redirect:list";
	}
}
