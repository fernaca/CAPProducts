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
        rating      : Decimal(4, 2) @assert.range: [
            1,
            5
        ];
        min         : Integer default 30;
        max         : Integer default 100;
        value       : Integer default 0;
        criticality : Integer;
        //        criticality : Association to Criticality;
        stock       : Association to Stock default 'Pending';
        price       : Decimal(8, 2) @assert.range: [
            0,
            null
        ];
        currency    : String(3);
};

entity Categories : cuid {
    category        : String(40);
    description     : LargeString;
    toSubCategories : Association to many SubCategories
                          on toSubCategories.category = $self;
    toProducts      : Association to many Products
                          on toProducts.category = $self; // Relación bidireccional con Products
};

entity SubCategories : cuid {
    subcategory : String(40);
    description : LargeString;
    category    : Association to Categories;
    toProducts  : Association to many Products
                      on toProducts.subCategory = $self;
};

entity Suppliers : cuid {
    supplier     : String(10);
    supplierName : String(40);
    webAddress   : String;
    toProducts   : Association to many Products
                       on toProducts.supplier = $self;
};

entity Stock : CodeList {
    key code : String enum {
            InStock         = 'In Stock';
            NotInStock      = 'Not In Stock';
            LowAvailability = 'Low Availability';
            Pending         = 'Pending';
        }
};

entity Criticality : CodeList {
    key code : Integer enum {
            Neutral = 0          @title: 'Neutral';
                    Negative = 1 @title: 'Negative';
                    Critical = 2 @title: 'Critical';
                    Positive = 3 @title: 'Positive';
                    NewItem = 5 @title: 'New Item'
        }
};
