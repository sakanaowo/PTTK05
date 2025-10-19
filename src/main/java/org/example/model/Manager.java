package org.example.model;

import java.sql.Date;

/**
 * Manager class - Quản lý
 * Extends Staff
 */
public class Manager extends Staff {

    public Manager() {
        super();
    }

    public Manager(int staffId, String role, int id, String name, String username, String password, Date birth, String phone) {
        super(staffId, role, id, name, username, password, birth, phone);
    }

    @Override
    public String toString() {
        return "Manager{" + super.toString() + '}';
    }
}
