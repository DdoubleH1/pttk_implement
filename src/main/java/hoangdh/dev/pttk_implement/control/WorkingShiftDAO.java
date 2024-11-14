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

    public void createWorkingShift(WorkingShift workingShift) {
        getSession().beginTransaction();
        getSession().persist(workingShift);
        getSession().getTransaction().commit();
    }



    public List<WorkingShift> getAllWorkingShifts() {
        getSession().beginTransaction();
        LocalDate today = LocalDate.now();
        LocalDate nextMonday = today.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
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

    public WorkingShift getWorkingShiftByDateAndTime(String date, String startTime, String endTime) {
        getSession().beginTransaction();
        Query<WorkingShift> query = getSession().createQuery(
                "FROM WorkingShift WHERE date = :date AND shift.startTime = :startTime AND shift.endTime = :endTime",
                WorkingShift.class
        );
        query.setParameter("date", date);
        query.setParameter("startTime", startTime);
        query.setParameter("endTime", endTime);
        WorkingShift workingShift = query.uniqueResult();
        getSession().getTransaction().commit();
        return workingShift;
    }



}
