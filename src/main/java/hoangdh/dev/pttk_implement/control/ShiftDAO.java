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

    public Shift getShiftById(int id) {
        getSession().beginTransaction();
        Shift shift = getSession().get(Shift.class, id);
        getSession().getTransaction().commit();
        return shift;
    }

    public Shift getShiftByTime(String startTime, String endTime) {
        getSession().beginTransaction();
        Query<Shift> query = getSession().createQuery(
                "FROM Shift WHERE startTime = :startTime AND endTime = :endTime", Shift.class);
        query.setParameter("startTime", startTime);
        query.setParameter("endTime", endTime);
        Shift shift = query.uniqueResult();
        getSession().getTransaction().commit();
        return shift;
    }
}
