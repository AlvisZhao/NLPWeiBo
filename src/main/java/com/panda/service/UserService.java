package com.panda.service;

import com.panda.pojo.User;

public interface UserService {

    /**
     * @category 登录
     * @param account
     * @param pwd
     * @return
     */
    public User login(String account, String pwd);

    /**
     * @category 根据账号获取用户
     * @param account
     * @return
     */
    public User getUserById(String account);
}