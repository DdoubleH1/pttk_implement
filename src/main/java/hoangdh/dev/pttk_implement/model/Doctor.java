package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "doctor")

public class Doctor extends Member {

    @Column(name = "yearOfExperience")
    private Integer yearOfExperience;

    @Column(nullable = false)
    private Float shiftSalary;

    @Column(nullable = false)
    private String description;

    public Doctor(Member member, Integer yearOfExperience, Float shiftSalary, String description) {
        super(member.getId(), member.getUsername(), member.getPassword(), member.getFullName(), member.getDob(), member.getGender(), member.getAge(), member.getEmail(), member.getRole());
        this.yearOfExperience = yearOfExperience;
        this.shiftSalary = shiftSalary;
        this.description = description;
    }

    public Doctor() {

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