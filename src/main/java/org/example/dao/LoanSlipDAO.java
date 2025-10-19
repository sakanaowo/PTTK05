package org.example.dao;

import org.example.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class LoanSlipDAO extends DAO {
    public List<LoanSlip> getLoanSlipList(int readerId, Date startDate, Date endDate) {
        List<LoanSlip> list = new ArrayList<>();

        String sql = "SELECT * FROM tblLoanSlip " +
                "WHERE tblReaderReaderId = ? " +
                "AND loanDate BETWEEN ? AND ? " +
                "ORDER BY loanDate DESC";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, readerId);
            ps.setDate(2, new java.sql.Date(startDate.getTime()));
            ps.setDate(3, new java.sql.Date(endDate.getTime()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LoanSlip slip = new LoanSlip(
                        rs.getInt("loanId"),
                        rs.getDate("loanDate"),
                        rs.getDate("returnDate"),
                        null,
                        null,
                        null
                );
                list.add(slip);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public LoanSlip getLoanSlip(int loanId) {

        String sql = "SELECT * FROM tblLoanSlip WHERE loanId = ?";
        LoanSlip slip = null;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, loanId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                slip = new LoanSlip(
                        rs.getInt("loanId"),
                        rs.getDate("loanDate"),
                        rs.getDate("returnDate"),
                        null, // load sau
                        null, // load sau
                        new ArrayList<>()
                );

                slip.setReader(getReaderInfo(rs.getInt("tblReaderReaderId")));

                slip.setStaff(getStaffInfo(rs.getInt("tblStaffStaffId")));

                slip.setLoanDetailList(getLoanDetailList(loanId));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return slip;
    }

    private List<LoanDetail> getLoanDetailList(int loanId) {
        List<LoanDetail> list = new ArrayList<>();

        String sql = "SELECT ld.id, d.documentId, d.name, d.author, d.supplier, d.status " +
                "FROM tblLoanDetail ld " +
                "JOIN tblDocument d ON ld.tblDocumentDocumentId = d.documentId " +
                "WHERE ld.tblLoanSlipLoanId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, loanId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo Document object
                Document doc = new Document(
                        rs.getInt("documentId"),
                        rs.getString("name"),
                        rs.getString("author"),
                        rs.getString("supplier"),
                        rs.getString("status")
                );

                // Tạo LoanDetail object
                LoanDetail detail = new LoanDetail(
                        rs.getInt("id"),
                        null, // loanSlip không set lại để tránh vòng lặp
                        doc
                );
                list.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Helper method: Load Reader info từ readerId
     */
    private Reader getReaderInfo(int readerId) {
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

    /**
     * Helper method: Load Staff info từ staffId
     */
    private LibraryStaff getStaffInfo(int staffId) {
        String sql = "SELECT s.staffId, s.role, u.id, u.name, u.username, u.password, u.birth, u.phone " +
                "FROM tblStaff s " +
                "JOIN tblUser u ON s.tblUserId = u.id " +
                "WHERE s.staffId = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                LibraryStaff staff = new LibraryStaff(
                        rs.getInt("staffId"),
                        rs.getString("role"),
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getDate("birth"),
                        rs.getString("phone")
                );
                return staff;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
