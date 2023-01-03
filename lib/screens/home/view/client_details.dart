import 'package:ekhatu/screens/home/controller/home_controller.dart';
import 'package:ekhatu/screens/home/view/debit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../database/database.dart';
import 'credit_screen.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({Key? key}) : super(key: key);

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {

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
    print("========================================= ${homeController!.homeModal!.id!}");
    homeController!.clientTotalAmountSum();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
          children: [
            Container(
              height: 230,
              color: Colors.indigo,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                            size: 30,
                          )),
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        "${homeController!.homeModal!.name}",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                      IconButton(
                          onPressed: () {

                            launch("tel: ${homeController!.homeModal!.mobile}");


                          },
                          icon: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 30,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Paid Amount",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Obx(
                                () => Text("₹ ${homeController!.clientpaidamount.value}",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.green)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Due Amount", style: TextStyle(fontSize: 25)),
                              Obx(
                                () =>  Text("₹ ${homeController!.clientdueamount.value}",
                                    style:
                                        TextStyle(fontSize: 25, color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.picture_as_pdf,
                            size: 40,
                            color: Colors.indigo,
                          ))),
                  Expanded(
                      child: IconButton(
                          onPressed: () async{
                            launch("https://wa.me/+91${homeController!.homeModal!.mobile}?text=Hello ${homeController!.homeModal!.name}, Your Total Amount Of ₹ ${homeController!.clientdueamount} Is Pending So Please Pay That Amount As Soon As Possible. \n THANK YOU");
                          },
                          icon: Icon(
                            Icons.whatsapp,
                            size: 40,
                            color: Colors.indigo,
                          ))),
                  Expanded(
                      child: IconButton(
                          onPressed: () {

                             launchUrl(Uri.parse("sms: +91${homeController!.homeModal!.mobile}?body=Hello ${homeController!.homeModal!.name}, Your Total Amount Of ₹ ${homeController!.clientdueamount} Is Pending So Please Pay That Amount As Soon As Possible. \n THANK YOU"));


                            },
                          icon: Icon(
                            Icons.message,
                            size: 40,
                            color: Colors.indigo,
                          ))),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Text(
                  "Purchase History",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Listview
            Expanded(
              child: Obx(
                () =>  ListView.builder(
                    itemCount: homeController!.productList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Get.defaultDialog(
                            content: Column(
                              children: [
                                IconButton(onPressed: (){
                                  EkhataDatabse database = EkhataDatabse();
                                  database.deleteProductData("${homeController!.productList.value[index]['productID']}");
                                  getData();
                                }, icon: Icon(Icons.delete)),
                              ],
                            )
                          );
                        },
                        child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    color: Colors.indigo.shade50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // SizedBox(width: 10,),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${homeController!.productList.value[index]['productNAME']}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "${DateTime.now().day}" "/" "${DateTime.now().month}" "/" "${DateTime.now().year }" " || " "${DateTime.now().hour}" ":" "${DateTime.now().minute}",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("", style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 80,
                                    color: Colors.red.shade100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "₹ ${homeController!.productList.value[index]['paymentSTATUS'] == 1 ? ' 0 ' : '${homeController!.productList.value[index]['productPRICE']}'}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    height: 80,
                                    color: Colors.green.shade100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "₹ ${homeController!.productList.value[index]['paymentSTATUS'] == 0 ? ' 0 ' : '${homeController!.productList.value[index]['productPRICE']}'}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              )
                            ],
                          ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Get.to(DebitScreen());
                        },
                        child: Container(
                    decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text("DEBIT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red.shade100),),
                  ),
                      )),


                  SizedBox(
                    width: 3,
                  ),


                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Get.to(CreditScreen());
                        },
                        child: Container(
                    decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text("CREDIT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green.shade100),),

                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  
  

  
  
}
