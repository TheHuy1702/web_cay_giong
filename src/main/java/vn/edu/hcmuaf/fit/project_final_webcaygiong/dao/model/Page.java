package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.io.Serializable;

public class Page implements Serializable {
    private int pageID;
    private String name;
    private String url;

    public Page(int pageID, String name, String url) {
        this.pageID = pageID;
        this.name = name;
        this.url = url;
    }

    public Page() {
    }

    public int getPageID() {
        return pageID;
    }

    public void setPageID(int pageID) {
        this.pageID = pageID;
    }

    public String getname() {
        return name;
    }

    public void setname(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageID=" + pageID +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                '}';
    }
}
