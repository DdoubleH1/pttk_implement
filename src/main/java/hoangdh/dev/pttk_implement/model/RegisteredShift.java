package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.*;

@Entity
@Table(name = "registered_shift")
public class RegisteredShift {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(nullable = false)
    private String registeredTime;

    @Column(nullable = false)
    private Boolean isScheduled;

    @ManyToOne
    @JoinColumn(name = "doctor_id", referencedColumnName = "id")
    private Doctor doctor;

    @ManyToOne
    @JoinColumn(name = "working_shift_id", referencedColumnName = "id")
    private WorkingShift workingShift;

    @ManyToOne
    @JoinColumn(name = "room_id", referencedColumnName = "id")
    private Room room;


    public RegisteredShift(Integer id, String registeredTime, Boolean isScheduled, Doctor doctor, WorkingShift workingShift, Room room) {
        this.id = id;
        this.registeredTime = registeredTime;
        this.isScheduled = isScheduled;
        this.doctor = doctor;
        this.workingShift = workingShift;
        this.room = room;
    }

    public RegisteredShift() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRegisteredTime() {
        return registeredTime;
    }

    public void setRegisteredTime(String registeredTime) {
        this.registeredTime = registeredTime;
    }

    public Boolean getScheduled() {
        return isScheduled;
    }

    public void setScheduled(Boolean scheduled) {
        isScheduled = scheduled;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public WorkingShift getWorkingShift() {
        return workingShift;
    }

    public void setWorkingShift(WorkingShift workingShift) {
        this.workingShift = workingShift;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }
}
