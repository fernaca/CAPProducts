using {FDCPrdSrv as projection} from '../service';

annotate projection.ProductsSet with {
    product      @title: 'Product';
    productName  @title: 'Product Name';
    description  @title: 'Description'  @UI.MultiLineText;
    supplier     @title: 'Supplier';
    category     @title: 'Category';
    subCategory  @title: 'Sub Category';
    rating       @title: 'Rating';
    stock        @title: 'Stock';
    price        @title: 'Price'        @Measures.Unit: currency;
    currency     @title: 'Currency'     @Common.IsCurrency;
};

// Para que en lugar de ID, tome las descripciones
annotate projection.ProductsSet with {
    subCategory @Common: {
        Text           : subCategory.subcategory,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_SubCategories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterIn',
                    LocalDataProperty: category_ID,
                    ValueListProperty: 'category_ID'
                },
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: subCategory_ID,
                    ValueListProperty: 'ID'
                }
            ]
        },
    };
    category    @Common: {
        Text           : category.category,
        // Solo ver el Text. Sino muestra el Texto + ID
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: category_ID,
                ValueListProperty: 'ID'
            }

            ]
        },
    };
    supplier    @Common: {
        Text           : supplier.suplierName,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Suppliers',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: supplier_ID,
                ValueListProperty: 'ID'
            }]
        },
    };
    stock       @Common: {
        Text           : stock.name,
        TextArrangement: #TextOnly,
    };

}


annotate projection.ProductsSet with @(
    UI.HeaderInfo                : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Product',
        TypeNamePlural: 'Products'
    },
    UI.SelectionFields           : [
        supplier_ID,
        category_ID,
        subCategory_ID
    ],

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: product
        },
        {
            $Type: 'UI.DataField',
            Value: productName
        },
        {
            $Type: 'UI.DataField',
            Value: supplier_ID
        },
        {
            $Type: 'UI.DataField',
            Value: category_ID
        },
        {
            $Type: 'UI.DataField',
            Value: subCategory_ID
        },
        {
            $Type                : 'UI.DataFieldForAnnotation',
            Target               : '@UI.DataPoint#RatingIndicator',
            Label                : 'Rating',
            //Seteamos el ancho de una columna
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '8rem'
            }
        },
        {
            $Type: 'UI.DataField',
            Value: stock_code
        },
        {
            $Type: 'UI.DataField',
            Value: price
        },
    ],
    UI.DataPoint #RatingIndicator: {
        $Type        : 'UI.DataPointType',
        Visualization: #Rating,
        Value        : rating,
    }
);
