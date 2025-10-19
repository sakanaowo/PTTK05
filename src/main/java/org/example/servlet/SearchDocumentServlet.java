package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.DocumentDAO;
import org.example.model.Document;

import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý tìm kiếm tài liệu
 * Module 1: Search Document
 */
@WebServlet(name = "SearchDocumentServlet", urlPatterns = {"/searchDocument"})
public class SearchDocumentServlet extends HttpServlet {

    private DocumentDAO documentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        documentDAO = new DocumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to search interface
        request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Get search keyword
        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("error", "Please enter a document name to search");
            request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);
            return;
        }

        try {
            // Search documents
            List<Document> documentList = documentDAO.getDocumentList(keyword.trim());

            // Set attributes
            request.setAttribute("keyword", keyword);
            request.setAttribute("documentList", documentList);

            if (documentList.isEmpty()) {
                request.setAttribute("message", "No documents found for keyword: " + keyword);
            }

            // Forward to result page
            request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred while searching: " + e.getMessage());
            request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);
        }
    }
}

