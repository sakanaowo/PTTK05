package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.LoanSlipDAO;
import org.example.model.LoanSlip;
import org.example.model.Reader;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet xử lý hiển thị chi tiết phiếu mượn của reader
 * Module 2: Reader Detail - Loan Slips List
 */
@WebServlet(name = "ReaderDetailServlet", urlPatterns = {"/readerDetail"})
public class ReaderDetailServlet extends HttpServlet {

    private LoanSlipDAO loanSlipDAO;
    private SimpleDateFormat dateFormat;

    @Override
    public void init() throws ServletException {
        super.init();
        loanSlipDAO = new LoanSlipDAO();
        dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Get parameters
        String readerIdStr = request.getParameter("readerId");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String readerName = request.getParameter("readerName");

        // Validate parameters
        if (readerIdStr == null || startDateStr == null || endDateStr == null) {
            response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
            return;
        }

        try {
            int readerId = Integer.parseInt(readerIdStr);
            Date startDate = dateFormat.parse(startDateStr);
            Date endDate = dateFormat.parse(endDateStr);

            // Get loan slips for reader
            List<LoanSlip> loanSlipList = loanSlipDAO.getLoanSlipList(readerId, startDate, endDate);

            // Create Reader object for display
            Reader reader = new Reader();
            reader.setReaderId(readerId);
            if (readerName != null) {
                reader.setName(readerName);
            }

            // Set attributes
            request.setAttribute("reader", reader);
            request.setAttribute("loanSlipList", loanSlipList);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);

            if (loanSlipList.isEmpty()) {
                request.setAttribute("message", "No loan slips found for this reader in the selected period");
            }

            // Forward to detail page
            request.getRequestDispatcher("/module2/ReaderDetailInterface.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid reader ID");
            response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
            response.sendRedirect(request.getContextPath() + "/viewReaderStatistic");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred: " + e.getMessage());
            request.getRequestDispatcher("/module2/ReaderDetailInterface.jsp").forward(request, response);
        }
    }
}

