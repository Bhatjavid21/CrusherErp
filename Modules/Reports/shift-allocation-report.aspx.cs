using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Modules_Report_shift_allocation_report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
    }

    #region WebMethod Get_Shift_Allocation_Report
    [System.Web.Services.WebMethod]
    public static string Get_Shift_Allocation_Report(DateTime selectedYearAndMonth)
    {
        string sql = "", output = "", shiftFrom = "", shiftTo = "", shiftAppTo = "";
        int daysInMonth = 0;

        try
        {
            if (G.HL() == true)
            {
                #region Get_Data
                sql = "select em.Employee_Number, REPLACE(em.Employee_Name,',',' ') as Employee_Name, sc.Shift_Name, sa.Shift_Applicable_From, sa.Shift_Applicable_To from tbl_Shift_Allocation sa inner join tbl_Shift_Configuration sc on sc.Shift_Configuration_Id=sa.Shift_Config_Id inner join tbl_Attendance_Calculation ac on ac.Shift_Allocation_Id=sa.Shift_Allocation_Id and month(ac.Attendance_Date)='" + selectedYearAndMonth.Month + "' and year(ac.Attendance_Date)='" + selectedYearAndMonth.Year + "' inner join tbl_Employee em on em.Employee_Id=ac.Employee_Id group by em.Employee_Number, em.Employee_Name, sc.Shift_Name, sa.Shift_Applicable_From, sa.Shift_Applicable_To order by em.Employee_Name asc";

                SqlDataReader dr = DB.Get_temp(sql);
                #endregion

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        daysInMonth = DateTime.DaysInMonth(selectedYearAndMonth.Year, selectedYearAndMonth.Month);

                        shiftFrom = Convert.ToDateTime(dr["Shift_Applicable_From"].ToString() + "-" + selectedYearAndMonth.Month.ToString() + "-" + selectedYearAndMonth.Year.ToString()).ToString("dd-MMM-yyyy");

                        if (Convert.ToInt32(dr["Shift_Applicable_To"]) <= daysInMonth)
                        {
                            shiftAppTo = dr["Shift_Applicable_To"].ToString();
                        }
                        else
                        {
                            shiftAppTo = daysInMonth.ToString();
                        }

                        shiftTo = Convert.ToDateTime(shiftAppTo + "-" + selectedYearAndMonth.Month.ToString() + "-" + selectedYearAndMonth.Year.ToString()).ToString("dd-MMM-yyyy");

                        output += dr["Employee_Number"].ToString() + "^" + dr["Employee_Name"].ToString() + "^" + dr["Shift_Name"].ToString() + "^" + shiftFrom + "^" + shiftTo + "~";
                    }
                    dr.Dispose();
                    dr.Close();
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x)
        {
            output = "!error!" + x.Message + "";
        }

        return output;
    }
    #endregion
}