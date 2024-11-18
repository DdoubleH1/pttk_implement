package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Shift;
import org.hibernate.query.Query;

public class ShiftDAO extends DAO{

    public ShiftDAO() {
        super();
    }

    public void createShift(Shift shift) {
        getSession().beginTransaction();
        getSession().persist(shift);
        getSession().getTransaction().commit();
    }

}
