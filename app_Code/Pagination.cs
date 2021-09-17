public class Pagination
{
    public static string PG(int TotalRecords, int Clicked_Page_No, int No_Of_Records_To_Show)
    {

        int Total_Page = 2, lft = 1, to = 5; string pagging = "", Prev="",Nex="", dots="",TotalRec="", Next="", Previous="", FirstJump="";

        string Total_Records = (decimal.Parse(TotalRecords.ToString()) / No_Of_Records_To_Show).ToString();
        if (Total_Records.Contains("."))
        {
            Total_Records = Total_Records.Remove(Total_Records.LastIndexOf("."));
            //TotalRecords=+1)
            Total_Page = (int.Parse(Total_Records) + 1);
        }
        else
        {
            Total_Page = TotalRecords / No_Of_Records_To_Show;
        }

        

        if (Clicked_Page_No < 3) // 1 to 3 (any number), clicked is not considered here
        {
            lft = 1; 
            if (Total_Page > 5) { to = 5; } else { to = Total_Page; }
        }
        else if (Clicked_Page_No > 2)
        {
            lft = Clicked_Page_No - 2;

            if (Clicked_Page_No <= Total_Page - 2)
            {
                lft = Clicked_Page_No - 2;
            }
            else
            {
                lft = Total_Page - 4; if (lft < 1) { lft = 1; to = Total_Page; }
            }

        }
        
        

        if (Total_Page > 5) { to = to-1; }

        for (int i = 0; i < to; i++)
        {
            if (Clicked_Page_No == (lft + i))
            {
                pagging += "<li class='paginate_button page-item active'><a href='#' aria-controls='#' "
                    +" onclick=pageNo(" + (lft + i) + ") data-dt-idx='" + (i + 1) + "' tabindex='0' class='page-link'>"
                    +"" + (lft + i) + "</a></li>";
            }
            else
            {
                pagging += "<li class='paginate_button page-item'><a href='#' aria-controls='#' "
                    + " onclick=pageNo(" + (lft + i) + ") data-dt-idx='" + (i + 1) + "' tabindex='0' class='page-link'>"
                    + (lft + i) + "</a></li>";
            }

            if (Clicked_Page_No > 3)
            { 
            FirstJump="<li class='paginate_button page-item'><a href='#' aria-controls='#' "
                    + " onclick=pageNo('1') data-dt-idx='1' tabindex='0' class='page-link'>1</a>&nbsp; ... &nbsp;</li>";
            }
            else if (Clicked_Page_No < 4)
            {
                FirstJump = "";
            }
        }

        if (Total_Page > 5)
        {
            //string Total_Records = (decimal.Parse(TotalRecords.ToString()) / 20).ToString(); 
            //if (Total_Records.Contains("."))
            //{ 
            //    Total_Records = Total_Records.Remove(Total_Records.LastIndexOf(".")); 
            //    //TotalRecords=+1)
            //    TotalRecords = (int.Parse(Total_Records) + 1);
            //}
            //if((Clicked_Page_No - 1) >= 1)
            
            if ((Clicked_Page_No) < Total_Page) { Next = (Clicked_Page_No + 1).ToString(); } else { Next = Total_Page.ToString(); }

            if ((Clicked_Page_No - 1) > 0) { Previous = (Clicked_Page_No - 1).ToString(); } else { Previous = "1"; }

            Prev = "<li class='paginate_button page-item previous' id='#_previous'><a href='#' onclick=pageNo(" + Previous + ")  "
                +"'aria-controls='#' data-dt-idx='0' tabindex='0' class='page-link'>Previous</a></li>";
            if (Total_Page == Clicked_Page_No)
            {

                TotalRec = "<li class='paginate_button page-item active'><a href='#' aria-controls='#' data-dt-idx='7' "
                   + " onclick=pageNo(" + Total_Page + ") tabindex='0' class='page-link'>" + (Total_Page) + "</a></li>";
            }
            else
            {
                TotalRec = "<li class='paginate_button page-item'><a href='#' aria-controls='#' data-dt-idx='7' "
                       + " onclick=pageNo(" + Total_Page + ") tabindex='0' class='page-link'>" + (Total_Page) + "</a></li>";
            }

            Nex = "<li class='paginate_button page-item next' id='#_next'><a href='#' aria-controls='#' onclick=pageNo(" + Next+ ")" 
                +" data-dt-idx='8' tabindex='0' class='page-link'>Next</a></li>";

            dots = "<li class='paginate_button page-item disabled' id='#_ellipsis'><a href='#' aria-controls='#' data-dt-idx='6'"
                + " tabindex='0' class='page-link'>…</a></li>";
        }


        return Prev + FirstJump + pagging + dots + TotalRec + Nex;
    }
}