package hoangdh.dev.pttk_implement;

import hoangdh.dev.pttk_implement.control.*;
import hoangdh.dev.pttk_implement.model.*;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


@WebListener
public class HibernateListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContextListener.super.contextInitialized(sce);
        // Initialize Hibernate
        //create member
//        DoctorDAO doctorDAO = new DoctorDAO();
//        doctorDAO.createDoctor(new Doctor(
//                new Member(
//                        null,
//                        "doctor3",
//                        "doctor3",
//                        "William Doe",
//                        "1999-01-01",
//                        "Female",
//                        42,
//                        "test@gmail.com",
//                        "Doctor"
//                ),
//                5,
//                1000f,
//                "I am a doctor"
//
//        ));doctorDAO.createDoctor(new Doctor(
//                new Member(
//                        null,
//                        "doctor4",
//                        "doctor4",
//                        "Tim Ashley",
//                        "1999-01-01",
//                        "Female",
//                        42,
//                        "test1@gmail.com",
//                        "Doctor"
//                ),
//                5,
//                1000f,
//                "I am a doctor"
//
//        ));doctorDAO.createDoctor(new Doctor(
//                new Member(
//                        null,
//                        "doctor5",
//                        "doctor5",
//                        "Batman Doe",
//                        "1999-01-01",
//                        "Female",
//                        42,
//                        "test4@gmail.com",
//                        "Doctor"
//                ),
//                5,
//                1000f,
//                "I am a doctor"
//
//        ));doctorDAO.createDoctor(new Doctor(
//                new Member(
//                        null,
//                        "doctor6",
//                        "doctor6",
//                        "DoHuyHoang",
//                        "1999-01-01",
//                        "Female",
//                        42,
//                        "dhh@gmail.com",
//                        "Doctor"
//                ),
//                5,
//                1000f,
//                "I am a doctor"
//
//        ));

        //create room
//        RoomDAO roomDAO = new RoomDAO();
//        String[] roomNames = {"101", "102", "103", "104"};
//        for (String roomName : roomNames) {
//            Room room = new Room(null, roomName);
//            roomDAO.createRoom(room);
//        }
//
////        create shift
//        ShiftDAO shiftDAO = new ShiftDAO();
//        Shift shift1 = new Shift(null, "08:00", "12:00");
//        Shift shift2 = new Shift(null, "13:00", "17:00");
//        shiftDAO.createShift(shift1);
//        shiftDAO.createShift(shift2);

//         create working shift from 11/11/2024 to 18/11/2024
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//        LocalDate startDate = LocalDate.parse("2024-11-18", formatter);
//        LocalDate endDate = LocalDate.parse("2024-11-24", formatter);
//        ShiftDAO shiftDAO = new ShiftDAO();
//        WorkingShiftDAO workingShiftDAO = new WorkingShiftDAO();
//
//        for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
//            WorkingShift workingShift1 = new WorkingShift(null, date.format(formatter), shiftDAO.getShiftById(1));
//            WorkingShift workingShift2 = new WorkingShift(null, date.format(formatter), shiftDAO.getShiftById(2));
//            workingShiftDAO.createWorkingShift(workingShift1);
//            workingShiftDAO.createWorkingShift(workingShift2);
//        }

        //create manager
//        ManagerDAO managerDAO = new ManagerDAO();
//        managerDAO.createManager(new Manager(
//                new Member(
//                        null,
//                        "manager1",
//                        "manager1",
//                        "Jame Doe",
//                        "1999-01-01",
//                        "Male",
//                        32,
//                        "aaac@gmail.com",
//                        "Manager")));

        DAO.init();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Shutdown Hibernate
        ServletContextListener.super.contextDestroyed(sce);
    }
}