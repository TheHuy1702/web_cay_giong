package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model;

public class Week {
    int year;
    int weekOfYear;
    int doanhThu;

    public Week(){

    }
    public Week( int year, int weekOfYear,int doanhThu) {
        this.year = year;
        this.weekOfYear = weekOfYear;
        this.doanhThu = doanhThu;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getWeekOfYear() {
        return weekOfYear;
    }

    public void setWeekOfYear(int weekOfYear) {
        this.weekOfYear = weekOfYear;
    }

    public double getDoanhThu() {
        return doanhThu;
    }

    public void setDoanhThu(int doanhThu) {
        this.doanhThu = doanhThu;
    }

    @Override
    public String toString() {
        return "Week{" +
                "year=" + year +
                ", weekOfYear=" + weekOfYear +
                ", doanhThu=" + doanhThu +
                '}';
    }
}
