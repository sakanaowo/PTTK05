package org.example.model;

import java.sql.Date;

/**
 * Abstract Staff class - Nhân viên
 * Extends User, base class cho LibraryStaff và Manager
 */
public abstract class Staff extends User {
    private int staffId;
    private String role;

    public Staff() {
        super();
    }

    public Staff(int staffId, String role, int id, String name, String username, String password, Date birth, String phone) {
        super(id, name, username, password, birth, phone);
        this.staffId = staffId;
        this.role = role;
    }

    // Getters and Setters
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Staff{" +
                "staffId=" + staffId +
                ", role='" + role + '\'' +
                ", " + super.toString() +
                '}';
    }
}
