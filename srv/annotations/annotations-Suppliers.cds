using {FDCPrdSrv as projection} from '../service';

annotate projection.VH_Suppliers with {
    ID @title : 'Suppliers' @Common : { 
        Text : suplierName,
        TextArrangement : #TextOnly
     }
};
