package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Doctor;

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
}
