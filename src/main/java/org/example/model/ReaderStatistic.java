package org.example.model;

/**
 * ReaderStatistic class - Thống kê bạn đọc
 * View model cho MODULE 2: View Reader Statistics
 */
public class ReaderStatistic {
    private Reader reader;
    private int loanNumber;

    public ReaderStatistic() {
    }

    public ReaderStatistic(Reader reader, int loanNumber) {
        this.reader = reader;
        this.loanNumber = loanNumber;
    }

    // Getters and Setters
    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

    public int getLoanNumber() {
        return loanNumber;
    }

    public void setLoanNumber(int loanNumber) {
        this.loanNumber = loanNumber;
    }

    @Override
    public String toString() {
        return "ReaderStatistic{" +
                "reader=" + reader +
                ", loanNumber=" + loanNumber +
                '}';
    }
}

