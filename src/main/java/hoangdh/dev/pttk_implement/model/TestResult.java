package hoangdh.dev.pttk_implement.model;


import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "test_result")
public class TestResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String result;

    @Column(nullable = false)
    private String referenceRange;

    @ManyToOne
    @JoinColumn(name = "test_category_id", referencedColumnName = "id")
    private TestCategory testCategory;

    @ManyToOne
    @JoinColumn(name = "patient_profile_id", referencedColumnName = "id")
    private PatientProfile patientProfile;

    public TestResult(Integer id, String result, String referenceRange, TestCategory testCategory, PatientProfile patientProfile) {
        this.id = id;
        this.result = result;
        this.referenceRange = referenceRange;
        this.testCategory = testCategory;
        this.patientProfile = patientProfile;
    }

    public TestResult() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getReferenceRange() {
        return referenceRange;
    }

    public void setReferenceRange(String referenceRange) {
        this.referenceRange = referenceRange;
    }

    public TestCategory getTestCategory() {
        return testCategory;
    }

    public void setTestCategory(TestCategory testCategory) {
        this.testCategory = testCategory;
    }

    public PatientProfile getPatientProfile() {
        return patientProfile;
    }

    public void setPatientProfile(PatientProfile patientProfile) {
        this.patientProfile = patientProfile;
    }
}
