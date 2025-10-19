package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.ReaderStatisticDAO;
import org.example.model.ReaderStatistic;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet xử lý xem thống kê bạn đọc theo số lần mượn
 * Module 2: View Reader Statistics by Loan Number
 */
@WebServlet(name = "ViewReaderStatisticServlet", urlPatterns = {"/viewReaderStatistic"})
public class ViewReaderStatisticServlet extends HttpServlet {

    private ReaderStatisticDAO readerStatisticDAO;
    private SimpleDateFormat dateFormat;

    @Override
    public void init() throws ServletException {
        super.init();
        readerStatisticDAO = new ReaderStatisticDAO();
        dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to statistic interface
        request.getRequestDispatcher("/module2/ReaderStatisticInterface.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Get date parameters
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        // Validate parameters
        if (startDateStr == null || startDateStr.trim().isEmpty() ||
            endDateStr == null || endDateStr.trim().isEmpty()) {
            request.setAttribute("error", "Please select both start date and end date");
            request.getRequestDispatcher("/module2/ReaderStatisticInterface.jsp").forward(request, response);
            return;
        }

        try {
            // Parse dates
            Date utilStartDate = dateFormat.parse(startDateStr);
            Date utilEndDate = dateFormat.parse(endDateStr);

            // Validate date range
            if (utilStartDate.after(utilEndDate)) {
                request.setAttribute("error", "Start date must be before end date");
                request.setAttribute("startDate", startDateStr);
                request.setAttribute("endDate", endDateStr);
                request.getRequestDispatcher("/module2/ReaderStatisticInterface.jsp").forward(request, response);
                return;
            }

            // Convert java.util.Date to java.sql.Date
            java.sql.Date sqlStartDate = new java.sql.Date(utilStartDate.getTime());
            java.sql.Date sqlEndDate = new java.sql.Date(utilEndDate.getTime());

            // Get reader statistics
            List<ReaderStatistic> statisticList = readerStatisticDAO.getReaderStatisticList(sqlStartDate, sqlEndDate);

            // Set attributes
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);
            request.setAttribute("statisticList", statisticList);

            if (statisticList.isEmpty()) {
                request.setAttribute("message", "No readers found in this period");
            }

            // Forward to result page
            request.getRequestDispatcher("/module2/ReaderStatisticInterface.jsp").forward(request, response);

        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD");
            request.getRequestDispatcher("/module2/ReaderStatisticInterface.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred while fetching statistics: " + e.getMessage());
            request.getRequestDispatcher("/module2/ReaderStatisticInterface.jsp").forward(request, response);
        }
    }
}
