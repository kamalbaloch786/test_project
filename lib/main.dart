import 'dart:async';
import 'package:domo_project/Controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domo_project/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_language_fonts/google_language_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: home());
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  final Controller controller = Get.put(Controller());
  final spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child:Container(
            alignment: Alignment.center,
            child: Column(
                children:[
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom:30),
                    color: Colors.white,
                    //red color on offline, green on online
                    padding:EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(isoffline?"Device is Offline":"Device is Online",
                        style: TextStyle(
                            fontSize: 20, color: Colors.black45
                        ),),
                        Icon(Icons.wifi,color: isoffline?Colors.red:Colors.green,)
                    ],),
                  ),

                  ElevatedButton(onPressed: () async {
                    var result = await Connectivity().checkConnectivity();
                    if(result == ConnectivityResult.mobile) {
                      print("Internet connection is from Mobile data");
                      title="Internet connection is from Mobile data";
                    }else if(result == ConnectivityResult.wifi) {
                      print("internet connection is from wifi");
                      title="internet connection is from wifi";
                    }else if(result == ConnectivityResult.ethernet){

                      print("internet connection is from wired cable");

                      title="internet connection is from wired cable";
                    }else if(result == ConnectivityResult.bluetooth){
                      print("internet connection is from bluethooth threatening");
                      title="internet connection is from bluethooth threatening";
                    }else if(result == ConnectivityResult.none){
                      print("No internet connection");
                      title="No internet connection";
                    }
                  },
                      child: Text("Check Internet Connection")
                  ),


             Obx(() =>  Container(

                height: 200,
                child:controller.isLoadings.value? spinkit:ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.data[0].language!.length,
                    itemBuilder: (context,index){
                  return Column(
mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3,
                        alignment: Alignment.center,

                        child:    Image.network(controller.data[0].language![index].imagePath!,height: 50,width: 50,),

                        padding: EdgeInsets.all(10),

                      ),
                      Container(

                        child: Text(controller.data[0].language![index].title!,style:CyrillicFonts.robotoCondensed(
                          textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
                        ), textDirection: TextDirection.ltr,),
                      ),
                    ],
                  );
                }),

             )

                    ),
                ]
            )
        ),
      ),
    );
  }



  StreamSubscription? connection;
  bool isoffline = false;
 String title='';


  @override
  void initState() {
  //  print("data  ${controller.data[0].language!.length}");

    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.ethernet){
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.bluetooth){
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }
}
