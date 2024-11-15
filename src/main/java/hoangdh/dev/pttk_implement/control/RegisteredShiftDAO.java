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

//    public List<RegisteredShift> getRegisteredShiftsForNextWeek(int doctorId) {
//        LocalDateTime now = LocalDateTime.now();
//        LocalDateTime startOfNextWeek = now.plusWeeks(1).with(LocalTime.MIN);
//        LocalDateTime endOfNextWeek = startOfNextWeek.plusDays(7).with(LocalTime.MAX);
//
//        getSession().beginTransaction();
//        List<RegisteredShift> registeredShifts = getSession().createQuery("from RegisteredShift where doctor.id = :doctorId and workingShift.date between :startOfNextWeek and :endOfNextWeek", RegisteredShift.class)
//                .setParameter("doctorId", doctorId)
//                .setParameter("startOfNextWeek", Date.from(startOfNextWeek.atZone(ZoneId.systemDefault()).toInstant()))
//                .setParameter("endOfNextWeek", Date.from(endOfNextWeek.atZone(ZoneId.systemDefault()).toInstant()))
//                .list();
//        getSession().getTransaction().commit();
//        return registeredShifts;
//    }

    public List<RegisteredShift> getRegisteredShiftsByDoctorId(int doctorId) {
        getSession().beginTransaction();
        List<RegisteredShift> registeredShifts = getSession().createQuery("from RegisteredShift where doctor.id = :doctorId", RegisteredShift.class)
                .setParameter("doctorId", doctorId)
                .list();
        getSession().getTransaction().commit();
        return registeredShifts;
    }

    public Boolean updateRegisteredShift(int registeredShiftId) {
        try {
            getSession().beginTransaction();
            RegisteredShift registeredShift = getSession().get(RegisteredShift.class, registeredShiftId);
            if (registeredShift != null) {
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
            RegisteredShift registeredShift = getSession().get(RegisteredShift.class, registeredShiftId);
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