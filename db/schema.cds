namespace FDCProducts;

using {
    cuid,
    managed,
    sap.common.CodeList,
} from '@sap/cds/common';

entity Products : cuid {
    key product     : String(10);
        productName : String(40);
        description : LargeString;
        category    : Association to Categories;
        subCategory : Association to SubCategories;
        supplier    : Association to Suppliers;
        rating      : Decimal(4, 2);
        min         : Integer default 30;
        max         : Integer default 100;
        value       : Integer default 0;
        criticality : Integer;
        stock       : Association to Stock default 'Pending';
        price       : Decimal(8, 2);
        currency    : String(3);
};

entity Categories : cuid {
    category        : String(40);
    description     : LargeString;
    toSubCategories : Association to many SubCategories
                          on toSubCategories.category = $self;
};

entity SubCategories : cuid {
    subcategory : String(40);
    description : LargeString;
    category    : Association to Categories;
};

entity Suppliers: cuid{
    supplier: String(10);
    suplierName: String(40);
    webAddress: String;
};

entity Stock: CodeList {
    key code : String enum {
        InStock = 'In Stock';
        NotInStock = 'Not In Stock';
        LowAvailability = 'Low Availability';
        Pending = 'Pending';
    }
}
