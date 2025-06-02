package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Discount implements Serializable {
    private int iD;
    private String code;
    private String description;
    private double minOrderValue;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private boolean deleted;
    private double percentDecrease;

    public Discount(int iD, String code, String description, double minOrderValue, LocalDateTime startDate, LocalDateTime endDate, boolean deleted, double percentDecrease) {
        this.iD = iD;
        this.code = code;
        this.description = description;
        this.minOrderValue = minOrderValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.deleted = deleted;
        this.percentDecrease = percentDecrease;
    }

    public Discount() {
    }

    public double getPercentDecrease() {
        return percentDecrease;
    }

    public void setPercentDecrease(double percentDecrease) {
        this.percentDecrease = percentDecrease;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public int getiD() {
        return iD;
    }

    public void setiD(int iD) {
        this.iD = iD;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "Discount{" +
                "iD=" + iD +
                ", code='" + code + '\'' +
                ", description='" + description + '\'' +
                ", minOrderValue=" + minOrderValue +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", deleted=" + deleted +
                '}';
    }
}
