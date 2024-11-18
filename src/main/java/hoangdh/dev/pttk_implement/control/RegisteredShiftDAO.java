package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.RegisteredShift;

import java.util.List;

public class RegisteredShiftDAO extends DAO {
    public RegisteredShiftDAO() {
        super();
    }

    public boolean saveRegisteredShift(List<RegisteredShift> registeredShifts) {
        try {
            getSession().beginTransaction();
            for (RegisteredShift registeredShift : registeredShifts) {
                if (!getSession().contains(registeredShift)) {
                    getSession().persist(registeredShift);
                } else {
                    getSession().merge(registeredShift);
                }
                getSession().flush();
            }
            getSession().getTransaction().commit();
            return true;
        } catch (Exception e) {
            getSession().getTransaction().rollback();
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveSchedule(List<RegisteredShift> scheduledRegisteredShifts) {
        try {
            List<RegisteredShift> existingRegisteredShifts = getAllRegisteredShifts();
            getSession().beginTransaction();
            for (RegisteredShift scheduledRegisteredShift : scheduledRegisteredShifts) {
                RegisteredShift existingRegisteredShift = existingRegisteredShifts.stream()
                        .filter(rs -> rs.getDoctor().getId().equals(scheduledRegisteredShift.getDoctor().getId()) && rs.getWorkingShift().getId().equals(scheduledRegisteredShift.getWorkingShift().getId()))
                        .findFirst()
                        .orElse(null);
                if (existingRegisteredShift != null) {
                    existingRegisteredShift.setRoom(scheduledRegisteredShift.getRoom());
                    existingRegisteredShift.setIsScheduled(scheduledRegisteredShift.getIsScheduled());
                    getSession().merge(existingRegisteredShift);
                }
                else {
                    getSession().persist(scheduledRegisteredShift);
                }
                getSession().flush();
            }
            getSession().getTransaction().commit();
            return true;
        } catch (Exception e) {
            getSession().getTransaction().rollback();
            e.printStackTrace();
        }
        return false;
    }

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

    public Boolean deleteRegisteredShift(int registeredShiftId, int doctorId) {
        try {
            getSession().beginTransaction();
            RegisteredShift registeredShift = getSession().createQuery("from RegisteredShift where workingShift.id = :registeredShiftId and doctor.id = :doctorId", RegisteredShift.class)
                    .setParameter("registeredShiftId", registeredShiftId)
                    .setParameter("doctorId", doctorId)
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

    public RegisteredShift getRegisteredShiftById(int id) {
        getSession().beginTransaction();
        RegisteredShift registeredShift = getSession().createQuery("from RegisteredShift where workingShift.id = :id", RegisteredShift.class)
                .setParameter("id", id)
                .uniqueResult();
        getSession().getTransaction().commit();
        return registeredShift;
    }
}