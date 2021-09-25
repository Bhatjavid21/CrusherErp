using System;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Configuration;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;

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
        if (ValidateUser(email, user_password))
        {
            FormsAuthentication.RedirectFromLoginPage(email, true);
            FormsAuthenticationTicket tkt;
            string cookiestr;
            HttpCookie ck;
            tkt = new FormsAuthenticationTicket(email, true, 30);
            cookiestr = FormsAuthentication.Encrypt(tkt);
            ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
            ck.Expires = tkt.Expiration;
            ck.Path = FormsAuthentication.FormsCookiePath;
            Response.Cookies.Add(ck);

            Response.Redirect("~/Modules/General/Dashboard.aspx", true);
        }
        else
        {
            ltrmsg.Text = "";
            ltrmsg.Text += "<div class=\"alert alert-dismissible fade show\" role=\"alert\" style=\"background-color:red\">";
            ltrmsg.Text += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span>×</span></button>";
            ltrmsg.Text += " Invalid Email Or Password!";
            ltrmsg.Text += " </div>";

        }
    }
    private bool ValidateUser(string email, string password)
    {
        string username = "";
        string pwd = "";
        SqlDataReader sqlDataReader = DB.Get_temp("select Login,Password from tbl_user where Login='" + email + "' and Password='" + password + "'");

        while (sqlDataReader.Read())
        {
            username = sqlDataReader["Login"] + "";
            pwd = sqlDataReader["Password"] + "";
        }
        sqlDataReader.Close();
        if (username.Equals(email) && pwd.Equals(password))
        {
            return true;
        }
        else
        {
            return false;
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