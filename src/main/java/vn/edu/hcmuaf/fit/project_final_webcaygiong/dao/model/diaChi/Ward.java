package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.diaChi;

import java.io.Serializable;

public class Ward implements Serializable {
    private int id;
    private String name;

    // Getter và Setter
    public int getId() {
        return id;
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
}
