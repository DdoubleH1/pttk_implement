package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "salary_slip")
public class SalarySlip {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private float overtimeSalary = 0;

    @Column(nullable = false)
    private float bonus = 0;

    @Column(nullable = false)
    private float fines = 0;

    @Column(nullable = false)
    private float baseWeekSalary = 0;

    @Column(nullable = false)
    private float receiveWeekSalary = 0;

    @OneToMany(mappedBy = "salarySlip", cascade = CascadeType.ALL)
    private List<RecordedShift> recordedShifts;

    @ManyToOne
    @JoinColumn(name = "doctor_id", referencedColumnName = "id")
    private Doctor doctor;

    @ManyToOne
    @JoinColumn(name = "manager_id", referencedColumnName = "id")
    private Manager manager;

    public SalarySlip() {
    }

    public SalarySlip(Integer id, float overtimeSalary, float bonus, float fines, float baseWeekSalary, float receiveWeekSalary, List<RecordedShift> recordedShifts, Doctor doctor, Manager manager) {
        this.id = id;
        this.overtimeSalary = overtimeSalary;
        this.bonus = bonus;
        this.fines = fines;
        this.baseWeekSalary = baseWeekSalary;
        this.receiveWeekSalary = receiveWeekSalary;
        this.recordedShifts = recordedShifts;
        this.doctor = doctor;
        this.manager = manager;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public float getOvertimeSalary() {
        return overtimeSalary;
    }

    public void setOvertimeSalary(float overtimeSalary) {
        this.overtimeSalary = overtimeSalary;
    }

    public float getBonus() {
        return bonus;
    }

    public void setBonus(float bonus) {
        this.bonus = bonus;
    }

    public float getFines() {
        return fines;
    }

    public void setFines(float fines) {
        this.fines = fines;
    }

    public float getBaseWeekSalary() {
        return baseWeekSalary;
    }

    public void setBaseWeekSalary(float baseWeekSalary) {
        this.baseWeekSalary = baseWeekSalary;
    }

    public float getReceiveWeekSalary() {
        return receiveWeekSalary;
    }

    public void setReceiveWeekSalary(float receiveWeekSalary) {
        this.receiveWeekSalary = receiveWeekSalary;
    }

    public List<RecordedShift> getRecordedShifts() {
        return recordedShifts;
    }

    public void setRecordedShifts(List<RecordedShift> recordedShifts) {
        this.recordedShifts = recordedShifts;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Manager getManager() {
        return manager;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }
}
