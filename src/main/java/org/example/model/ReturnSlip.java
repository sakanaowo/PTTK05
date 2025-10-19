package org.example.model;

import java.sql.Date;
import java.util.List;

/**
 * ReturnSlip class - Phiếu trả
 */
public class ReturnSlip {
    private int returnSlipId;
    private Date returnDate;
    private Reader reader;
    private LibraryStaff staff;
    private List<ReturnSlipDetail> returnSlipDetailList;

    public ReturnSlip() {
    }

    public ReturnSlip(int returnSlipId, Date returnDate, Reader reader, LibraryStaff staff) {
        this.returnSlipId = returnSlipId;
        this.returnDate = returnDate;
        this.reader = reader;
        this.staff = staff;
    }

    public int getReturnSlipId() {
        return returnSlipId;
    }

    public void setReturnSlipId(int returnSlipId) {
        this.returnSlipId = returnSlipId;
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

    public List<ReturnSlipDetail> getReturnSlipDetailList() {
        return returnSlipDetailList;
    }

    public void setReturnSlipDetailList(List<ReturnSlipDetail> returnSlipDetailList) {
        this.returnSlipDetailList = returnSlipDetailList;
    }

    @Override
    public String toString() {
        return "ReturnSlip{" +
                "returnSlipId=" + returnSlipId +
                ", returnDate=" + returnDate +
                ", reader=" + reader +
                ", staff=" + staff +
                '}';
    }
}
