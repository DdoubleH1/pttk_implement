package hoangdh.dev.pttk_implement.control;

import hoangdh.dev.pttk_implement.model.SalarySlip;

public class SalarySlipDao extends DAO{

    public SalarySlipDao(){
        super();
    }

    public boolean saveSalarySlip(SalarySlip salarySlip){
        try{
            getSession().beginTransaction();
            getSession().persist(salarySlip);
            getSession().flush();
            getSession().getTransaction().commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            getSession().getTransaction().rollback();
            return false;
        }
    }
}
