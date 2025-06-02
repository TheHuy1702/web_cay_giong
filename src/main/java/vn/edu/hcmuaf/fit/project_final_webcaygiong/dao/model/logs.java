package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.util.Date;

public class logs {
    private int id;
    private int userID;
    private String username;
    private String action;
    private String action_type;
    private String level_log;
    private String old_data;
    private String new_data;
    private String source_page;
    private String resource;
    private String ip_address;
    private Date time_action;

    public logs() {
    }

    public logs(int id, int userID, String username, String action, String action_type, String level_log, String old_data, String new_data, String source_page, String resource, String ip_address, Date time_action) {
        this.id = id;
        this.userID = userID;
        this.username = username;
        this.action = action;
        this.action_type = action_type;
        this.level_log = level_log;
        this.old_data = old_data;
        this.new_data = new_data;
        this.source_page = source_page;
        this.resource = resource;
        this.ip_address = ip_address;
        this.time_action = time_action;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getAction_type() {
        return action_type;
    }

    public void setAction_type(String action_type) {
        this.action_type = action_type;
    }

    public String getLevel_log() {
        return level_log;
    }

    public void setLevel_log(String level_log) {
        this.level_log = level_log;
    }

    public String getOld_data() {
        return old_data;
    }

    public void setOld_data(String old_data) {
        this.old_data = old_data;
    }

    public String getNew_data() {
        return new_data;
    }

    public void setNew_data(String new_data) {
        this.new_data = new_data;
    }

    public String getSource_page() {
        return source_page;
    }

    public void setSource_page(String source_page) {
        this.source_page = source_page;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getIp_address() {
        return ip_address;
    }

    public void setIp_address(String ip_address) {
        this.ip_address = ip_address;
    }

    public Date getTime_action() {
        return time_action;
    }

    public void setTime_action(Date time_action) {
        this.time_action = time_action;
    }
}
