package hoangdh.dev.pttk_implement.model;


import jakarta.persistence.*;

@Entity
@Table(name = "test_category")
public class TestCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String description;

    public TestCategory(Integer id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public TestCategory() {}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
