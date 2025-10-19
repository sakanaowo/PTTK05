package org.example.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Base DAO class - Quản lý kết nối database
 */
public class DAO {
    private static Properties properties;

    static {
        try {
            // Load database properties
            properties = new Properties();
            InputStream input = DAO.class.getClassLoader().getResourceAsStream("db.properties");
            if (input == null) {
                throw new IOException("Unable to find db.properties");
            }
            properties.load(input);

            // Load MySQL JDBC Driver
            String driver = properties.getProperty("db.driver");
            Class.forName(driver);

            System.out.println("✅ MySQL JDBC Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (IOException e) {
            System.err.println("❌ Failed to load db.properties!");
            e.printStackTrace();
        }
    }

    /**
     * Lấy connection tới database
     *
     * @return Connection object
     * @throws SQLException nếu không kết nối được
     */
    public static Connection getConnection() throws SQLException {
        try {
            String url = properties.getProperty("db.url");
            String username = properties.getProperty("db.username");
            String password = properties.getProperty("db.password");

            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("✅ Database connected successfully!");
            return connection;
        } catch (SQLException e) {
            System.err.println("❌ Failed to connect to database!");
            System.err.println("URL: " + properties.getProperty("db.url"));
            System.err.println("Username: " + properties.getProperty("db.username"));
            System.err.println("Error: " + e.getMessage());
            throw e; // Throw exception thay vì return null
        }
    }

    /**
     * Đóng connection
     */
    public static void closeConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("✅ Database connection closed!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Failed to close database connection!");
            e.printStackTrace();
        }
    }
}
