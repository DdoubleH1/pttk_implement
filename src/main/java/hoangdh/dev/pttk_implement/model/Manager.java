package hoangdh.dev.pttk_implement.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "manager")
public class Manager extends Member {


    public Manager(Member member) {
        super(member.getId(), member.getUsername(), member.getPassword(), member.getFullName(), member.getDob(), member.getGender(), member.getAge(), member.getEmail(), member.getRole());
    }


    public Manager() {

    }
}