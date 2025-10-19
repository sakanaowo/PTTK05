package org.example.model;

import java.sql.Date;

/**
 * LibraryStaff class - Nhân viên thư viện
 * Extends Staff
 */
public class LibraryStaff extends Staff {

    public LibraryStaff() {
        super();
    }

    public LibraryStaff(int staffId, String role, int id, String name, String username, String password, Date birth, String phone) {
        super(staffId, role, id, name, username, password, birth, phone);
    }

    @Override
    public String toString() {
        return "LibraryStaff{" + super.toString() + '}';
    }
}
