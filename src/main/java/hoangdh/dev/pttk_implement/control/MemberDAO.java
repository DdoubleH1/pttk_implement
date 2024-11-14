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
            Member m = getSession().createQuery("from Member where username = :username and password = :password", Member.class)
                    .setParameter("username", member.getUsername())
                    .setParameter("password", member.getPassword())
                    .uniqueResult();
            if (m != null) {
                if (m.getRole().equals("Doctor")) {
                    return getSession().createQuery("from Doctor where id = :id", Doctor.class)
                            .setParameter("id", m.getId())
                            .uniqueResult();
                } else {
                    return getSession().createQuery("from Manager where id = :id", Manager.class)
                            .setParameter("id", m.getId())
                            .uniqueResult();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}