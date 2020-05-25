package com.panda.dao;

import com.panda.pojo.User;

public interface UserDao {

    /**
     * @category 根据用户密码登录
     * @param account
     * @param pwd
     * @return
     */
    public User login(String account, String pwd);

    /**
     * @category 根据用户账号获取用户
     * @param account
     * @return
     */
    public User getUserById(String account);
}