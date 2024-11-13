package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "manager")
public class Manager extends Member {


    public Manager(Integer id, String username, String password, String fullName, String dob, String gender, Integer age, String email, String role) {
        super(id, username, password, fullName, dob, gender, age, email, role);
    }


    public Manager() {

    }
}