<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Detail - LibMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📄 Document Details</h1>
            <p>Chi tiết thông tin tài liệu</p>
        </header>

        <div class="content">
            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <strong>Lỗi:</strong> ${error}
                </div>
            </c:if>

            <!-- Document Details -->
            <c:if test="${not empty document}">
                <div class="detail-card">
                    <h2>Thông tin tài liệu</h2>
                    <table class="detail-table">
                        <tr>
                            <th>Document ID:</th>
                            <td>${document.documentId}</td>
                        </tr>
                        <tr>
                            <th>Tên tài liệu:</th>
                            <td><strong>${document.name}</strong></td>
                        </tr>
                        <tr>
                            <th>Tác giả:</th>
                            <td>${document.author}</td>
                        </tr>
                        <tr>
                            <th>Nhà cung cấp:</th>
                            <td>${document.supplier}</td>
                        </tr>
                        <tr>
                            <th>Trạng thái:</th>
                            <td>
                                <span class="status status-${document.status}">
                                    ${document.status}
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
            </c:if>

            <!-- Navigation -->
            <div class="actions">
                <a href="javascript:history.back()" class="btn btn-back">
                    ← Quay lại
                </a>
                <a href="${pageContext.request.contextPath}/searchDocument" class="btn btn-primary">
                    Tìm kiếm khác
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

