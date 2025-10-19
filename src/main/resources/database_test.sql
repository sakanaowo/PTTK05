-- ============================================
-- TEST SCRIPT FOR LIBMAN DATABASE
-- Library Management System - Đề 05 - B21DCCN678
-- ============================================

USE libman;

-- ============================================
-- 1. TEST DATA INTEGRITY
-- ============================================

-- Test 1.1: Verify all tables exist
SELECT 'Test 1.1: Checking all tables exist...' AS test_description;
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'libman'
ORDER BY TABLE_NAME;

-- Test 1.2: Count records in each table
SELECT 'Test 1.2: Count records in each table...' AS test_description;
SELECT 'tblUser' AS table_name, COUNT(*) AS record_count FROM tblUser
UNION ALL
SELECT 'tblReader', COUNT(*) FROM tblReader
UNION ALL
SELECT 'tblStaff', COUNT(*) FROM tblStaff
UNION ALL
SELECT 'tblReaderCard', COUNT(*) FROM tblReaderCard
UNION ALL
SELECT 'tblDocument', COUNT(*) FROM tblDocument
UNION ALL
SELECT 'tblSupplier', COUNT(*) FROM tblSupplier
UNION ALL
SELECT 'tblLoanSlip', COUNT(*) FROM tblLoanSlip
UNION ALL
SELECT 'tblLoanDetail', COUNT(*) FROM tblLoanDetail
UNION ALL
SELECT 'tblReturnSlip', COUNT(*) FROM tblReturnSlip
UNION ALL
SELECT 'tblReturnSlipDetail', COUNT(*) FROM tblReturnSlipDetail
UNION ALL
SELECT 'tblInvoice', COUNT(*) FROM tblInvoice
UNION ALL
SELECT 'tblInvoiceDetail', COUNT(*) FROM tblInvoiceDetail;

-- ============================================
-- 2. TEST FOREIGN KEY RELATIONSHIPS
-- ============================================

-- Test 2.1: Verify Reader-User relationship
SELECT 'Test 2.1: Verify Reader-User relationship...' AS test_description;
SELECT r.readerId, u.name, u.username, u.phone
FROM tblReader r
INNER JOIN tblUser u ON r.tblUserId = u.id;

-- Test 2.2: Verify Staff-User relationship
SELECT 'Test 2.2: Verify Staff-User relationship...' AS test_description;
SELECT s.staffId, s.role, u.name, u.username
FROM tblStaff s
INNER JOIN tblUser u ON s.tblUserId = u.id;

-- Test 2.3: Verify ReaderCard-Reader relationship
SELECT 'Test 2.3: Verify ReaderCard-Reader relationship...' AS test_description;
SELECT rc.readerCardId, rc.expDate, r.readerId, u.name
FROM tblReaderCard rc
INNER JOIN tblReader r ON rc.tblReaderReaderId = r.readerId
INNER JOIN tblUser u ON r.tblUserId = u.id;

-- ============================================
-- 3. TEST LOAN SLIP FUNCTIONALITY
-- ============================================

-- Test 3.1: Get all loan slips with reader and staff information
SELECT 'Test 3.1: Loan slips with reader and staff info...' AS test_description;
SELECT
    ls.loanId,
    ls.loanDate,
    ls.returnDate,
    u_reader.name AS reader_name,
    u_staff.name AS staff_name
FROM tblLoanSlip ls
INNER JOIN tblReader r ON ls.tblReaderReaderId = r.readerId
INNER JOIN tblUser u_reader ON r.tblUserId = u_reader.id
INNER JOIN tblStaff s ON ls.tblStaffStaffId = s.staffId
INNER JOIN tblUser u_staff ON s.tblUserId = u_staff.id
ORDER BY ls.loanDate DESC;

-- Test 3.2: Get loan details with document information
SELECT 'Test 3.2: Loan details with documents...' AS test_description;
SELECT
    ls.loanId,
    ls.loanDate,
    d.name AS document_name,
    d.author,
    d.status
FROM tblLoanSlip ls
INNER JOIN tblLoanDetail ld ON ls.loanId = ld.tblLoanSlipLoanId
INNER JOIN tblDocument d ON ld.tblDocumentDocumentId = d.documentId
ORDER BY ls.loanId;

-- Test 3.3: Count documents per loan slip
SELECT 'Test 3.3: Count documents per loan slip...' AS test_description;
SELECT
    ls.loanId,
    ls.loanDate,
    u.name AS reader_name,
    COUNT(ld.id) AS document_count
FROM tblLoanSlip ls
INNER JOIN tblReader r ON ls.tblReaderReaderId = r.readerId
INNER JOIN tblUser u ON r.tblUserId = u.id
LEFT JOIN tblLoanDetail ld ON ls.loanId = ld.tblLoanSlipLoanId
GROUP BY ls.loanId, ls.loanDate, u.name
ORDER BY ls.loanId;

-- ============================================
-- 4. TEST READER STATISTICS
-- ============================================

-- Test 4.1: Count total loans per reader
SELECT 'Test 4.1: Total loans per reader...' AS test_description;
SELECT
    u.name AS reader_name,
    u.username,
    COUNT(ls.loanId) AS total_loans
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
LEFT JOIN tblLoanSlip ls ON r.readerId = ls.tblReaderReaderId
GROUP BY u.id, u.name, u.username
ORDER BY total_loans DESC;

-- Test 4.2: Count total documents borrowed per reader
SELECT 'Test 4.2: Total documents borrowed per reader...' AS test_description;
SELECT
    u.name AS reader_name,
    COUNT(DISTINCT ls.loanId) AS total_loan_slips,
    COUNT(ld.id) AS total_documents_borrowed
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
LEFT JOIN tblLoanSlip ls ON r.readerId = ls.tblReaderReaderId
LEFT JOIN tblLoanDetail ld ON ls.loanId = ld.tblLoanSlipLoanId
GROUP BY u.id, u.name
ORDER BY total_documents_borrowed DESC;

-- Test 4.3: Most active reader (by number of loan slips)
SELECT 'Test 4.3: Most active reader...' AS test_description;
SELECT
    u.name AS reader_name,
    u.username,
    u.phone,
    COUNT(ls.loanId) AS total_loans
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
LEFT JOIN tblLoanSlip ls ON r.readerId = ls.tblReaderReaderId
GROUP BY u.id, u.name, u.username, u.phone
ORDER BY total_loans DESC
LIMIT 1;

-- ============================================
-- 5. TEST DOCUMENT STATISTICS
-- ============================================

-- Test 5.1: Most borrowed documents
SELECT 'Test 5.1: Most borrowed documents...' AS test_description;
SELECT
    d.documentId,
    d.name,
    d.author,
    d.status,
    COUNT(ld.id) AS times_borrowed
FROM tblDocument d
LEFT JOIN tblLoanDetail ld ON d.documentId = ld.tblDocumentDocumentId
GROUP BY d.documentId, d.name, d.author, d.status
ORDER BY times_borrowed DESC;

-- Test 5.2: Documents by status
SELECT 'Test 5.2: Documents by status...' AS test_description;
SELECT
    status,
    COUNT(*) AS document_count
FROM tblDocument
GROUP BY status;

-- Test 5.3: Available documents
SELECT 'Test 5.3: Available documents...' AS test_description;
SELECT
    documentId,
    name,
    author,
    supplier,
    status
FROM tblDocument
WHERE status = 'Còn sẵn';

-- ============================================
-- 6. TEST RETURN SLIP FUNCTIONALITY
-- ============================================

-- Test 6.1: Get all return slips with details
SELECT 'Test 6.1: Return slips with details...' AS test_description;
SELECT
    rs.returnSlipId,
    rs.returnDate,
    u_reader.name AS reader_name,
    u_staff.name AS staff_name,
    d.name AS document_name
FROM tblReturnSlip rs
INNER JOIN tblReader r ON rs.tblReaderReaderId = r.readerId
INNER JOIN tblUser u_reader ON r.tblUserId = u_reader.id
INNER JOIN tblStaff s ON rs.tblStaffStaffId = s.staffId
INNER JOIN tblUser u_staff ON s.tblUserId = u_staff.id
INNER JOIN tblReturnSlipDetail rsd ON rs.returnSlipId = rsd.tblReturnSlipReturnSlipId
INNER JOIN tblDocument d ON rsd.tblDocumentDocumentId = d.documentId
ORDER BY rs.returnDate DESC;

-- Test 6.2: Count documents returned per reader
SELECT 'Test 6.2: Documents returned per reader...' AS test_description;
SELECT
    u.name AS reader_name,
    COUNT(rsd.id) AS documents_returned
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
LEFT JOIN tblReturnSlip rs ON r.readerId = rs.tblReaderReaderId
LEFT JOIN tblReturnSlipDetail rsd ON rs.returnSlipId = rsd.tblReturnSlipReturnSlipId
GROUP BY u.id, u.name
HAVING documents_returned > 0
ORDER BY documents_returned DESC;

-- ============================================
-- 7. TEST INVOICE FUNCTIONALITY
-- ============================================

-- Test 7.1: Get all invoices with supplier information
SELECT 'Test 7.1: Invoices with supplier info...' AS test_description;
SELECT
    i.invoiceId,
    i.amount,
    i.importDate,
    sup.name AS supplier_name,
    u.name AS staff_name
FROM tblInvoice i
INNER JOIN tblSupplier sup ON i.tblSupplierSupplierId = sup.supplierId
INNER JOIN tblStaff s ON i.tblStaffStaffId = s.staffId
INNER JOIN tblUser u ON s.tblUserId = u.id
ORDER BY i.importDate DESC;

-- Test 7.2: Invoice details with documents
SELECT 'Test 7.2: Invoice details with documents...' AS test_description;
SELECT
    i.invoiceId,
    i.importDate,
    i.amount,
    d.name AS document_name,
    d.author,
    sup.name AS supplier_name
FROM tblInvoice i
INNER JOIN tblInvoiceDetail id ON i.invoiceId = id.tblInvoiceInvoiceId
INNER JOIN tblDocument d ON id.tblDocumentDocumentId = d.documentId
INNER JOIN tblSupplier sup ON i.tblSupplierSupplierId = sup.supplierId
ORDER BY i.invoiceId;

-- Test 7.3: Total amount by supplier
SELECT 'Test 7.3: Total amount by supplier...' AS test_description;
SELECT
    sup.name AS supplier_name,
    sup.phone,
    sup.address,
    SUM(i.amount) AS total_amount,
    COUNT(i.invoiceId) AS invoice_count
FROM tblSupplier sup
LEFT JOIN tblInvoice i ON sup.supplierId = i.tblSupplierSupplierId
GROUP BY sup.supplierId, sup.name, sup.phone, sup.address
ORDER BY total_amount DESC;

-- ============================================
-- 8. TEST COMPLEX QUERIES
-- ============================================

-- Test 8.1: Readers with expired cards (as of current date)
SELECT 'Test 8.1: Readers with expired cards...' AS test_description;
SELECT
    u.name AS reader_name,
    u.username,
    u.phone,
    rc.expDate,
    DATEDIFF(rc.expDate, CURDATE()) AS days_until_expiry
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
INNER JOIN tblReaderCard rc ON r.readerId = rc.tblReaderReaderId
WHERE rc.expDate < CURDATE()
ORDER BY rc.expDate;

-- Test 8.2: Readers with cards expiring soon (within 30 days)
SELECT 'Test 8.2: Readers with cards expiring within 30 days...' AS test_description;
SELECT
    u.name AS reader_name,
    u.username,
    u.phone,
    rc.expDate,
    DATEDIFF(rc.expDate, CURDATE()) AS days_until_expiry
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
INNER JOIN tblReaderCard rc ON r.readerId = rc.tblReaderReaderId
WHERE rc.expDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY rc.expDate;

-- Test 8.3: Overdue loans (return date passed but not returned)
SELECT 'Test 8.3: Overdue loans...' AS test_description;
SELECT
    ls.loanId,
    ls.loanDate,
    ls.returnDate,
    DATEDIFF(CURDATE(), ls.returnDate) AS days_overdue,
    u.name AS reader_name,
    u.phone,
    d.name AS document_name
FROM tblLoanSlip ls
INNER JOIN tblReader r ON ls.tblReaderReaderId = r.readerId
INNER JOIN tblUser u ON r.tblUserId = u.id
INNER JOIN tblLoanDetail ld ON ls.loanId = ld.tblLoanSlipLoanId
INNER JOIN tblDocument d ON ld.tblDocumentDocumentId = d.documentId
LEFT JOIN tblReturnSlipDetail rsd ON d.documentId = rsd.tblDocumentDocumentId
WHERE ls.returnDate < CURDATE()
  AND rsd.id IS NULL
ORDER BY days_overdue DESC;

-- Test 8.4: Borrowing history for specific reader (readerC)
SELECT 'Test 8.4: Borrowing history for readerC...' AS test_description;
SELECT
    ls.loanId,
    ls.loanDate,
    ls.returnDate,
    d.name AS document_name,
    d.author,
    CASE
        WHEN rsd.id IS NOT NULL THEN 'Đã trả'
        WHEN ls.returnDate < CURDATE() THEN 'Quá hạn'
        ELSE 'Đang mượn'
    END AS status
FROM tblUser u
INNER JOIN tblReader r ON u.id = r.tblUserId
INNER JOIN tblLoanSlip ls ON r.readerId = ls.tblReaderReaderId
INNER JOIN tblLoanDetail ld ON ls.loanId = ld.tblLoanSlipLoanId
INNER JOIN tblDocument d ON ld.tblDocumentDocumentId = d.documentId
LEFT JOIN tblReturnSlipDetail rsd ON d.documentId = rsd.tblDocumentDocumentId
WHERE u.username = 'readerC'
ORDER BY ls.loanDate DESC;

-- Test 8.5: Documents never borrowed
SELECT 'Test 8.5: Documents never borrowed...' AS test_description;
SELECT
    d.documentId,
    d.name,
    d.author,
    d.supplier,
    d.status
FROM tblDocument d
LEFT JOIN tblLoanDetail ld ON d.documentId = ld.tblDocumentDocumentId
WHERE ld.id IS NULL;

-- ============================================
-- 9. TEST DATA VALIDATION
-- ============================================

-- Test 9.1: Check for orphaned records in tblReader
SELECT 'Test 9.1: Check for orphaned readers...' AS test_description;
SELECT
    r.readerId,
    r.tblUserId
FROM tblReader r
LEFT JOIN tblUser u ON r.tblUserId = u.id
WHERE u.id IS NULL;

-- Test 9.2: Check for orphaned records in tblStaff
SELECT 'Test 9.2: Check for orphaned staff...' AS test_description;
SELECT
    s.staffId,
    s.tblUserId
FROM tblStaff s
LEFT JOIN tblUser u ON s.tblUserId = u.id
WHERE u.id IS NULL;

-- Test 9.3: Check for loan details without valid documents
SELECT 'Test 9.3: Check for invalid loan details...' AS test_description;
SELECT
    ld.id,
    ld.tblLoanSlipLoanId,
    ld.tblDocumentDocumentId
FROM tblLoanDetail ld
LEFT JOIN tblDocument d ON ld.tblDocumentDocumentId = d.documentId
WHERE d.documentId IS NULL;

-- ============================================
-- 10. TEST SUMMARY STATISTICS
-- ============================================

-- Test 10.1: Overall system statistics
SELECT 'Test 10.1: Overall system statistics...' AS test_description;
SELECT
    (SELECT COUNT(*) FROM tblUser) AS total_users,
    (SELECT COUNT(*) FROM tblReader) AS total_readers,
    (SELECT COUNT(*) FROM tblStaff) AS total_staff,
    (SELECT COUNT(*) FROM tblDocument) AS total_documents,
    (SELECT COUNT(*) FROM tblDocument WHERE status = 'Còn sẵn') AS available_documents,
    (SELECT COUNT(*) FROM tblLoanSlip) AS total_loans,
    (SELECT COUNT(*) FROM tblReturnSlip) AS total_returns,
    (SELECT COUNT(*) FROM tblInvoice) AS total_invoices,
    (SELECT SUM(amount) FROM tblInvoice) AS total_invoice_amount;

-- ============================================
-- TEST SCRIPT COMPLETED
-- ============================================
SELECT 'All tests completed successfully!' AS test_result;

