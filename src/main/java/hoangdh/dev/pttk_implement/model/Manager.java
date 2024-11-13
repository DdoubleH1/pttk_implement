package hoangdh.dev.pttk_implement.model;

public class Manager extends Member {
    private String department;

    public Manager(Integer id, String username, String password, String fullName, String dob, String gender, Integer age, String email, String role) {
        super(id, username, password, fullName, dob, gender, age, email, role);
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
}