package com.panda.pojo;



import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 这里是和数据库做映射关系
 */
@Entity
@Table(name = "t_panda_user")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    @GeneratedValue(generator = "system-uuid")
    @Column
    private String id;// 主键
    @Id
    @Column
    private String account;//账号
    @Column
    private String pwd;//密码
    @Column
    private String cname;//中文名
    @Column
    private String mobile;//手机号
    @Column
    private int role;//对应角色


    public String getId() {return id;}
    public void setId(String id) {this.id = id; }
    public String getAccount() { return account;}
    public void setAccount(String account) {this.account = account;}
    public String getPwd() {return pwd;}
    public void setPwd(String pwd) {this.pwd = pwd;}
    public String getCname() {return cname; }
    public void setCname(String cname) {this.cname = cname;}
    public String getMobile() {return mobile;}
    public void setMobile(String mobile) {this.mobile = mobile;}
    public int getRole() {return role;}
    public void setRole(int role) {this.role = role;}
}