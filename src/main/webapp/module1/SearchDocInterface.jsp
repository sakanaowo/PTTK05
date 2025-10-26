<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Document - LibMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Search Document</h1>
            <p>Tìm kiếm tài liệu trong thư viện</p>
        </header>

        <div class="content">
            <!-- Search Form -->
            <div class="search-form">
                <form action="${pageContext.request.contextPath}/searchDocument" method="post">
                    <div class="form-group">
                        <label for="keyword">Nhập tên tài liệu:</label>
                        <input type="text" id="keyword" name="keyword"
                               value="${keyword}"
                               placeholder="Ví dụ: Toán, Java, Lập trình..."
                               required>
                    </div>
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
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

            <!-- Search Results -->
            <c:if test="${not empty documentList}">
                <div class="results">
                    <h2>Kết quả tìm kiếm (${documentList.size()} tài liệu)</h2>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên tài liệu</th>
                                <th>Tác giả</th>
                                <th>Trạng thái</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="doc" items="${documentList}">
                                <tr>
                                    <td>${doc.documentId}</td>
                                    <td>${doc.name}</td>
                                    <td>${doc.author}</td>
                                    <td>
                                        <span class="status status-${doc.status}">
                                            ${doc.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/documentDetail?documentId=${doc.documentId}"
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
                <a href="${pageContext.request.contextPath}/HomeInterface.jsp" class="btn btn-back">
                    ← Quay lại trang chủ
                </a>
            </div>
        </div>

        <footer>
            <p>&copy; 2025 LibMan System</p>
        </footer>
    </div>
</body>
</html>
