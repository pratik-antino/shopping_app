import 'package:permission_handler/permission_handler.dart';

class LocalNotification{
  
  Future<void> requestPermission()async{

    PermissionStatus status= await Permission.notification.request();

    if(status==PermissionStatus.granted){

    }


  }
}