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
            
            //it works

            sb.Append("<table cellpading=8 cellspacing=8 border=1><tr><td style='font-size:12px;width:12%;	color:red;	font-family:Calibri; border:1px;'>Bismillah</td><td style='font-size:12px;	color:red;	width:20%; font-family:Calibri; border:1px;'>Bismillah</td><td width:30%;><img src='" + Server.MapPath("a.jpg") + "'/></td></tr></table>"               
                );


            StringReader sr = new StringReader(sb.ToString());

            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);

            PdfWriter.GetInstance(pdfDoc, new FileStream(Server.MapPath("GiveMeName.pdf"), FileMode.Create, System.IO.FileAccess.Write));
            

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            using (MemoryStream memoryStream = new MemoryStream())
            {
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);

                //XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, new StringReader(HTML));

                pdfDoc.Open();

                htmlparser.Parse(sr);
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
    