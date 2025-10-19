<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Statistical Reports - LibMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📊 View Statistical Reports</h1>
            <p>Chọn loại báo cáo thống kê</p>
        </header>

        <div class="content">
            <div class="menu-grid">
                <!-- Reader Statistics by Loan Number -->
                <div class="menu-card">
                    <h3>👥 Thống kê bạn đọc</h3>
                    <p>Xem thống kê bạn đọc theo số lần mượn sách</p>
                    <a href="${pageContext.request.contextPath}/viewReaderStatistic" class="btn btn-primary">
                        Xem thống kê
                    </a>
                </div>

                <!-- Document Statistics (Not implemented) -->
                <div class="menu-card disabled">
                    <h3>📚 Thống kê tài liệu</h3>
                    <p>Xem thống kê tài liệu theo số lần mượn</p>
                    <button class="btn btn-secondary" disabled>Chưa triển khai</button>
                </div>

                <!-- Supplier Statistics (Not implemented) -->
                <div class="menu-card disabled">
                    <h3>🏢 Thống kê nhà cung cấp</h3>
                    <p>Xem thống kê nhà cung cấp</p>
                    <button class="btn btn-secondary" disabled>Chưa triển khai</button>
                </div>
            </div>

            <div class="actions">
                <a href="${pageContext.request.contextPath}/HomeInterface.jsp" class="btn btn-back">
                    ← Quay lại trang chủ
                </a>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 LibMan System - Module 2</p>
        </footer>
    </div>
</body>
</html>

