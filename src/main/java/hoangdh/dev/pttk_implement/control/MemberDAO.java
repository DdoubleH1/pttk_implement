package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.Doctor;
import hoangdh.dev.pttk_implement.model.Manager;
import hoangdh.dev.pttk_implement.model.Member;

import java.util.ArrayList;
import java.util.List;

public class MemberDAO extends DAO {
    private List<Member> members;

    public MemberDAO() {
        super();
    }

    public Object checkLogin(Member member) {
        try {
            Member member1 = getSession().createQuery("from Member where username = :username and password = :password", Member.class)
                    .setParameter("username", member.getUsername())
                    .setParameter("password", member.getPassword())
                    .uniqueResult();
            if(member1 != null) {
                if(member1.getRole().equals("Doctor")) {
                    Doctor doctor = getSession().createQuery("from Doctor where id = :id", Doctor.class)
                            .setParameter("id", member1.getId())
                            .uniqueResult();
                    return doctor;
                } else if(member1.getRole().equals("Manager")) {
                    Manager manager = getSession().createQuery("from Manager where id = :id", Manager.class)
                            .setParameter("id", member1.getId())
                            .uniqueResult();
                    return manager;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}