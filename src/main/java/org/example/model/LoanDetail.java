package org.example.model;

/**
 * LoanDetail class - Chi tiết phiếu mượn
 */
public class LoanDetail {
    private int id;
    private LoanSlip loanSlip;
    private Document document;

    public LoanDetail() {
    }

    public LoanDetail(int id, LoanSlip loanSlip, Document document) {
        this.id = id;
        this.loanSlip = loanSlip;
        this.document = document;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LoanSlip getLoanSlip() {
        return loanSlip;
    }

    public void setLoanSlip(LoanSlip loanSlip) {
        this.loanSlip = loanSlip;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    @Override
    public String toString() {
        return "LoanDetail{" +
                "id=" + id +
                ", document=" + document +
                '}';
    }
}
