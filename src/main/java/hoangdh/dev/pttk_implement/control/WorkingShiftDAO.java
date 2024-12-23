package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.WorkingShift;
import org.hibernate.query.Query;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

public class WorkingShiftDAO extends DAO {
    public WorkingShiftDAO() {
        super();
    }


    public List<WorkingShift> getAllWorkingShifts() {
        getSession().beginTransaction();
        LocalDate today = LocalDate.now();
        LocalDate nextMonday = today.plusDays((DayOfWeek.MONDAY.getValue() - today.getDayOfWeek().getValue() + 7) % 7);
        LocalDate nextSunday = nextMonday.plusDays(6);  // End of the next week
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startOfNextWeek = nextMonday.format(formatter);
        String endOfNextWeek = nextSunday.format(formatter);

        List<WorkingShift> workingShifts = getSession().createQuery(
                        "FROM WorkingShift WHERE date >= :startOfNextWeek AND date <= :endOfNextWeek",
                        WorkingShift.class
                ).setParameter("startOfNextWeek", startOfNextWeek)
                .setParameter("endOfNextWeek", endOfNextWeek)
                .list();
        getSession().getTransaction().commit();
        return workingShifts;
    }

    public WorkingShift getWorkingShiftById(int id) {
        getSession().beginTransaction();
        WorkingShift workingShift = getSession().get(WorkingShift.class, id);
        getSession().getTransaction().commit();
        return workingShift;
    }



}
