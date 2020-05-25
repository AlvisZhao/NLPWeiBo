package com.panda.service;

import com.panda.dao.UserDao;
import com.panda.pojo.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Resource
    UserDao userDao;

    public User login(String account, String pwd) {
        return userDao.login(account,pwd);
    }

    public User getUserById(String account) {
        return userDao.getUserById(account);
    }
}