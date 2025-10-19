package org.example.model;

import java.sql.Date;
import java.util.List;

/**
 * Invoice class - Hóa đơn
 */
public class Invoice {
    private int invoiceId;
    private float amount;
    private Date importDate;
    private LibraryStaff staff;
    private Supplier supplier;
    private List<InvoiceDetail> invoiceDetailList;

    public Invoice() {
    }

    public Invoice(int invoiceId, float amount, Date importDate, LibraryStaff staff, Supplier supplier) {
        this.invoiceId = invoiceId;
        this.amount = amount;
        this.importDate = importDate;
        this.staff = staff;
        this.supplier = supplier;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public LibraryStaff getStaff() {
        return staff;
    }

    public void setStaff(LibraryStaff staff) {
        this.staff = staff;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public List<InvoiceDetail> getInvoiceDetailList() {
        return invoiceDetailList;
    }

    public void setInvoiceDetailList(List<InvoiceDetail> invoiceDetailList) {
        this.invoiceDetailList = invoiceDetailList;
    }

    @Override
    public String toString() {
        return "Invoice{" +
                "invoiceId=" + invoiceId +
                ", amount=" + amount +
                ", importDate=" + importDate +
                ", staff=" + staff +
                ", supplier=" + supplier +
                '}';
    }
}
