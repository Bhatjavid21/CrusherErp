using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
//using iTextSharp.testutils;
using System.Text;
using System.Resources;


public partial class pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        GeneratePDF();
       
    }


    #region Generate PDF
    void GeneratePDF()
    {
        var fnt = " style=\"color:green;font-weight:bold\" ";
        var nft = " style=\"color:blue;font-weight:bold\" ";
        try
        {

            StringBuilder sb = new StringBuilder();
            #region html
            sb.Append("");
            sb.Append("<header class='clearfix'>");
            sb.Append("<h1>INVOICE</h1>");
            sb.Append("<div id='company' class='clearfix'><img src='"+Server.MapPath("~")+"/assets/images/logo/logo-2.jpg'/>");
            sb.Append("<div>Company Name</div>");
            sb.Append("<div>455 John Tower,<br /> AZ 85004, US</div>");
            sb.Append("<div>(602) 519-0450</div>");
            sb.Append("<div><a href='mailto:company@example.com'>company@example.com</a></div>");
            sb.Append("</div>");
            sb.Append("<div id='project'>");
            sb.Append("<div><span>PROJECT</span> Website development</div>");
            sb.Append("<div><span>CLIENT</span> John Doe</div>");
            sb.Append("<div><span>ADDRESS</span> 796 Silver Harbour, TX 79273, US</div>");
            sb.Append("<div><span>EMAIL</span> <a href='mailto:john@example.com'>john@example.com</a></div>");
            sb.Append("<div><span>DATE</span> April 13, 2016</div>");
            sb.Append("<div><span>DUE DATE</span> May 13, 2016</div>");
            sb.Append("</div>");
            sb.Append("</header>");
            sb.Append("<main>");
            sb.Append("<table style='border:1px solid green;'>");
            sb.Append("<thead>");
            sb.Append("<tr>");
            sb.Append("<th class='service'>SERVICE</th>");
            sb.Append("<th class='desc'>DESCRIPTION</th>");
            sb.Append("<th>PRICE</th>");
            sb.Append("<th>QTY</th>");
            sb.Append("<th>TOTAL</th>");
            sb.Append("</tr>");
            sb.Append("</thead>");
            sb.Append("<tbody>");
            sb.Append("<tr>");
            sb.Append("<td class='service'>Design</td>");
            sb.Append("<td class='desc'>Creating a recognizable design solution based on the company's existing visual identity</td>");
            sb.Append("<td class='unit'>$400.00</td>");
            sb.Append("<td class='qty'>2</td>");
            sb.Append("<td class='total'>$800.00</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td colspan='4' style='color:red;'>SUBTOTAL</td>");
            sb.Append("<td class='total' style='border:1px solid red;'>$800.00</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td colspan='4'>TAX 25%</td>");
            sb.Append("<td class='total'>$200.00</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td colspan='4'  " + fnt + ">GRAND TOTAL</td>");
            sb.Append("<td class='grand total'>$1,000.00</td>");
            sb.Append("</tr>");
            sb.Append("</tbody>");
            sb.Append("</table>");
            sb.Append("<div id='notices'>");
            sb.Append("<div>NOTICE:</div>");
            sb.Append("<div class='notice'>A finance charge of 1.5% will be made on unpaid balances after 30 days.</div>");
            sb.Append("</div>");
            sb.Append("</main>");
            sb.Append("<footer>");
            sb.Append("Invoice was created on a computer and is valid without the signature and seal.");
            sb.Append("</footer>");

            #endregion
            //it works

            sb.Append("<table cellpading=8 cellspacing=8 border=1><tr><td width='10%' style='font-size:25px; 	color:red;	font-family:Calibri; border:1px;'>Bismillah</td><td  width='20%' bgcolor=blue style='font-size:12px; color:blue;  	font-family:arial; border:1px;'>Bismillah</td><td width='70%'><img src='" + Server.MapPath("a.jpg") + "'/></td></tr></table>"               
                );


            StringReader sr = new StringReader(sb.ToString());

            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);

            PdfWriter.GetInstance(pdfDoc, new FileStream(Server.MapPath("GiveMeName.pdf"), FileMode.Create, System.IO.FileAccess.Write));

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            using (MemoryStream memoryStream = new MemoryStream())
            {
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                pdfDoc.Open();

                htmlparser.Parse(sr);

                //XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, new StringReader(HTML)); //this works for css


                pdfDoc.Close();

                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();

                // Clears all content output from the buffer stream                 
                Response.Clear();
                // Gets or sets the HTTP MIME type of the output stream.
                Response.ContentType = "application/pdf";
                // Adds an HTTP header to the output stream
                Response.AddHeader("Content-Disposition", "attachment; filename=GiveMeName.pdf");

                //Gets or sets a value indicating whether to buffer output and send it after
                // the complete response is finished processing.
                Response.Buffer = true;
                // Sets the Cache-Control header to one of the values of System.Web.HttpCacheability.

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                // Writes a string of binary characters to the HTTP output stream. it write the generated bytes .

                Response.BinaryWrite(bytes);
                // Sends all currently buffered output to the client, stops execution of the
                // page, and raises the System.Web.HttpApplication.EndRequest event.

                Response.End();
                // Closes the socket connection to a client. it is a necessary step as you must close the response after doing work.its best approach.
                Response.Close();


                // now from d:\\my.pdf, u can mail the file as attachment
            }

        }
        catch (Exception ex) { Response.Write(ex.Message); }

    }
    #endregion
    

    #region PDF with Css Class - PDF Material - May be of some use
    //    public void GeneratePdf(String file)
//    {
//        Document document = new Document();
//        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(file));
//        document.open();
//        CSSResolver cssResolver = new StyleAttrCSSResolver();
//        CssFile cssFile = XMLWorkerHelper.getCSS(new ByteArrayInputStream(CSS_STYLE.getBytes()));
//        cssResolver.addCss(cssFile);
//        // HTML  
//        HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
//        htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
//        // Pipelines  
//        PdfWriterPipeline pdfFile = new PdfWriterPipeline(document, writer);
//        HtmlPipeline html = new HtmlPipeline(htmlContext, pdfFile);
//        CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
//        // XML Worker  
//        XMLWorker worker = new XMLWorker(css, true);
//        XMLParser p = new XMLParser(worker);
//        p.parse(new ByteArrayInputStream(HTML.getBytes()));
//        document.close();
//    }

//    public static string CSS_STYLE = "th { background-color: #C0C0C0; font-size: 16pt; }"
//+ "td { font-size: 10pt; }";
//    public static string HTML = "<html><body><table class='table-bordered'>"
//    + "<thead><tr><th>Customer Name</th><th>Customer's Address</th> </tr></thead>"
//    + "<tbody><tr><td> Shankar </td><td> Chennai </td></tr>"
//    + "<tr><td> Krishnaa </td><td> Trichy </td></tr></tbody>"
//    + "</table></body></html>";  

    
    protected void Button1_Click(object sender, EventArgs e)
    {
        // GeneratePDF();
        abc();
    }
    
    void abc()
    {
        string path = Server.MapPath("junk");

        string filename = path + "/Doc1.pdf";



        //Create new PDF document

        Document document = new Document(PageSize.A4, 20f, 20f, 20f, 20f);

        try
        {

            PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create));



            PdfPTable table = new PdfPTable(3);

            table.TotalWidth = 400f;

            //fix the absolute width of the table

            table.LockedWidth = true;



            //relative col widths in proportions - 1/3 and 2/3

            float[] widths = new float[] { 2f, 4f, 6f };

            table.SetWidths(widths);

            table.HorizontalAlignment = 0;

            //leave a gap before and after the table

            table.SpacingBefore = 20f;

            table.SpacingAfter = 30f;

            


            PdfPCell cell = new PdfPCell(new Phrase("Header spanning 3 columns"));

            cell.Colspan = 3;

            cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right

            table.AddCell(cell);

            table.AddCell("Col 1 Row ");

            table.AddCell("Col 2 Row 1");

            table.AddCell("Col 3 Row 1");

            table.AddCell("Col 1 Row 2");

            table.AddCell("Col 2 Row 2");

            table.AddCell("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");

           BaseColor   bs = new  BaseColor(226, 218, 241);
            cell.BorderColorBottom = bs;

           // cell.BackgroundColor = "";

            document.Open();

            document.Add(table);

        }

        catch (Exception ex)
        {

        }

        finally
        {

            document.Close();

            ShowPdf(filename);

        }

    }
    

    public void ShowPdf(string filename)
    {

        //Clears all content output from Buffer Stream

        Response.ClearContent();

        //Clears all headers from Buffer Stream

        Response.ClearHeaders();

        //Adds an HTTP header to the output stream

        Response.AddHeader("Content-Disposition", "inline;filename=" + filename);

        //Gets or Sets the HTTP MIME type of the output stream

        Response.ContentType = "application/pdf";

        //Writes the content of the specified file directory to an HTTP response output stream as a file block

        Response.WriteFile(filename);

        //sends all currently buffered output to the client

        Response.Flush();

        //Clears all content output from Buffer Stream

        Response.Clear();

    }
    #endregion


   

}
    