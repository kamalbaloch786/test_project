import 'package:get/get.dart';

import 'Dataservices.dart';
import 'Language_model.dart';

class Controller extends GetxController{
  var isLoadings = true.obs;
  final data= <LanguageModel>[].obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchfinallang();

  }
  void fetchfinallang() async {
    isLoadings(true);
    try {
      var todos = await Dataservices.getdata();
      print('data is ${todos.length}');
      if (todos != null) {
        data!.value = todos;
      }
    } finally {
      isLoadings(false);
    }
  }
}