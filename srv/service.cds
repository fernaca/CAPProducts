using { FDCProducts as entities} from '../db/schema';

service FDCPrdSrv {

    entity ProductsSet as projection on entities.Products;

    @readonly
    entity VH_Categories as projection on entities.Categories;

    @readonly
    entity VH_SubCategories as projection on entities.SubCategories;

    @readonly
    entity VH_Suppliers as projection on entities.Suppliers;

    @readonly
    entity VH_Stock as projection on entities.Stock;

}