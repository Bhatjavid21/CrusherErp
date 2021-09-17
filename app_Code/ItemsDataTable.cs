using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ItemsDataTable
/// </summary>
public class ItemsDataTable
{
    int _item_Id = 0, _branch_Id = 0, _item_type = 0, _sub_catid = 0, _supplier_id=0;
    string _item_code, _new_item_code,
           _brand, _item_manuf, _item_oem_ref, _etype, _capacity, _unit,
           _min_margin_percent, _vat_percent, _item_desc, _long_desc, _arabic_desc, _barcode, _hse_code, _storage_temp,
           _length, _width, _height, _has_expiry, _has_warranty, _status, _Supplier_Name, _Supplier_Short_Name, _account_code;

    public int supplier_id
    {
        get { return _supplier_id; }
        set { _supplier_id = value; }
    }

    public int item_Id
    {
        get { return _item_Id; }
        set { _item_Id = value; }
    }
    public int branch_Id
    {
        get { return _branch_Id; }
        set { _branch_Id = value; }
    }
    public int item_type
    {
        get { return _item_type; }
        set { _item_type = value; }
    }
    public int sub_catid
    {
        get { return _sub_catid; }
        set { _sub_catid = value; }
    }
    public string item_code
    {
        get { return _item_code; }
        set { _item_code = value; }
    }


    public string Supplier_Name
    {
        get { return _Supplier_Name; }
        set { _Supplier_Name = value; }
    }

    public string Supplier_Short_Name
    {
        get { return _Supplier_Short_Name; }
        set { _Supplier_Short_Name = value; }
    }


    public string account_code
    {
        get { return _account_code; }
        set { _account_code = value; }
    }

    public string new_item_code
    {
        get { return _new_item_code; }
        set { _new_item_code = value; }
    }
    public string brand
    {
        get { return _brand; }
        set { _brand = value; }
    }
    public string item_manuf
    {
        get { return _item_manuf; }
        set { _item_manuf = value; }
    }
    public string item_oem_ref
    {
        get { return _item_oem_ref; }
        set { _item_oem_ref = value; }
    }
    public string etype
    {
        get { return _etype; }
        set { _etype = value; }
    }
    public string capacity
    {
        get { return _capacity; }
        set { _capacity = value; }
    }
    public string unit
    {
        get { return _unit; }
        set { _unit = value; }
    }
    public string min_margin_percent
    {
        get { return _min_margin_percent; }
        set { _min_margin_percent = value; }
    }
    public string vat_percent
    {
        get { return _vat_percent; }
        set { _vat_percent = value; }
    }
    public string item_desc
    {
        get { return _item_desc; }
        set { _item_desc = value; }
    }
    public string long_desc
    {
        get { return _long_desc; }
        set { _long_desc = value; }
    }
    public string arabic_desc
    {
        get { return _arabic_desc; }
        set { _arabic_desc = value; }
    }
    public string barcode
    {
        get { return _barcode; }
        set { _barcode = value; }
    }
    public string hse_code
    {
        get { return _hse_code; }
        set { _hse_code = value; }
    }
    public string storage_temp
    {
        get { return _storage_temp; }
        set { _storage_temp = value; }
    }
    public string length
    {
        get { return _length; }
        set { _length = value; }
    }
    public string width
    {
        get { return _width; }
        set { _width = value; }
    }
    public string height
    {
        get { return _height; }
        set { _height = value; }
    }
    public string has_expiry
    {
        get { return _has_expiry; }
        set { _has_expiry = value; }
    }
    public string has_warranty
    {
        get { return _has_warranty; }
        set { _has_warranty = value; }
    }
    public string status
    {
        get { return _status; }
        set { _status = value; }
    }

     
    //public string Price_Type
    //{
    //    get { return _Price_Type; }
    //    set { _Price_Type = value; }
    //}

    // public string Price_Name
    //{
    //    get { return _Price_Name; }
    //    set { _Price_Name = value; }
    //}

    public ItemsDataTable()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}