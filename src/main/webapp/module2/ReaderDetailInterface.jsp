<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reader Detail - LibMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Reader Loan Slip Details</h1>
            <p>Chi tiết các phiếu mượn của bạn đọc</p>
        </header>

        <div class="content">
            <!-- Reader Information -->
            <c:if test="${not empty reader}">
                <div class="info-card">
                    <h3>Thông tin bạn đọc</h3>
                    <p><strong>Reader ID:</strong> ${reader.readerId}</p>
                    <p><strong>Tên bạn đọc:</strong> ${reader.name}</p>
                </div>
            </c:if>

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

            <!-- Loan Slips List -->
            <c:if test="${not empty loanSlipList}">
                <div class="results">
                    <h2>Danh sách phiếu mượn</h2>
                    <p>Khoảng thời gian: <strong>${startDate}</strong> đến <strong>${endDate}</strong></p>
                    <p>Tổng số phiếu mượn: <strong>${loanSlipList.size()}</strong></p>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Loan ID</th>
                                <th>Ngày mượn</th>
                                <th>Ngày trả dự kiến</th>
                                <th>Trạng thái</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="slip" items="${loanSlipList}">
                                <tr>
                                    <td>${slip.loanId}</td>
                                    <td>
                                        <fmt:formatDate value="${slip.loanDate}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty slip.returnDate}">
                                                <fmt:formatDate value="${slip.returnDate}" pattern="dd/MM/yyyy" />
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa trả</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty slip.returnDate}">
                                                <span class="badge badge-success">Đã trả</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning">Đang mượn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/loanSlipDetail?loanId=${slip.loanId}"
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
                <a href="javascript:history.back()" class="btn btn-back">
                    ← Quay lại
                </a>
                <a href="${pageContext.request.contextPath}/viewReaderStatistic" class="btn btn-primary">
                    Xem thống kê
                </a>
                <a href="${pageContext.request.contextPath}/HomeInterface.jsp" class="btn btn-secondary">
                    Về trang chủ
                </a>
            </div>
        </div>

        <footer>
            <p>&copy; 2025 LibMan System</p>
        </footer>
    </div>
</body>
</html>
