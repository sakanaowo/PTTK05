<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LibMan - Library Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📚 LibMan - Library Management System</h1>
            <p>Hệ thống quản lý thư viện</p>
        </header>

        <nav class="main-menu">
            <h2>Menu Chính</h2>
            <div class="menu-grid">
                <!-- Module 1: Search Document (Reader) -->
                <div class="menu-card">
                    <h3>🔍 Tìm kiếm tài liệu</h3>
                    <p>Tìm kiếm thông tin tài liệu trong thư viện</p>
                    <a href="${pageContext.request.contextPath}/searchDocument" class="btn btn-primary">
                        Tìm kiếm
                    </a>
                </div>

                <!-- Module 2: View Statistics (Manager) -->
                <div class="menu-card">
                    <h3>📊 Xem thống kê</h3>
                    <p>Xem các báo cáo thống kê bạn đọc</p>
                    <a href="${pageContext.request.contextPath}/module2/ViewStatisticInterface.jsp" class="btn btn-success">
                        Xem báo cáo
                    </a>
                </div>
            </div>
        </nav>

        <footer>
            <p>&copy; 2024 LibMan System - Đề 05 B21DCCN678</p>
        </footer>
    </div>
</body>
</html>

