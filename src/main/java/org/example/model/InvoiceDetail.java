package org.example.model;

/**
 * InvoiceDetail class - Chi tiết hóa đơn
 */
public class InvoiceDetail {
    private int id;
    private Invoice invoice;
    private Document document;

    public InvoiceDetail() {
    }

    public InvoiceDetail(int id, Invoice invoice, Document document) {
        this.id = id;
        this.invoice = invoice;
        this.document = document;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    @Override
    public String toString() {
        return "InvoiceDetail{" +
                "id=" + id +
                ", document=" + document +
                '}';
    }
}
