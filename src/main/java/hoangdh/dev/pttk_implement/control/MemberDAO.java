package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Doctor;
import hoangdh.dev.pttk_implement.model.Manager;
import hoangdh.dev.pttk_implement.model.Member;

import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
    private List<Member> members;

    public MemberDAO() {
        createDummyData();
    }

    private void createDummyData() {
        members = new ArrayList<>();

        Doctor doctor = new Doctor(1, "doctor", "password", "John Doe", "1980-01-01", "Male", 42, "john.doe@example.com", "doctor");
        doctor.setYearOfExperience(10);
        doctor.setShiftSalary(5000.0f);
        doctor.setDescription("Experienced cardiologist");
        members.add(doctor);

        Manager manager = new Manager(2, "manager", "password", "Jane Smith", "1975-05-15", "Female", 47, "jane.smith@example.com", "manager");
        manager.setDepartment("HR");
        members.add(manager);
    }

    public Member checkLogin(Member member) {
        for (Member m : members) {
            if (m.getUsername().equals(member.getUsername()) && m.getPassword().equals(member.getPassword())) {
                return m;
            }
        }
        return null;
    }
}