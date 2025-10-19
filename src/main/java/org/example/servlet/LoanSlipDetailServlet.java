package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.LoanSlipDAO;
import org.example.model.LoanSlip;

import java.io.IOException;

/**
 * Servlet xử lý hiển thị chi tiết phiếu mượn
 * Module 2: Loan Slip Detail
 */
@WebServlet(name = "LoanSlipDetailServlet", urlPatterns = {"/loanSlipDetail"})
public class LoanSlipDetailServlet extends HttpServlet {

    private LoanSlipDAO loanSlipDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        loanSlipDAO = new LoanSlipDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Get loanId parameter
        String loanIdStr = request.getParameter("loanId");

        if (loanIdStr == null || loanIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
            return;
        }

        try {
            int loanId = Integer.parseInt(loanIdStr);

            // Get loan slip with full details
            LoanSlip loanSlip = loanSlipDAO.getLoanSlip(loanId);

            if (loanSlip == null) {
                request.setAttribute("error", "Loan slip not found with ID: " + loanId);
                response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
                return;
            }

            // Set attribute and forward
            request.setAttribute("loanSlip", loanSlip);
            request.getRequestDispatcher("/module2/LoanDetailInterface.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid loan slip ID");
            response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
        }
    }
}
