package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.*;

@Entity
@Table(name = "prescription")
public class Prescription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String medicationName;

    @Column(nullable = false)
    private String medicationDosage;

    @Column(nullable = false)
    private String routeOfAdministration;

    @Column(nullable = false)
    private String frequencyOfIntake;

    @ManyToOne
    @JoinColumn(name = "patient_profile_id", referencedColumnName = "id")
    private PatientProfile patientProfile;

    public Prescription(Integer id, String medicationName, String medicationDosage, String routeOfAdministration, String frequencyOfIntake, PatientProfile patientProfile) {
        this.id = id;
        this.medicationName = medicationName;
        this.medicationDosage = medicationDosage;
        this.routeOfAdministration = routeOfAdministration;
        this.frequencyOfIntake = frequencyOfIntake;
        this.patientProfile = patientProfile;
    }

    public Prescription() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMedicationName() {
        return medicationName;
    }

    public void setMedicationName(String medicationName) {
        this.medicationName = medicationName;
    }

    public String getMedicationDosage() {
        return medicationDosage;
    }

    public void setMedicationDosage(String medicationDosage) {
        this.medicationDosage = medicationDosage;
    }

    public String getRouteOfAdministration() {
        return routeOfAdministration;
    }

    public void setRouteOfAdministration(String routeOfAdministration) {
        this.routeOfAdministration = routeOfAdministration;
    }

    public String getFrequencyOfIntake() {
        return frequencyOfIntake;
    }

    public void setFrequencyOfIntake(String frequencyOfIntake) {
        this.frequencyOfIntake = frequencyOfIntake;
    }

    public PatientProfile getPatientProfile() {
        return patientProfile;
    }

    public void setPatientProfile(PatientProfile patientProfile) {
        this.patientProfile = patientProfile;
    }
}
