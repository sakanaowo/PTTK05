<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reader Statistics - LibMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📊 Reader Statistics by Loan Number</h1>
            <p>Thống kê bạn đọc theo số lần mượn sách</p>
        </header>

        <div class="content">
            <!-- Date Selection Form -->
            <div class="search-form">
                <form action="${pageContext.request.contextPath}/viewReaderStatistic" method="post">
                    <h3>Chọn khoảng thời gian thống kê</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="startDate">Từ ngày:</label>
                            <input type="date" id="startDate" name="startDate"
                                   value="${startDate}" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">Đến ngày:</label>
                            <input type="date" id="endDate" name="endDate"
                                   value="${endDate}" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Xem thống kê</button>
                </form>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <strong>Lỗi:</strong> ${error}
                </div>
            </c:if>

            <!-- Info Message -->
            <c:if test="${not empty message}">
                <div class="alert alert-info">
                    ${message}
                </div>
            </c:if>

            <!-- Statistics Results -->
            <c:if test="${not empty statisticList}">
                <div class="results">
                    <h2>Kết quả thống kê</h2>
                    <p>Thời gian: <strong>${startDate}</strong> đến <strong>${endDate}</strong></p>
                    <p>Tổng số bạn đọc: <strong>${statisticList.size()}</strong></p>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Reader ID</th>
                                <th>Tên bạn đọc</th>
                                <th>Số điện thoại</th>
                                <th>Số lần mượn</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="stat" items="${statisticList}">
                                <tr>
                                    <td>${stat.reader.readerId}</td>
                                    <td>${stat.reader.name}</td>
                                    <td>${stat.reader.phone}</td>
                                    <td>
                                        <span class="badge badge-success">${stat.loanNumber}</span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/readerDetail?readerId=${stat.reader.readerId}&startDate=${startDate}&endDate=${endDate}&readerName=${stat.reader.name}"
                                           class="btn btn-sm btn-info">
                                            Xem chi tiết
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Navigation -->
            <div class="actions">
                <a href="${pageContext.request.contextPath}/module2/ViewStatisticInterface.jsp" class="btn btn-back">
                    ← Quay lại
                </a>
                <a href="${pageContext.request.contextPath}/HomeInterface.jsp" class="btn btn-secondary">
                    Về trang chủ
                </a>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 LibMan System - Module 2</p>
        </footer>
    </div>
</body>
</html>

