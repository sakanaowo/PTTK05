package org.example.model;

/**
 * Document class - Tài liệu
 */
public class Document {
    private int documentId;
    private String name;
    private String author;
    private String supplier;
    private String status;

    public Document() {
    }

    public Document(int documentId, String name, String author, String supplier, String status) {
        this.documentId = documentId;
        this.name = name;
        this.author = author;
        this.supplier = supplier;
        this.status = status;
    }

    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Document{" +
                "documentId=" + documentId +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", supplier='" + supplier + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
