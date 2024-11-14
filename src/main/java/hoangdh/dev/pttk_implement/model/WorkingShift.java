package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.*;

@Entity
@Table(name = "working_shift")
public class WorkingShift {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(nullable = false)
    private String date;

    @ManyToOne
    @JoinColumn(name = "shift_id", referencedColumnName = "id")
    private Shift shift;

    public WorkingShift(Integer id, String date, Shift shift) {
        this.id = id;
        this.date = date;
        this.shift = shift;
    }

    public WorkingShift() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Shift getShift() {
        return shift;
    }

    public void setShift(Shift shift) {
        this.shift = shift;
    }
}
