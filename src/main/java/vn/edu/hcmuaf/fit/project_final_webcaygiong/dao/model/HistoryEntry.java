package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

import java.sql.Timestamp;

public class HistoryEntry {
    private int id;
    private String action_type;
    private int product_id;
    private String name;
    private Timestamp time_action;
    private String old_data;
    private String user_action;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getActionType() { return action_type; }
    public void setActionType(String action_type) { this.action_type = action_type; }

    public int getProductID() { return product_id; }
    public void setProductID(int product_id) { this.product_id = product_id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Timestamp getTimeAction() { return time_action; }
    public void setTimeAction(Timestamp time_action) { this.time_action = time_action; }

    public String getOldData() { return old_data; }
    public void setOldData(String old_data) { this.old_data = old_data; }

    public String getUserAction() { return user_action; }
    public void setUserAction(String user_action) { this.user_action = user_action; }
}
