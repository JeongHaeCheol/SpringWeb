package my.custom.project.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import my.custom.project.model.Board;
import my.custom.project.model.Project;


@Repository
@Transactional
public class ProjectDao {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectDao.class);
	
	
	@Autowired
	private SessionFactory sessionFactory;


	public List<Project> getProjects() {
		Session session = sessionFactory.getCurrentSession();
		List<Project> projectList = session.createQuery("from Project order by projectNo DESC,  regdate DESC").list();
		return projectList;
	}


	public void create(Project project) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(project);
		session.flush();
	}

}
