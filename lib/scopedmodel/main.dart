import 'package:scoped_model/scoped_model.dart';
import 'package:sawjigrocerryapp/model/product-model.dart';

class MainModel extends Model {
  List<Products> cartList=[];
  int cartItemsCount=0;
  double cartTotal;

  List<Products> get cartItems{
    return cartList;
  }
  int get cartitemcount{
    return cartItemsCount;
  }

  void addCartItems (Products item){
     cartTotal = 0;
    cartList.add(item);
     for (var items in cartList) {
           cartTotal += items.qty * items.netPrice;
      }
       notifyListeners();
  }

  void updateCartItems(List<Products> items) {
    cartList = items;
  }

  void  updateQuantity(index,action){
     cartTotal = 0;
     if(action=='add'){
       cartList[index].qty = cartList[index].qty + 1;

     }else{
      if( cartList[index].qty>0){
        cartList[index].qty = cartList[index].qty - 1;
      }
     }
     for (var items in cartList) {
           cartTotal += items.qty * items.netPrice;
      }
    notifyListeners();
  }

  void incrementCount() {
    cartItemsCount += 1;
    notifyListeners();
  }
}