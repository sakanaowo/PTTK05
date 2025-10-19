package org.example.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Reader class - Bạn đọc
 * Extends User
 */
public class Reader extends User {
    private int readerId;

    public Reader() {
        super();
    }

    public Reader(int readerId, int id, String name, String username, String password, Date birth, String phone) {
        super(id, name, username, password, birth, phone);
        this.readerId = readerId;
    }

    public int getReaderId() {
        return readerId;
    }


    public void setReaderId(int readerId) {
        this.readerId = readerId;
    }

    @Override
    public String toString() {
        return "Reader{" +
                "readerId=" + readerId +
                ", " + super.toString() +
                '}';
    }
}
