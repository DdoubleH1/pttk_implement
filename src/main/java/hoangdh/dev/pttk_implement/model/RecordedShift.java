package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "recorded_shift")
public class RecordedShift extends RegisteredShift {

    @Column(nullable = false)
    private String checkInTime;

    @Column(nullable = false)
    private String checkOutTime;

    @Column(nullable = false)
    private float hoursOfOvertime;

    @Column(nullable = false)
    private float hoursOfCompensation;

    @Column(nullable = false)
    private float ratingScore;

    @Column(nullable = false)
    private Boolean isPaid;

    @OneToMany(mappedBy = "recordedShift", cascade = CascadeType.ALL)
    private List<PatientProfile> patientProfiles;

    @ManyToOne
    @JoinColumn(name = "salary_slip_id", referencedColumnName = "id")
    private SalarySlip salarySlip;


    public RecordedShift(RegisteredShift registeredShift, String checkInTime, String checkOutTime, float hoursOfOvertime, float hoursOfCompensation, float ratingScore, Boolean isPaid, List<PatientProfile> patientProfiles,  SalarySlip salarySlip) {
        super(registeredShift.getId(), registeredShift.getRegisteredTime(), registeredShift.getIsScheduled(), registeredShift.getDoctor(), registeredShift.getWorkingShift(), registeredShift.getRoom());
        this.checkInTime = checkInTime;
        this.checkOutTime = checkOutTime;
        this.hoursOfOvertime = hoursOfOvertime;
        this.hoursOfCompensation = hoursOfCompensation;
        this.ratingScore = ratingScore;
        this.isPaid = isPaid;
        this.patientProfiles = patientProfiles;
        this.salarySlip = salarySlip;
    }

    public RecordedShift() {

    }

    public String getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(String checkInTime) {
        this.checkInTime = checkInTime;
    }

    public String getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(String checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public float getHoursOfOvertime() {
        return hoursOfOvertime;
    }

    public void setHoursOfOvertime(float hoursOfOvertime) {
        this.hoursOfOvertime = hoursOfOvertime;
    }

    public float getHoursOfCompensation() {
        return hoursOfCompensation;
    }

    public void setHoursOfCompensation(float hoursOfCompensation) {
        this.hoursOfCompensation = hoursOfCompensation;
    }

    public float getRatingScore() {
        return ratingScore;
    }

    public void setRatingScore(float ratingScore) {
        this.ratingScore = ratingScore;
    }

    public Boolean getIsPaid() {
        return isPaid;
    }

    public void setIsPaid(Boolean paid) {
        isPaid = paid;
    }

    public List<PatientProfile> getPatientProfiles() {
        return patientProfiles;
    }

    public void setPatientProfiles(List<PatientProfile> patientProfiles) {
        this.patientProfiles = patientProfiles;
    }

    public SalarySlip getSalarySlip() {
        return salarySlip;
    }

    public void setSalarySlip(SalarySlip salarySlip) {
        this.salarySlip = salarySlip;
    }


}
