package org.example.model;

/**
 * ReturnSlipDetail class - Chi tiết phiếu trả
 */
public class ReturnSlipDetail {
    private int id;
    private ReturnSlip returnSlip;
    private Document document;

    public ReturnSlipDetail() {
    }

    public ReturnSlipDetail(int id, ReturnSlip returnSlip, Document document) {
        this.id = id;
        this.returnSlip = returnSlip;
        this.document = document;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ReturnSlip getReturnSlip() {
        return returnSlip;
    }

    public void setReturnSlip(ReturnSlip returnSlip) {
        this.returnSlip = returnSlip;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    @Override
    public String toString() {
        return "ReturnSlipDetail{" +
                "id=" + id +
                ", document=" + document +
                '}';
    }
}
