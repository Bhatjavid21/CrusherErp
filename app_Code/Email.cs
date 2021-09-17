using System;
using System.Net;
using System.Net.Mail;

/// <summary>
/// Summary description for DB
/// </summary>
public class Email
{
    public static string Send_Mail(string To, string CC_To, string Subject,  string Body, string Attachment_File_Name)
    {
        string returnMsg="";


        const string fromPassword = "Admin@123";
            string subject = Subject;
            string body = Body;

            var fromAddress = new MailAddress("alestagamah00@gmail.com", "Alestagamah");

            var first = ""; var Tos = To;

            if (To.Contains(","))
            { first = To.Split(',')[0]; }
            else
            { first = To; }


            var toAddress = new MailAddress(first);


            var message = new MailMessage(fromAddress, toAddress);

            if (To.Contains(","))
            {
                string[] splt = To.Split(',');

                if (To.Split(',').Length > 1)
                {

                    for (int a = 1; a < splt.Length; a++)
                    {
                        message.To.Add(splt[a]);
                    }
                }
            }

            if (CC_To != "")
            {
                if (CC_To.Contains(","))
                {
                    for (int a = 0; a < CC_To.Split(',').Length; a++)
                    {
                        message.CC.Add(CC_To.Split(',')[a]);
                    }
                }
                else
                { message.CC.Add(CC_To); }
            }


            if (Attachment_File_Name != "")
            {
                string attImg = System.Web.HttpContext.Current.Server.MapPath("~") + "\\Modules\\Emails\\Supplier_RFQ\\";

                if (Attachment_File_Name.Contains(","))
                {
                    for (int a = 0; a < Attachment_File_Name.Split(',').Length; a++)
                    {
                        message.Attachments.Add(new Attachment(attImg + Attachment_File_Name.Split(',')[a]));
                    }
                }
                else
                { message.Attachments.Add(new Attachment(attImg + Attachment_File_Name)); }
            }

            //message.Attachments.Add(new Attachment(attImg));


            message.Subject = subject;
            message.Body = body;
            message.IsBodyHtml = true;

            
            var smtp = new SmtpClient
            {

                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };

            //using (var message = new MailMessage(fromAddress, toAddress)
            //{
            //    Subject = subject,
            //    Body = body
            //})


            //System.Net.Mail.Attachment attachment;
            //attachment = new System.Net.Mail.Attachment("c:/textfile.txt");
            //message.Attachments.Add(attachment);

            
            smtp.Send(message);
            returnMsg="OK";
        
        return returnMsg;
    }

   
}   