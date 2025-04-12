package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi;

import java.io.Serializable;

public class Province implements Serializable {
    private int provinceID;
    private String provinceName;

    // Getter và Setter
    public int getProvinceID() {
        return provinceID;
    }

    public void setProvinceID(int provinceID) {
        this.provinceID = provinceID;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }
}