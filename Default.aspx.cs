using System;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Configuration;
using System.Security.Cryptography;
using System.Web;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["session_ids"] = null;
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        StringBuilder output = new StringBuilder();
        string email = Request.Form["txt_user_email"];
        string user_password = Request.Form["txt_user_password"];

        string pword = Encrypt(user_password);
        try
        {
            //if (email == "Admin@CrusherErp.com" && user_password == "Admin")
            //{
            //    Response.Redirect("Modules/General/dashboard.aspx");
            //}
            //else
            //{
            //    ltrmsg.Text = "";
            //    ltrmsg.Text += "<div class=\"alert alert-dismissible fade show\" role=\"alert\" style=\"background-color:red\">";
            //    ltrmsg.Text += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span>×</span></button>";
            //    ltrmsg.Text += " Invalid Email Or Password!";
            //    ltrmsg.Text += " </div>";

            //    // output.Append("Invalid Username or Password!");
            //}

            SqlDataReader dtb = DB.Get_temp("Select A.Employee_Id, A.Is_System_Generated, B.Branch_Id, B.Photo, replace(B.Employee_Name,',',' ') as Employee_Name, B.Email from tbl_User_Details as A " +
               "  inner join tbl_Employee as B on B.Employee_Id = A.Employee_Id " +
               "  Where  A.Status='true' AND A.IsDeleted='false' AND Email_Id='" + email + "' AND User_Password='" + pword + "'");

            //SqlDataReader dtb = DB.Get_temp("Select A.User_Id, A.Employee_Id, A.Is_System_Generated, B.Branch_Id, C.Division_id from tbl_User_Details as A " +
            // "  inner join tbl_Employee as B on B.Employee_Id = A.Employee_Id " +
            // "  inner join tbl_Employee_Division_Mapping as C on C.Employee_Id = A.Employee_Id " +
            // "  Where C.Is_Default_Division='true' AND A.Status='true' AND Email_Id='" + email + "' AND User_Password='" + pword + "'");

            int chkb = 0;
            string System_Generated_val = "True";
            int branchId = 0;
            string divisionId = "0";
            string empOtherDetails = "";
            string multi_session_ids = "";

            while (dtb.Read())
            {
                chkb = Convert.ToInt32(dtb["Employee_Id"]);
                System_Generated_val = dtb["Is_System_Generated"].ToString();
                branchId = Convert.ToInt32(dtb["Branch_Id"]);
                empOtherDetails = dtb["Photo"].ToString() + "|" + dtb["Employee_Name"].ToString() + "|" + dtb["Email"].ToString();

                SqlDataReader divId = DB.Get_temp("Select Division_id from tbl_Employee_Division_Mapping Where Is_Default_Division='True'" +
                  " AND Employee_Id=" + Convert.ToInt32(dtb["Employee_Id"]) + " and Is_Mapped='True'");
                if (divId.HasRows)
                {
                    while (divId.Read())
                    {
                        divisionId = divId["Division_id"].ToString();
                    }
                }
                else
                {
                    divisionId = "No Division";
                }
            }
            if (chkb != 0)
            {
                // multi_session_ids = chkb + "," + branchId + "," + divisionId + ",dd/MM/yyyy";

                multi_session_ids = chkb + "," + branchId + "," + divisionId + ",103," + empOtherDetails;

                Session["session_ids"] = multi_session_ids;

                if (System_Generated_val == "False")
                {
                    Response.Redirect("Modules/General/dashboard.aspx");
                }
                else
                {
                    txt_EmpID.Value = chkb.ToString();
                    hdf_sysgen.Value = "1";
                }
            }
            else
            {
                ltrmsg.Text = "";
                ltrmsg.Text += "<div class=\"alert alert-dismissible fade show\" role=\"alert\" style=\"background-color:red\">";
                ltrmsg.Text += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span>×</span></button>";
                ltrmsg.Text += " Invalid Email Or Password!";
                ltrmsg.Text += " </div>";

                // output.Append("Invalid Username or Password!");
            }
            dtb.Close();
        }
        catch (Exception x)
        {

        }
    }

    public static string Encrypt(string plainText)
    {

        string passPhrase = ConfigurationManager.AppSettings.Get("passPhrase");
        string saltValue = ConfigurationManager.AppSettings.Get("saltValue");                                           // can be any string
        string hashAlgorithm = ConfigurationManager.AppSettings.Get("hashAlgorithm");                                   // can be "MD5"
        int passwordIterations = Convert.ToInt32(ConfigurationManager.AppSettings.Get("passwordIterations").ToString());// can be any number
        string initVector = ConfigurationManager.AppSettings.Get("initVector");                                         // must be 16 bytes
        int keySize = Convert.ToInt32(ConfigurationManager.AppSettings.Get("keySize"));                                 // can be 192 or 128

        // Convert strings into byte arrays.
        // Let us assume that strings only contain ASCII codes.
        // If strings include Unicode characters, use Unicode, UTF7, or UTF8 
        // encoding.
        byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
        byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

        // Convert our plaintext into a byte array.
        // Let us assume that plaintext contains UTF8-encoded characters.
        byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

        // First, we must create a password, from which the key will be derived.
        // This password will be generated from the specified passphrase and 
        // salt value. The password will be created using the specified hash 
        // algorithm. Password creation can be done in several iterations.
        PasswordDeriveBytes password = new PasswordDeriveBytes(
                                                        passPhrase,
                                                        saltValueBytes,
                                                        hashAlgorithm,
                                                        passwordIterations);

        // Use the password to generate pseudo-random bytes for the encryption
        // key. Specify the size of the key in bytes (instead of bits).
        byte[] keyBytes = password.GetBytes(keySize / 8);

        // Create uninitialized Rijndael encryption object.
        RijndaelManaged symmetricKey = new RijndaelManaged();

        // It is reasonable to set encryption mode to Cipher Block Chaining
        // (CBC). Use default options for other symmetric key parameters.
        symmetricKey.Mode = CipherMode.CBC;

        // Generate encryptor from the existing key bytes and initialization 
        // vector. Key size will be defined based on the number of the key 
        // bytes.
        ICryptoTransform encryptor = symmetricKey.CreateEncryptor(
                                                         keyBytes,
                                                         initVectorBytes);

        // Define memory stream which will be used to hold encrypted data.
        MemoryStream memoryStream = new MemoryStream();

        // Define cryptographic stream (always use Write mode for encryption).
        CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                     encryptor,
                                                     CryptoStreamMode.Write);
        // Start encrypting.
        cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);

        // Finish encrypting.
        cryptoStream.FlushFinalBlock();

        // Convert our encrypted data from a memory stream into a byte array.
        byte[] cipherTextBytes = memoryStream.ToArray();

        // Close both streams.
        memoryStream.Close();
        cryptoStream.Close();

        // Convert encrypted data into a base64-encoded string.
        string cipherText = Convert.ToBase64String(cipherTextBytes);

        // Return encrypted string.
        return cipherText;
    }
}