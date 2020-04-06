class ProductType {
 final List<ProductCategory> categories; 
 final List <ImageDetails> images;
 final bool isDeleted;
 final String id;
 final String type;
 final String productId;
 final int v;

  ProductType({this .categories , this .images ,this.isDeleted, this.id , this.type , this .productId ,this.v});
    factory ProductType.fromJson(Map<String, dynamic> parsedJson){
       var categoryList = parsedJson['CATEGORY'] as List;
       var imagesList =  parsedJson['images'] as List;

    List<ProductCategory> list =   categoryList.map((i) => ProductCategory.fromJson(i)).toList();
    List <ImageDetails > images =  imagesList.map((i) => ImageDetails.fromJson(i)).toList();
     
     return ProductType(
        categories: list,
        images: images,
        isDeleted: parsedJson['ISDELETED'],
        id: parsedJson['_id'],
        type: parsedJson['TYPE'],
        productId: parsedJson['ID'],
        v: parsedJson['__v'],

     );


    }


}
class ProductCategory {
final String name;
 final String value;
 ProductCategory({this.name,this.value});
    factory ProductCategory.fromJson(Map<String, dynamic> parsedJson){
      return ProductCategory(
       name:  parsedJson["name"],
       value :parsedJson["value"]
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