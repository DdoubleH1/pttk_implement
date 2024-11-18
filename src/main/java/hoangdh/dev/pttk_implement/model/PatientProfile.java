package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "patient_profile")
public class PatientProfile {

    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String symptoms;

    @Column(nullable = false)
    private String diseaseConclusion;

    @Column(nullable = false)
    private String date;

    @OneToMany(mappedBy = "patientProfile", cascade = CascadeType.ALL)
    private List<TestResult> testResults;

    @OneToMany(mappedBy = "patientProfile", cascade = CascadeType.ALL)
    private List<Prescription> prescriptions;

    @ManyToOne
    @JoinColumn(name = "patient_id", referencedColumnName = "id")
    private Patient patient;

    @ManyToOne
    private RecordedShift recordedShift;

    public PatientProfile(Integer id, String symptoms, String diseaseConclusion, String date, List<TestResult> testResults, List<Prescription> prescriptions, Patient patient) {
        this.id = id;
        this.symptoms = symptoms;
        this.diseaseConclusion = diseaseConclusion;
        this.date = date;
        this.testResults = testResults;
        this.prescriptions = prescriptions;
        this.patient = patient;
    }

    public PatientProfile() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiseaseConclusion() {
        return diseaseConclusion;
    }

    public void setDiseaseConclusion(String diseaseConclusion) {
        this.diseaseConclusion = diseaseConclusion;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<TestResult> getTestResults() {
        return testResults;
    }

    public void setTestResults(List<TestResult> testResults) {
        this.testResults = testResults;
    }

    public List<Prescription> getPrescriptions() {
        return prescriptions;
    }

    public void setPrescriptions(List<Prescription> prescriptions) {
        this.prescriptions = prescriptions;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }
}
