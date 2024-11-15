package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.RegisteredShift;
import hoangdh.dev.pttk_implement.model.WorkingShift;

import java.util.List;

public class RegisteredShiftDAO extends DAO {
    public RegisteredShiftDAO() {
        super();
    }

    public boolean saveRegisteredShift(List<RegisteredShift> registeredShifts) {
        try {
            getSession().beginTransaction();
            for (RegisteredShift registeredShift : registeredShifts) {
                getSession().persist(registeredShift);
            }
            getSession().getTransaction().commit();
            return true;
        } catch (Exception e) {
            getSession().getTransaction().rollback();
            e.printStackTrace();
        }
        return false;
    }

    //get registered shift by id


    public List<RegisteredShift> getRegisteredShiftsByDoctorId(int doctorId) {
        getSession().beginTransaction();
        List<RegisteredShift> registeredShifts = getSession().createQuery("from RegisteredShift where doctor.id = :doctorId", RegisteredShift.class)
                .setParameter("doctorId", doctorId)
                .list();
        getSession().getTransaction().commit();
        return registeredShifts;
    }

    public List<RegisteredShift> getAllRegisteredShifts() {
        getSession().beginTransaction();
        List<RegisteredShift> registeredShifts = getSession().createQuery("from RegisteredShift", RegisteredShift.class).list();
        getSession().getTransaction().commit();
        return registeredShifts;
    }

    public Boolean updateRegisteredShift(int oldRegisteredShiftId, int newRegisteredShiftId) {
        try {
            getSession().beginTransaction();
           //update working_shift_id to registered
            RegisteredShift registeredShift = getSession().createQuery("from RegisteredShift where workingShift.id = :oldRegisteredShiftId", RegisteredShift.class)
                    .setParameter("oldRegisteredShiftId", oldRegisteredShiftId)
                    .uniqueResult();
            if (registeredShift != null) {
                registeredShift.setWorkingShift(getSession().get(WorkingShift.class, newRegisteredShiftId));
                getSession().merge(registeredShift);
                getSession().getTransaction().commit();
                return true;
            }
        } catch (Exception e) {
            getSession().getTransaction().rollback();
            e.printStackTrace();
        }
        return false;
    }

    public Boolean deleteRegisteredShift(int registeredShiftId) {
        try {
            getSession().beginTransaction();
            RegisteredShift registeredShift = getSession().createQuery("from RegisteredShift where workingShift.id = :registeredShiftId", RegisteredShift.class)
                    .setParameter("registeredShiftId", registeredShiftId)
                    .uniqueResult();
            if (registeredShift != null) {
                getSession().remove(registeredShift);
                getSession().getTransaction().commit();
                return true;
            }
        } catch (Exception e) {
            getSession().getTransaction().rollback();
            e.printStackTrace();

        }
        return false;
    }
}