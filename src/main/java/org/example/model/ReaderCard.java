package org.example.model;

import java.sql.Date;

/**
 * ReaderCard class - Thẻ bạn đọc
 */
public class ReaderCard {
    private int readerCardId;
    private Date expDate;
    private Reader reader;

    public ReaderCard() {
    }

    public ReaderCard(int readerCardId, Date expDate, Reader reader) {
        this.readerCardId = readerCardId;
        this.expDate = expDate;
        this.reader = reader;
    }

    public int getReaderCardId() {
        return readerCardId;
    }

    public void setReaderCardId(int readerCardId) {
        this.readerCardId = readerCardId;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    @Override
    public String toString() {
        return "ReaderCard{" +
                "readerCardId=" + readerCardId +
                ", expDate=" + expDate +
                ", reader=" + reader +
                '}';
    }
}
