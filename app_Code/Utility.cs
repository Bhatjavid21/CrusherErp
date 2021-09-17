using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Utility
/// </summary>
public class Utility
{
    /// <summary>
    /// Method is used to return the Picture Extension
    /// </summary>
    /// <param name="strPictureName">Picture Name with File Extension</param>
    /// <returns>Extension of the supplied file</returns>
    public static string GetPictureExtension(string strFileName)
    {
        if (strFileName.ToUpper().EndsWith(".JPG"))
            return ".JPG";
        else if (strFileName.ToUpper().EndsWith(".JPEG"))
            return ".JPEG";
        else if (strFileName.ToUpper().EndsWith(".GIF"))
            return ".GIF";
        else if (strFileName.ToUpper().EndsWith(".BMP"))
            return ".BMP";
        else if (strFileName.ToUpper().EndsWith(".PNG"))
            return ".PNG";
        else if (strFileName.ToUpper().EndsWith(".DOC"))
            return ".DOC";
        else if (strFileName.ToUpper().EndsWith(".DOCX"))
            return ".DOCX";
        else if (strFileName.ToUpper().EndsWith(".TXT"))
            return ".TXT";
        else if (strFileName.ToUpper().EndsWith(".XLS"))
            return ".XLS";
        else if (strFileName.ToUpper().EndsWith(".XLSX"))
            return ".XLSX";
        else if (strFileName.ToUpper().EndsWith(".MSG"))
            return ".MSG";
        else if (strFileName.ToUpper().EndsWith(".CSV"))
            return ".CSV";
        else if (strFileName.ToUpper().EndsWith(".PDF"))
            return ".PDF";
        else
            return "";
    }

    public static string GetImageName(string fileName)
    {
        string strImageName = fileName.ToString();

        //Trim Start and End Spaces.
        strImageName = strImageName.Trim();

        //Trim "-" Hyphen
        strImageName = strImageName.Trim('-');

        strImageName = strImageName.ToLower();
        char[] chars = @"$%#@!*?;:~`+=()[]{}|\'<>,/^&".ToCharArray();
        strImageName = strImageName.Replace("AM", "");
        strImageName = strImageName.Replace("PM", "");
        strImageName = strImageName.Replace("am", "");
        strImageName = strImageName.Replace("pm", "");

        //Replace Special-Characters
        for (int i = 0; i < chars.Length; i++)
        {
            string strChar = chars.GetValue(i).ToString();
            if (strImageName.Contains(strChar))
            {
                strImageName = strImageName.Replace(strChar, string.Empty);
            }
        }
        //Replace all spaces with one "-" hyphen
        strImageName = strImageName.Replace(" ", "");

        //Run the code again...
        //Trim Start and End Spaces.
        strImageName = strImageName.Trim();

        //Trim "-" Hyphen
        strImageName = strImageName.Trim('-');
        return strImageName;
    }

    /// <summary>
    /// Method is used to return File Extension
    /// </summary>
    /// <param name="strFileName">File Name with Extension</param>
    /// <returns>Extension of the supplied file</returns>
    public static string GetDocExtension(string strFileName)
    {
        if (strFileName.ToUpper().EndsWith(".DOC"))
            return ".DOC";

        else if (strFileName.ToUpper().EndsWith(".DOCX"))
            return ".DOCX";

        else if (strFileName.ToUpper().EndsWith(".TXT"))
            return ".TXT";

        else if (strFileName.ToUpper().EndsWith(".PDF"))
            return ".PDF";
        else
            return "";
    }

    public Utility()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}