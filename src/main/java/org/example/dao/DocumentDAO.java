package org.example.dao;

import org.example.model.Document;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO extends DAO {

    public List<Document> getDocumentList(String keyword) {
        List<Document> list = new ArrayList<>();
        String sql = "SELECT * FROM tblDocument where name LIKE ? ";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Document doc = new Document(
                        rs.getInt("documentId"),
                        rs.getString("name"),
                        rs.getString("author"),
                        rs.getString("supplier"),
                        rs.getString("status")
                );
                list.add(doc);
            }
        } catch (
                SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Document getDocument(int documentId) {
        String sql = "SELECT * FROM tblDocument where documentId = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, documentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Document(
                        rs.getInt("documentId"),
                        rs.getString("name"),
                        rs.getString("author"),
                        rs.getString("supplier"),
                        rs.getString("status")
                );
            }
        } catch (
                SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
