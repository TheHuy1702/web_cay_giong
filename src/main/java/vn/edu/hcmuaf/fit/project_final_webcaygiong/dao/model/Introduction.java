package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class Introduction implements Serializable {
    private int introID;
    private String sectionName;
    private String content;

    public Introduction() {
    }

    public Introduction(int introID, String sectionName, String content) {
        this.introID = introID;
        this.sectionName = sectionName;
        this.content = content;
    }

    public int getIntroID() {
        return introID;
    }

    public void setIntroID(int introID) {
        this.introID = introID;
    }

    public String getSectionName() {
        return sectionName;
    }

    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return introID +
                ", " + sectionName +
                "\n" + content;
    }
}
