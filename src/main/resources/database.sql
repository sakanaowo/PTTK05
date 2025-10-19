-- Hệ thống quản lý thư viện LibMan
-- Đề 05 - B21DCCN678

CREATE
DATABASE IF NOT EXISTS libman;
USE
libman;

-- Bảng User (Thành viên)
CREATE TABLE tblUser
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(255)        NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255)        NOT NULL,
    birth    DATE,
    phone    VARCHAR(20)
);

-- Bảng Reader (Bạn đọc)
CREATE TABLE tblReader
(
    readerId  INT PRIMARY KEY AUTO_INCREMENT,
    tblUserId INT NOT NULL,
    FOREIGN KEY (tblUserId) REFERENCES tblUser (id)
);

-- Bảng Staff (Nhân viên)
CREATE TABLE tblStaff
(
    staffId   INT PRIMARY KEY AUTO_INCREMENT,
    role      VARCHAR(255) NOT NULL,
    tblUserId INT          NOT NULL,
    FOREIGN KEY (tblUserId) REFERENCES tblUser (id)
);

-- Bảng Reader Card (Thẻ bạn đọc)
CREATE TABLE tblReaderCard
(
    readerCardId      INT PRIMARY KEY AUTO_INCREMENT,
    expDate           DATE NOT NULL,
    tblReaderReaderId INT  NOT NULL,
    FOREIGN KEY (tblReaderReaderId) REFERENCES tblReader (readerId)
);

-- Bảng Document (Tài liệu)
CREATE TABLE tblDocument
(
    documentId INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(255) NOT NULL,
    author     VARCHAR(255),
    supplier   VARCHAR(255),
    status     VARCHAR(50) DEFAULT 'Còn sẵn'
);

-- Bảng Supplier (Nhà cung cấp)
CREATE TABLE tblSupplier
(
    supplierId INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(255) NOT NULL,
    phone      VARCHAR(20),
    address    VARCHAR(255)
);

-- Bảng Loan Slip (Phiếu mượn)
CREATE TABLE tblLoanSlip
(
    loanId            INT PRIMARY KEY AUTO_INCREMENT,
    loanDate          DATE NOT NULL,
    returnDate        DATE NOT NULL,
    tblReaderReaderId INT  NOT NULL,
    tblStaffStaffId   INT  NOT NULL,
    FOREIGN KEY (tblReaderReaderId) REFERENCES tblReader (readerId),
    FOREIGN KEY (tblStaffStaffId) REFERENCES tblStaff (staffId)
);

-- Bảng Loan Detail (Chi tiết phiếu mượn)
CREATE TABLE tblLoanDetail
(
    id                    INT PRIMARY KEY AUTO_INCREMENT,
    tblLoanSlipLoanId     INT NOT NULL,
    tblDocumentDocumentId INT NOT NULL,
    FOREIGN KEY (tblLoanSlipLoanId) REFERENCES tblLoanSlip (loanId),
    FOREIGN KEY (tblDocumentDocumentId) REFERENCES tblDocument (documentId)
);

-- Bảng Return Slip (Phiếu trả)
CREATE TABLE tblReturnSlip
(
    returnSlipId      INT PRIMARY KEY AUTO_INCREMENT,
    returnDate        DATE NOT NULL,
    tblReaderReaderId INT  NOT NULL,
    tblStaffStaffId   INT  NOT NULL,
    FOREIGN KEY (tblReaderReaderId) REFERENCES tblReader (readerId),
    FOREIGN KEY (tblStaffStaffId) REFERENCES tblStaff (staffId)
);

-- Bảng Return Slip Detail (Chi tiết phiếu trả)
CREATE TABLE tblReturnSlipDetail
(
    id                        INT PRIMARY KEY AUTO_INCREMENT,
    tblReturnSlipReturnSlipId INT NOT NULL,
    tblDocumentDocumentId     INT NOT NULL,
    FOREIGN KEY (tblReturnSlipReturnSlipId) REFERENCES tblReturnSlip (returnSlipId),
    FOREIGN KEY (tblDocumentDocumentId) REFERENCES tblDocument (documentId)
);

-- Bảng Invoice (Hóa đơn)
CREATE TABLE tblInvoice
(
    invoiceId             INT PRIMARY KEY AUTO_INCREMENT,
    amount                FLOAT NOT NULL,
    importDate            DATE  NOT NULL,
    tblStaffStaffId       INT   NOT NULL,
    tblSupplierSupplierId INT   NOT NULL,
    FOREIGN KEY (tblStaffStaffId) REFERENCES tblStaff (staffId),
    FOREIGN KEY (tblSupplierSupplierId) REFERENCES tblSupplier (supplierId)
);

-- Bảng Invoice Detail (Chi tiết hóa đơn)
CREATE TABLE tblInvoiceDetail
(
    id                    INT PRIMARY KEY AUTO_INCREMENT,
    tblInvoiceInvoiceId   INT NOT NULL,
    tblDocumentDocumentId INT NOT NULL,
    FOREIGN KEY (tblInvoiceInvoiceId) REFERENCES tblInvoice (invoiceId),
    FOREIGN KEY (tblDocumentDocumentId) REFERENCES tblDocument (documentId)
);

-- Insert dữ liệu mẫu

-- User (Thành viên)
INSERT INTO tblUser (name, username, password, birth, phone)
VALUES ('Trần Văn A', 'readerA', '123456', '2000-01-15', '0123456789'),
       ('Nguyễn Thị B', 'readerB', '123456', '1999-05-20', '0987654321'),
       ('Lê Văn C', 'readerC', '123456', '2001-03-10', '0912345678'),
       ('DC Ming', 'staffE', '123456', '1990-07-25', '0345678901'),
       ('Phạm Thị F', 'managerF', '123456', '1985-12-05', '0456789012');

-- Reader (Bạn đọc)
INSERT INTO tblReader (tblUserId)
VALUES (1),
       (2),
       (3);

-- Staff (Nhân viên)
INSERT INTO tblStaff (role, tblUserId)
VALUES ('Library Staff', 4),
       ('Manager', 5);

-- Reader Card (Thẻ bạn đọc)
INSERT INTO tblReaderCard (expDate, tblReaderReaderId)
VALUES ('2025-12-31', 1),
       ('2025-12-31', 2),
       ('2025-12-31', 3);

-- Document (Tài liệu)
INSERT INTO tblDocument (name, author, supplier, status)
VALUES ('Toán rời rạc 1', 'ABCD', 'Nhà sách ABC', 'Còn sẵn'),
       ('Toán rời rạc 2', 'Nguyễn Văn D', 'Nhà sách ABC', 'Đang được mượn'),
       ('Toán cao cấp', 'ABC', 'XYZ', 'Còn sẵn'),
       ('Cấu trúc dữ liệu', 'Trần Văn X', 'Nhà sách XYZ', 'Còn sẵn'),
       ('Lập trình Java', 'Hoàng Anh B', 'Nhà sách XYZ', 'Còn sẵn');

-- Supplier (Nhà cung cấp)
INSERT INTO tblSupplier (name, phone, address)
VALUES ('Nhà sách ABC', '0211234567', 'Hà Nội'),
       ('Nhà sách XYZ', '0287654321', 'TP.HCM');

-- Loan Slip (Phiếu mượn)
INSERT INTO tblLoanSlip (loanDate, returnDate, tblReaderReaderId, tblStaffStaffId)
VALUES ('2024-09-15', '2024-09-30', 3, 1),
       ('2024-09-20', '2024-10-05', 3, 1),
       ('2024-09-25', '2024-10-10', 3, 1),
       ('2024-08-10', '2024-08-25', 1, 1),
       ('2024-08-15', '2024-08-30', 1, 1),
       ('2024-07-20', '2024-08-05', 2, 1),
       ('2024-07-25', '2024-08-10', 2, 1),
       ('2024-06-30', '2024-07-15', 2, 1);

-- Loan Detail (Chi tiết phiếu mượn)
INSERT INTO tblLoanDetail (tblLoanSlipLoanId, tblDocumentDocumentId)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (3, 4),
       (4, 1),
       (4, 3),
       (5, 2),
       (5, 4),
       (5, 5),
       (6, 1),
       (6, 3),
       (7, 2),
       (8, 5);

-- Return Slip (Phiếu trả)
INSERT INTO tblReturnSlip (returnDate, tblReaderReaderId, tblStaffStaffId)
VALUES ('2024-08-24', 1, 1),
       ('2024-07-30', 2, 1);

-- Return Slip Detail (Chi tiết phiếu trả)
INSERT INTO tblReturnSlipDetail (tblReturnSlipReturnSlipId, tblDocumentDocumentId)
VALUES (1, 1),
       (1, 3),
       (2, 1);

-- Invoice (Hóa đơn)
INSERT INTO tblInvoice (amount, importDate, tblStaffStaffId, tblSupplierSupplierId)
VALUES (5000000, '2024-01-15', 1, 1),
       (3000000, '2024-02-20', 1, 2);

-- Invoice Detail (Chi tiết hóa đơn)
INSERT INTO tblInvoiceDetail (tblInvoiceInvoiceId, tblDocumentDocumentId)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (2, 4),
       (2, 5);
