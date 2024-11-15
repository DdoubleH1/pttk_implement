package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Doctor;

import java.util.List;

public class DoctorDAO extends DAO{
    public DoctorDAO() {
        super();
    }
    // add method to create new doctor
    public void createDoctor(Doctor doctor) {
        try {
            getSession().beginTransaction();
            getSession().persist(doctor);
            getSession().getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            // rollback if exception occurs
            getSession().getTransaction().rollback();
        }
    }

    // get list doctor in a shift
    public List<Doctor> getDoctorsInShift(int shiftId) {
        getSession().beginTransaction();
        List<Doctor> doctors = getSession().createQuery("select rs.doctor from RegisteredShift rs where rs.workingShift.id = :shiftId", Doctor.class)
                .setParameter("shiftId", shiftId)
                .list();
        getSession().getTransaction().commit();
        return doctors;
    }
}
