package hoangdh.dev.pttk_implement.model;

public class Doctor extends Member {
    private Integer yearOfExperience;
    private Float shiftSalary;
    private String description;

    public Doctor(Integer id, String username, String password, String fullName, String dob, String gender, Integer age, String email, String role) {
        super(id, username, password, fullName, dob, gender, age, email, role);
    }

    public Integer getYearOfExperience() {
        return yearOfExperience;
    }

    public void setYearOfExperience(Integer yearOfExperience) {
        this.yearOfExperience = yearOfExperience;
    }

    public Float getShiftSalary() {
        return shiftSalary;
    }

    public void setShiftSalary(Float shiftSalary) {
        this.shiftSalary = shiftSalary;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}