import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EkhataDatabse {


  Database? database;

  Future<Database> checkDatabase() async
  {
    if (database != null) {
      return database!;
    }
    else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async
  {
    Directory mobilepath = await getApplicationDocumentsDirectory();
    String path = join(mobilepath.path, "Ekhatu.db");

    return openDatabase(path, version: 1, onCreate: (database, version) {
      String clientquery = "CREATE TABLE client(clientID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, mobile TEXT, address TEXT)";
      String productquery = "CREATE TABLE product(productID INTEGER PRIMARY KEY AUTOINCREMENT, productNAME TEXT , productQUANTITY TEXT, productPRICE TEXT , currentDATE TEXT , paymentSTATUS INTEGER, paymentDueDATE TEXT, paymentTYPE TEXT, clientID INTEGER)";


        database.execute(clientquery);
        database.execute(productquery);
    }
    );
  }

  //client insert

  void insertClientData(String cname,String cmobile,String caddress)async
  {
    database = await checkDatabase();
    database!.insert("client",{"name" : cname , "mobile" : cmobile , "address" : caddress});
  }

  //product insert
  void insertProductData(String pname,String pquantity,String pprice,String currentdate,int paymentstatus,String duedate,String paymenttype,String cid)async
  {
    database = await checkDatabase();
    database!.insert("product",{"productNAME" : pname , "productQUANTITY" : pquantity , "productPRICE" : pprice, "currentDATE" : currentdate, "paymentSTATUS" : paymentstatus, "paymentDueDATE" : duedate, "paymentTYPE" : paymenttype, "clientID" : cid});
  }

  //client readdata
  Future<List<Map>> readClientData()async
  {
    database = await checkDatabase();
    String clientquery ="SELECT * FROM client";
    List<Map> clientList = await database!.rawQuery(clientquery,null);
    return clientList;
  }

  //Product readdata
  Future<List<Map>> readProductData(String id)async
  {
    database = await checkDatabase();

    String productquery ="SELECT * FROM product where clientID = $id";

    // String productquery = "";
    // if (id != null)
    //   productquery = "SELECT * FROM product where clientID = $id";
    // else
    //   productquery = "SELECT * FROM product";


    List<Map> productList = await database!.rawQuery(productquery,null);
    return productList;
  }
  Future<List<Map>> readProductSumData()async
  {
    database = await checkDatabase();


    String  productquery = "SELECT * FROM product";


    List<Map> productList = await database!.rawQuery(productquery,null);
    return productList;
  }


  //client detetdata
   void deleteClientData(String clientID)async
   {
     database = await checkDatabase();
     database!.delete("client",where: "clientID = ?",whereArgs: [int.parse(clientID)]);
   }

   //Product deletedata
   void deleteProductData(String productID)async
   {
     database = await checkDatabase();
     database!.delete("product",where: "productID = ?",whereArgs: [int.parse(productID)]);
   }


  //client updatedata
   void updateClientData(String clientID,String cname,String cmobile,String caddress)async
   {
     database  = await checkDatabase();
     database!.update("client", {"name" : cname , "mobile" : cmobile , "address" : caddress},where: "clientID = ?",whereArgs: [int.parse(clientID)]);
   }


   //Product updatedata
   void updatePproductData(String productID,String pname,String pquantity,String pprice,String currentdate,String paymentstatus,String duedate,String paymenttype,String cid,)async
   {
     database  = await checkDatabase();
     database!.update("product",{"productNAME" : pname , "productQUANTITY" : pquantity , "productPRICE" : pprice, "currentDATE" : currentdate, "paymentSTATUS" : paymentstatus, "paymentDueDATE" : duedate, "paymentTYPE" : paymenttype, "clientID" : cid},where: "productID = ?",whereArgs: [int.parse(productID)]);
   }


}
