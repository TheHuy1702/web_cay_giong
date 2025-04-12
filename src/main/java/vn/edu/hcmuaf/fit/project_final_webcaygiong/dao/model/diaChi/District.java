package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi;

import java.io.Serializable;

public class District implements Serializable {
    private int id;
    private String name;
    private int provinceId;

    // Getter và Setter
    public int getId() {
        return id;
    }

    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public District(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public District(int id, String name, int provinceId) {
        this.id = id;
        this.name = name;
        this.provinceId = provinceId;
    }

    @Override
    public String toString() {
        return "District{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", provinceId=" + provinceId +
                '}';
    }
}