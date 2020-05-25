package com.panda.dao;


import com.panda.pojo.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
@Repository
public class UserDaoImpl implements UserDao {

    @Resource
    SessionFactory sessionFactory;

    /**
     * @category 获取当前的session
     * @return
     */
    public Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public User login(String account, String pwd) {
        Session session = getCurrentSession();
        Query query = session.createQuery(
                "from " + User.class.getName() + " where account='" + account + "' and pwd='" + pwd + "'");
        User user = (User) query.uniqueResult();
        return user;
    }

    public User getUserById(String account) {
        Session session = getCurrentSession();
        Query query = session.createQuery(
                "from " + User.class.getName() + " where account='" + account + "'");
        User user = (User) query.uniqueResult();
        return user;
    }

}
