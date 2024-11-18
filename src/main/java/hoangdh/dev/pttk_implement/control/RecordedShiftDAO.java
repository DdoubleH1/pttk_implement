package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.RecordedShift;
import hoangdh.dev.pttk_implement.model.RegisteredShift;

import java.util.List;

public class RecordedShiftDAO extends DAO {
    public RecordedShiftDAO() {
        super();
    }

    public void createRecordedShift(RecordedShift recordedShift) {
        try {
            getSession().beginTransaction();
            // write native sql query to insert
            getSession().saveOrUpdate(recordedShift);
            getSession().getTransaction().commit();
        } catch (Exception e) {
            getSession().getTransaction().rollback();
            e.printStackTrace();
        }
    }

    public List<RecordedShift> getRecordedShiftsByDoctorId(int doctorId) {
        getSession().beginTransaction();
        List<RecordedShift> recordedShifts = getSession().createQuery("from RecordedShift where doctor.id = :doctorId and isPaid = false", RecordedShift.class)
                .setParameter("doctorId", doctorId)
                .list();
        getSession().getTransaction().commit();
        return recordedShifts;
    }

    public RecordedShift getRecordedShiftById(int id) {
        getSession().beginTransaction();
        RecordedShift recordedShift = getSession().get(RecordedShift.class, id);
        getSession().getTransaction().commit();
        return recordedShift;
    }

    //detached object
    public void detachRecordedShift(RegisteredShift recordedShift) {
        getSession().evict(recordedShift);
    }
}
