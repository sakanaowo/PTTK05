package org.example.model;

import java.sql.Date;

/**
 * Abstract User class - Thành viên
 * Base class cho Reader và Staff
 */
public abstract class User {
    private int id;
    private String name;
    private String username;
    private String password;
    private Date birth;
    private String phone;

    public User() {
    }

    public User(int id, String name, String username, String password, Date birth, String phone) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.birth = birth;
        this.phone = phone;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", username='" + username + '\'' +
                ", birth=" + birth +
                ", phone='" + phone + '\'' +
                '}';
    }
}

