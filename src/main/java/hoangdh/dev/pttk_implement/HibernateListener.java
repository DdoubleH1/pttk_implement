package hoangdh.dev.pttk_implement;

import hoangdh.dev.pttk_implement.control.DAO;
import hoangdh.dev.pttk_implement.control.DoctorDAO;
import hoangdh.dev.pttk_implement.control.MemberDAO;
import hoangdh.dev.pttk_implement.model.Doctor;
import hoangdh.dev.pttk_implement.model.Member;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;


@WebListener
public class HibernateListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContextListener.super.contextInitialized(sce);
        // Initialize Hibernate
        //create member
        DoctorDAO doctorDAO = new DoctorDAO();
        doctorDAO.createDoctor(new Doctor(
                new Member(
                        null,
                        "doctor1",
                        "doctor1",
                        "Doctor 1",
                        "1999-01-01",
                        "Male",
                        22,
                        "abc@gmail.com",
                        "Doctor"
                ),
                5,
                1000f,
                "I am a doctor"

        ));
        DAO.init();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Shutdown Hibernate
        ServletContextListener.super.contextDestroyed(sce);
    }
}