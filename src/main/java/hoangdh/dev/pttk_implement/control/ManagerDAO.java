package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Manager;

public class ManagerDAO extends DAO {
    public ManagerDAO() {
        super();
    }

    public void createManager(Manager manager) {
        getSession().beginTransaction();
        getSession().persist(manager);
        getSession().getTransaction().commit();
    }
}
