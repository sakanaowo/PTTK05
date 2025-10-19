package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.DocumentDAO;
import org.example.model.Document;

import java.io.IOException;

/**
 * Servlet xử lý hiển thị chi tiết tài liệu
 * Module 1: Search Document - Document Detail
 */
@WebServlet(name = "DocumentDetailServlet", urlPatterns = {"/documentDetail"})
public class DocumentDetailServlet extends HttpServlet {

    private DocumentDAO documentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        documentDAO = new DocumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Get documentId parameter
        String documentIdStr = request.getParameter("documentId");

        if (documentIdStr == null || documentIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/searchDocument");
            return;
        }

        try {
            int documentId = Integer.parseInt(documentIdStr);

            // Get document detail
            Document document = documentDAO.getDocument(documentId);

            if (document == null) {
                request.setAttribute("error", "Document not found with ID: " + documentId);
                request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);
                return;
            }

            // Set attribute and forward
            request.setAttribute("document", document);
            request.getRequestDispatcher("/module1/DocumentDetailInterface.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid document ID");
            request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred: " + e.getMessage());
            request.getRequestDispatcher("/module1/SearchDocInterface.jsp").forward(request, response);
        }
    }
}
