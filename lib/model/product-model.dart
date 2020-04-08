 class Products {
  bool  flour;
  bool  grihasthi;
  bool  isActive;
  bool  isDeleted;
  bool  isReducestock;
  int  qty;
  bool  oil;
  bool  pulse;
  bool  rice;
  List<ImageDetails> images;
  String createdDate;
  String updatedDate;
  String id;
  String productId;
  String name;
  String description;
  String sku;
  String brand;
  int stocklevel;
  String type;
  String category;
  String subCategory;
  String mrp;
  int discountRate;
  int taxRate;
  int v;

  int shippingCharges;
  int netPrice;
 
 
  Products({this.flour, this.grihasthi, this.isActive,this.isDeleted,this .isReducestock ,this.qty, this.oil,this.pulse, this.rice, this.images, 
  this.createdDate, this.updatedDate,this.id, this.productId, this.name ,this.description, this.sku,this.brand, this.stocklevel, this.type,
  this.category, this.subCategory,this.mrp, this.discountRate, this.taxRate ,this .v,this.shippingCharges, this.netPrice});

  factory Products.fromJson(Map<String, dynamic> parsedJson){

    var imagList = parsedJson['images'] as List;
    // print(imagList.runtimeType);
    List<ImageDetails> dataList = imagList.map((i) => ImageDetails.fromJson(i)).toList();


    return Products(
        flour: parsedJson['FLOUR'],
        grihasthi: parsedJson['GRIHASTHI'],
        isActive: parsedJson['ISACTIVE'],
        isDeleted: parsedJson['ISDELETED'],
         qty: parsedJson['QTY'],
        oil: parsedJson['OIL'],
         pulse: parsedJson['PULSE'],
        rice: parsedJson['RICE'],
         images: dataList,
        createdDate: parsedJson['CREATED_DATE'],
         updatedDate: parsedJson['UPDATED_DATE'],
        id: parsedJson['_id'],
        productId: parsedJson['PRODUCT_ID'],
        name: parsedJson['NAME'],
         description: parsedJson['DESCRIPTION'],
        sku: parsedJson['SKU'],
         brand: parsedJson['BRAND'],
        stocklevel: parsedJson['STOCKLEVEL'],
         type: parsedJson['TYPE'],
        category: parsedJson['CATEGORY'],
         subCategory: parsedJson['SUBCATEGORY'],
        mrp: parsedJson['MRP'],
         discountRate: parsedJson['DISCOUNTRATE'],
        taxRate: parsedJson['TAXRATE'],
        v:parsedJson['_v'],
        shippingCharges: parsedJson['SHIPPINGCHARGES'],
        netPrice: parsedJson['NETPRICE']



    );
       
  }
  
 }
 
 class ImageDetails {
  String createdAt;
  String url;
  int progress;
  String name;
  ImageDetails({this.createdAt, this.url , this .progress , this .name});
   factory ImageDetails.fromJson(Map<String,dynamic> parsedJson){
    return ImageDetails(
      createdAt: parsedJson['createdAt'],
      url: parsedJson['url'],
      progress: parsedJson['Progress'],
      name: parsedJson['name']
    );
  }
}