package org.example.dao;

import org.example.model.Reader;
import org.example.model.ReaderStatistic;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReaderStatisticDAO extends DAO {
    public List<ReaderStatistic> getReaderStatisticList(Date startDate, Date endDate) {
        List<ReaderStatistic> list = new ArrayList<>();
        String sql = "SELECT r.readerId, u.id, u.name, u.username, u.password, " +
                "u.birth, u.phone, COUNT(*) as loanNumber " +
                "FROM tblLoanSlip ls " +
                "JOIN tblReader r ON ls.tblReaderReaderId = r.readerId " +
                "JOIN tblUser u ON r.tblUserId = u.id " +
                "WHERE ls.loanDate BETWEEN ? AND ? " +
                "GROUP BY r.readerId " +
                "ORDER BY loanNumber DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reader reader = new Reader(
                        rs.getInt("readerId"),
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDate("birth"),
                        rs.getString("phone")
                );
                ReaderStatistic stat = new ReaderStatistic(
                        reader,
                        rs.getInt("loanNumber")
                );
                list.add(stat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Reader getReaderInfo(int readerId) {
        String sql = "SELECT r.readerId, u.id, u.name, u.username, u.password, u.birth, u.phone " +
                "FROM tblReader r " +
                "JOIN tblUser u ON r.tblUserId = u.id " +
                "WHERE r.readerId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, readerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Reader reader = new Reader(
                        rs.getInt("readerId"),
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDate("birth"),
                        rs.getString("phone")
                );
                return reader;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
