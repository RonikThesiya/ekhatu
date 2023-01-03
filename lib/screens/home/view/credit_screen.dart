import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../database/database.dart';
import '../controller/home_controller.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {

  TextEditingController txtproductname = TextEditingController();
  TextEditingController txtproductquantity = TextEditingController();
  TextEditingController txtproductprice = TextEditingController();
  TextEditingController txtcurrentdate = TextEditingController();
  TextEditingController txtpaymentstatus = TextEditingController();
  TextEditingController txtcurrenttime = TextEditingController();
  TextEditingController txtduedate = TextEditingController();
  TextEditingController txtpatmenttype = TextEditingController();

  HomeController? homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData()async
  {
    EkhataDatabse databse = EkhataDatabse();
    homeController!.productList.value = await databse.readProductData(homeController!.homeModal!.id!);
    homeController!.clientTotalAmountSum();
    homeController!.totalmainincome();

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtproductname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Product Name"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtproductquantity,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Product Quantity"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtproductprice,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Product Price"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtcurrentdate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Current Date"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtcurrenttime,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Current time"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtduedate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Due date"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtpatmenttype,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Payment type"),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  EkhataDatabse database = EkhataDatabse();
                  database.insertProductData(txtproductname.text, txtproductquantity.text, txtproductprice.text, txtcurrentdate.text, 1, txtduedate.text, txtpatmenttype.text, homeController!.homeModal!.id!);
                  getData();

                  Get.back();
                },
                child: Text(
                  "CREDIT",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    ));
  }
}
