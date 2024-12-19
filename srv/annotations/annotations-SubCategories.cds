using {FDCPrdSrv as projection} from '../service';

annotate projection.VH_SubCategories with {
    ID @title : 'Sub Categories ' @Common : { 
        Text : subcategory,
        TextArrangement : #TextOnly
     }
};
