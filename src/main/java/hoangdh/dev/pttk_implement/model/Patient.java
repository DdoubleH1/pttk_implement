package hoangdh.dev.pttk_implement.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "patient")
public class Patient extends Member {
    @Column(nullable = false)
    private float weight;
    @Column(nullable = false)
    private float height;

    public Patient(Member member, float weight, float height) {
        super(member.getId(), member.getUsername(), member.getPassword(), member.getFullName(), member.getDob(), member.getGender(), member.getAge(), member.getEmail(), member.getRole());
        this.weight = weight;
        this.height = height;
    }

    public Patient() {

    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }
}
