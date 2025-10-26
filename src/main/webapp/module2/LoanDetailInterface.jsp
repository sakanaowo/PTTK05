<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phiếu mượn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Chi tiết phiếu mượn</h1>
            <p>Thông tin chi tiết phiếu mượn sách</p>
        </header>

        <div class="content">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    Lỗi: ${error}
                </div>
            </c:if>

            <c:if test="${not empty loanSlip}">
                <!-- Hàng 1: Thông tin độc giả và thủ thư cùng hàng -->
                <div class="info-row">
                    <c:if test="${not empty loanSlip.reader}">
                        <div class="info-card">
                            <h3>Thông tin độc giả</h3>
                            <div class="detail-row">
                                <div class="detail-label">Mã độc giả:</div>
                                <div>${loanSlip.reader.readerId}</div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">Tên độc giả:</div>
                                <div>${loanSlip.reader.name}</div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">Số điện thoại:</div>
                                <div>${loanSlip.reader.phone}</div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty loanSlip.staff}">
                        <div class="info-card">
                            <h3>Thông tin thủ thư</h3>
                            <div class="detail-row">
                                <div class="detail-label">Mã thủ thư:</div>
                                <div>${loanSlip.staff.staffId}</div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">Tên thủ thư:</div>
                                <div>${loanSlip.staff.name}</div>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Phần dưới: Thông tin phiếu mượn -->
                <div class="detail-card">
                    <h3>Thông tin phiếu mượn</h3>
                    <div class="detail-row">
                        <div class="detail-label">Mã phiếu mượn:</div>
                        <div><strong>${loanSlip.loanId}</strong></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Ngày mượn:</div>
                        <div><fmt:formatDate value="${loanSlip.loanDate}" pattern="dd/MM/yyyy" /></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Ngày trả dự kiến:</div>
                        <div>
                            <c:choose>
                                <c:when test="${not empty loanSlip.returnDate}">
                                    <fmt:formatDate value="${loanSlip.returnDate}" pattern="dd/MM/yyyy" />
                                </c:when>
                                <c:otherwise>Chưa trả</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Danh sách tài liệu mượn -->
                <c:if test="${not empty loanSlip.loanDetailList}">
                    <div class="detail-card">
                        <h3>Danh sách tài liệu mượn (${loanSlip.loanDetailList.size()} tài liệu)</h3>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Mã tài liệu</th>
                                    <th>Tên tài liệu</th>
                                    <th>Tác giả</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${loanSlip.loanDetailList}">
                                    <tr>
                                        <td>${detail.document.documentId}</td>
                                        <td>${detail.document.name}</td>
                                        <td>${detail.document.author}</td>
                                        <td><span class="status status-${detail.document.status}">${detail.document.status}</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </c:if>

            <div class="actions">
                <a href="javascript:history.back()" class="btn btn-back">Quay lại</a>
                <a href="${pageContext.request.contextPath}/HomeInterface.jsp" class="btn btn-secondary">Trang chủ</a>
            </div>
        </div>

        <footer>
            <p>&copy; 2025 LibMan System</p>
        </footer>
    </div>
</body>
</html>
