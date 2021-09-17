using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using System.Text;
//using System.Web.SessionState;

/// <summary>
/// Summary description for DB
/// </summary>
public class Comb
{
    public static string CNs(string LIs_And_Chars)
    {
        string outPut = "", NR;
        string[] splt = LIs_And_Chars.Split('|');

        string a_side = splt[0];
        string b_side = splt[1];


        int[] a = new int[a_side.Split(',').Length];

        string[] b = b_side.Split(',');

        for (int u = 0; u < a_side.Split(',').Length; u++)
        {
            a[u] = Convert.ToInt32(a_side.Split(',')[u]);
        }

        string[] res = GenerateCombinations(b, a);
        for (int k = 0; k < res.Length; k++)
        {
           NR = (res[k]);
           outPut +=reverse(NR)+"|";
        }

        if (outPut.Contains("|"))
        {
            outPut = outPut.Remove(outPut.LastIndexOf("|"));
        }
        return outPut;
    }



  static  string[] GenerateCombinations(string[] Array1, int[] Array2)
    {
        if (Array1 == null) throw new ArgumentNullException("Array1");
        if (Array2 == null) throw new ArgumentNullException("Array2");
        if (Array1.Length != Array2.Length)
            throw new ArgumentException("Must be the same size as Array1.", "Array2");

        if (Array1.Length == 0)
            return new string[0];

        int outputSize = 1;
        var current = new int[Array1.Length];
        for (int i = 0; i < current.Length; ++i)
        {
            if (Array2[i] < 1)
                throw new ArgumentException("Contains invalid values.", "Array2");
            if (Array1[i] == null)
                throw new ArgumentException("Contains null values.", "Array1");
            outputSize *= Array2[i];
            current[i] = 1;
        }

        var result = new string[outputSize];
        for (int i = 0; i < outputSize; ++i)
        {
            var sb = new StringBuilder();
            for (int j = 0; j < current.Length; ++j)
            {
                sb.Append(Array1[j]);
                sb.Append(current[j].ToString());
                if (j != current.Length - 1)
                    sb.Append(' ');
            }
            result[i] = sb.ToString();
            int incrementIndex = current.Length - 1;
            while (incrementIndex >= 0 && current[incrementIndex] == Array2[incrementIndex])
            {
                current[incrementIndex] = 1;
                --incrementIndex;
            }
            if (incrementIndex >= 0)
                ++current[incrementIndex];
        }
        return result;
    }



   static string reverse(string input)
    {
        string StrPart = "", ReturnVal = "", pt1 = "", pt2 = ""; ; int IntPart = 0;
        string Temp = string.Empty;

        string[] inpuSplt = input.Split(' ');

        for (int p = 0; p < inpuSplt.Length; p++)
        {
            input = inpuSplt[p];

            for (int i = 0; i < input.Length; i++)
            {
                if (Char.IsDigit(input[i]))
                {
                    Temp += input[i];
                }
                else
                {
                    StrPart += input[i];
                }
            }


            if (Temp.Length > 0)
                IntPart = int.Parse(Temp);


            if (StrPart == "a") { pt1 += "1"; }
            else if (StrPart == "b") { pt1 += "2"; }
            else if (StrPart == "c") { pt1 += "3"; }
            else if (StrPart == "d") { pt1 += "4"; }
            else if (StrPart == "e") { pt1 += "5"; }
            else if (StrPart == "f") { pt1 += "6"; }
            else if (StrPart == "g") { pt1 += "7"; }
            else if (StrPart == "h") { pt1 += "8"; }
            else if (StrPart == "i") { pt1 += "9"; }
            else if (StrPart == "j") { pt1 += "10"; }
            else if (StrPart == "k") { pt1 += "11"; }
            else if (StrPart == "l") { pt1 += "12"; }
            else if (StrPart == "m") { pt1 += "13"; }
            else if (StrPart == "n") { pt1 += "14"; }
            else if (StrPart == "o") { pt1 += "15"; }
            else if (StrPart == "p") { pt1 += "16"; }
            else if (StrPart == "q") { pt1 += "17"; }
            else if (StrPart == "r") { pt1 += "18"; }


            else if (StrPart == "s") { pt1 += "19"; }
            else if (StrPart == "t") { pt1 += "20"; }
            else if (StrPart == "u") { pt1 += "21"; }
            else if (StrPart == "v") { pt1 += "22"; }
            else if (StrPart == "w") { pt1 += "23"; }
            else if (StrPart == "x") { pt1 += "24"; }
            else if (StrPart == "y") { pt1 += "25"; }
            else if (StrPart == "z") { pt1 += "26"; }



            if (IntPart == 1) { pt2 += "a"; }
            else if (IntPart == 2) { pt2 += "b"; }
            else if (IntPart == 3) { pt2 += "c"; }
            else if (IntPart == 4) { pt2 += "d"; }
            else if (IntPart == 5) { pt2 += "e"; }
            else if (IntPart == 6) { pt2 += "f"; }
            else if (IntPart == 7) { pt2 += "g"; }
            else if (IntPart == 8) { pt2 += "h"; }
            else if (IntPart == 9) { pt2 += "i"; }
            else if (IntPart == 10) { pt2 += "j"; }
            else if (IntPart == 11) { pt2 += "k"; }
            else if (IntPart == 12) { pt2 += "l"; }
            else if (IntPart == 13) { pt2 += "m"; }
            else if (IntPart == 14) { pt2 += "n"; }
            else if (IntPart == 15) { pt2 += "o"; }
            else if (IntPart == 16) { pt2 += "p"; }
            else if (IntPart == 17) { pt2 += "q"; }
            else if (IntPart == 18) { pt2 += "r"; }
            else if (IntPart == 19) { pt2 += "s"; }
            else if (IntPart == 20) { pt2 += "t"; }
            else if (IntPart == 21) { pt2 += "u"; }
            else if (IntPart == 22) { pt2 += "v"; }
            else if (IntPart == 23) { pt2 += "w"; }
            else if (IntPart == 24) { pt2 += "x"; }
            else if (IntPart == 25) { pt2 += "y"; }
            else if (IntPart == 26) { pt2 += "z"; }

            ReturnVal += pt1 + pt2 + " ";
            Temp = ""; StrPart = ""; pt1 = ""; pt2 = "";

        }

        return ReturnVal;
    }

   
}