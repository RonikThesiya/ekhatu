import 'package:ekhatu/database/database.dart';
import 'package:ekhatu/screens/home/modal/home_modal.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  RxList<Map> clientList = <Map>[].obs;
  RxList<Map> productList = <Map>[].obs;
  RxList<Map> productListsum = <Map>[].obs;

  RxInt clientpaidamount = 0.obs;
  RxInt clientdueamount = 0.obs;

  RxInt hometotalincome = 0.obs;
  RxInt homependingincome = 0.obs;




  HomeModal? homeModal;


  void clientTotalAmountSum()
  {
    int i = 0;
    clientpaidamount.value = 0;
    clientdueamount.value = 0;


    for(i=0;i<productList.length;i++)
    {
      if(productList[i]['paymentSTATUS'] == 1)
      {
        clientpaidamount.value = int.parse(productList[i]['productPRICE']) + clientpaidamount.value;
      }
      else
      {
        clientdueamount.value = int.parse(productList[i]['productPRICE']) + clientdueamount.value;
      }
    }

  }


  void totalmainincome()async
  {
    int i = 0;
    hometotalincome.value = 0;
    homependingincome.value = 0;
    EkhataDatabse databse = EkhataDatabse();
    productListsum.value = await databse.readProductSumData();

    for(i=0;i<productListsum.length;i++)
      {
        if(productListsum[i]["paymentSTATUS"] == 1)
          {
            hometotalincome.value = hometotalincome.value + int.parse(productListsum[i]["productPRICE"]);
          }
        else
          {
            homependingincome.value = homependingincome.value + int.parse(productListsum[i]["productPRICE"]);

          }
      }

    
  }
}