package hoangdh.dev.pttk_implement.control;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.cfg.Configuration;

public class DAO {
    private static Session session;

    public DAO() {
        init();
    }

    public static void init() {
        if (session == null) {
            try {
                session = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory().openSession();
                System.out.println("Session created");
            } catch (HibernateException ex) {
                ex.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static Session getSession() {
        return session;
    }
}
