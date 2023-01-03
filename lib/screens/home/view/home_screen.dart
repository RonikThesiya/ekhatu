import 'package:ekhatu/database/database.dart';
import 'package:ekhatu/screens/home/controller/home_controller.dart';
import 'package:ekhatu/screens/home/modal/home_modal.dart';
import 'package:ekhatu/screens/home/view/client_details.dart';
import 'package:ekhatu/screens/home/view/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController? homeController = Get.put(HomeController());

  TextEditingController clientName = TextEditingController();
  TextEditingController clientMobile = TextEditingController();
  TextEditingController clientAddress = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController userMobile = TextEditingController();
  TextEditingController userAddress = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    homeController!.totalmainincome();
    homeController!.clientTotalAmountSum();

  }

  void getData()async
  {
    EkhataDatabse databse = EkhataDatabse();
    homeController!.clientList.value = await databse.readClientData();
    homeController!.productListsum.value = await databse.readProductData(homeController!.homeModal!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Obx(
        () =>  Column(
          children: [
            SizedBox(height: 1,),

            //Appbar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.menu,size: 30,color: Colors.white)),
                        SizedBox(width: 10,),
                        Text("E-Khatu",style: TextStyle(fontSize: 22,color: Colors.white)),
                        Expanded(child: Container(alignment: Alignment.centerRight,child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Colors.white,size: 30,)))),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2,),
            // income bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              //Total income
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    // color: Colors.yellow,
                                    border: Border.all(width: 0.5,color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(top: 45)),
                                      Text("Total Income",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
                                      SizedBox(height: 20,),
                                      Obx(() =>  Text("₹ ${homeController!.hometotalincome.value}",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Colors.green),)),
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              ),
                              //Pending income
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 5,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                    // color: Colors.yellow,
                                    border: Border.all(width: 0.5,color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(top: 45)),
                                      Text("Pending Income",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
                                      SizedBox(height: 20,),
                                      Obx(() =>  Text("₹ ${homeController!.homependingincome.value}",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Colors.red),)),
                                      SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                                ),
                              //View history
                            ],
                          ),
                          //View History
                          Expanded(child: TextButton(onPressed: (){
                            Get.to(History());

                          }, child: Text("View History >>",style: TextStyle(color: Colors.indigo,fontSize: 16),)))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            //Client List
            Expanded(
              child: ListView.builder(itemCount: homeController!.clientList.value.length,itemBuilder: (context,index){
                return  InkWell(
                  onTap: (){
                    homeController!.homeModal = HomeModal(
                      name: homeController!.clientList.value[index]['name'],
                      mobile: homeController!.clientList.value[index]['mobile'],
                      address: homeController!.clientList.value[index]['address'],
                      id: homeController!.clientList.value[index]['clientID'].toString(),
                    );

                    Get.to(ClientDetails());
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.person,size: 40,),maxRadius: 25),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text("${homeController!.clientList.value[index]['name']}",style: TextStyle(fontSize: 24),),
                                          SizedBox(height: 5,),
                                          Text("${homeController!.clientList.value[index]['mobile']}",style: TextStyle(fontSize: 16),),
                                        ],
                                      ),
                                    ),

                                    IconButton(onPressed: (){

                                      userName = TextEditingController(
                                        text: "${homeController!.clientList.value[index]['name']}"
                                      );
                                      userMobile = TextEditingController(
                                        text: "${homeController!.clientList.value[index]['mobile']}"
                                      );
                                      userAddress = TextEditingController(
                                        text: "${homeController!.clientList.value[index]['address']}"
                                      );

                                      Get.defaultDialog(
                                          content: Column(
                                            children: [
                                              TextField(
                                                controller: userName,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Client Name"),
                                                ),
                                              ),
                                              SizedBox(height: 10,),

                                              TextField(
                                                controller: userMobile,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Client Mobile Number"),
                                                ),
                                              ),
                                              SizedBox(height: 10,),

                                              TextField(
                                                controller: userAddress,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Client Address"),
                                                ),
                                              ),
                                              SizedBox(height: 10,),

                                              ElevatedButton(onPressed: (){
                                                EkhataDatabse database = EkhataDatabse();
                                                database.updateClientData("${homeController!.clientList.value[index]['clientID']}",userName.text, userMobile.text, userAddress.text);
                                                getData();
                                                Get.back();
                                              }, child: Text("Update",style: TextStyle(fontSize: 15),))
                                            ],
                                          )
                                      );

                                    }, icon: Icon(Icons.edit)),

                                    IconButton(onPressed: (){
                                      EkhataDatabse database = EkhataDatabse();
                                      database.deleteClientData("${homeController!.clientList.value[index]['clientID']}");
                                      getData();
                                    }, icon: Icon(Icons.delete)),
                                  ],
                                ),
                                SizedBox(height: 5,),

                              ],
                            ),

                          ),
                        )
                      ],)
                    ],
                  ),
                );
              }),
            )

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add,size: 25,),
        label: Text("Add Customer",style: TextStyle(fontSize: 15),),
        onPressed: (){
          Get.defaultDialog(
            title: "Enter Client Details",
            content: Column(
              children: [
                TextField(
                  controller: clientName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Client Name"),
                  ),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: clientMobile,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Client Mobile Number"),
                  ),
                ),
                SizedBox(height: 10,),

                TextField(
                  controller: clientAddress,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Client Address"),
                  ),
                ),
                SizedBox(height: 10,),

                ElevatedButton(onPressed: (){
                  EkhataDatabse database =EkhataDatabse();
                  database.insertClientData(clientName.text, clientMobile.text, clientAddress.text);
                  getData();
                  Get.back();
                }, child: Text("ADD",style: TextStyle(fontSize: 15),))
              ],
            )
          );
        },
      ),
    ));
  }
}
