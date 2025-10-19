package org.example.model;

import java.sql.Date;
import java.util.List;

/**
 * LoanSlip class - Phiếu mượn
 */
public class LoanSlip {
    private int loanId;
    private Date loanDate;
    private Date returnDate;
    private Reader reader;
    private LibraryStaff staff;
    private List<LoanDetail> loanDetailList;

    public LoanSlip() {
    }

    public LoanSlip(int loanId, Date loanDate, Date returnDate, Reader reader, LibraryStaff staff, List<LoanDetail> loanDetailList) {
        this.loanId = loanId;
        this.loanDate = loanDate;
        this.returnDate = returnDate;
        this.reader = reader;
        this.staff = staff;
        this.loanDetailList = loanDetailList;
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public Date getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(Date loanDate) {
        this.loanDate = loanDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public LibraryStaff getStaff() {
        return staff;
    }

    public void setStaff(LibraryStaff staff) {
        this.staff = staff;
    }

    public List<LoanDetail> getLoanDetailList() {
        return loanDetailList;
    }

    public void setLoanDetailList(List<LoanDetail> loanDetailList) {
        this.loanDetailList = loanDetailList;
    }

    @Override
    public String toString() {
        return "LoanSlip{" +
                "loanId=" + loanId +
                ", loanDate=" + loanDate +
                ", returnDate=" + returnDate +
                ", reader=" + reader +
                ", staff=" + staff +
                '}';
    }
}
