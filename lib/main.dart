import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'db/db_helper.dart';
import 'ui/add_event_page.dart';
import 'ui/home_page.dart';
import 'ui/theme.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MainScreen());
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TexPic Calendar',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      themeMode: ThemeMode.light,
      home: CalendarScreen(),
    );
  }
}

void _handleNewDate(date) {
  print('Date selected: $date');
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver{
  bool _isPermissionGranted = false;
  late final Future<void>_future;
  CameraController? _cameraController;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCamerapermission();
  }
  @override
  void dispose(){
    super.initState();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            title:const Text('Text Recognition sample'),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(left:24.0, right: 24.0),
              child: Text(
                _isPermissionGranted
                    ? 'Camera Permission granted'
                    : 'Camera Permission denied',
                textAlign: TextAlign.center,

              ),
            ),
          ),
        );
      });
  }


  Future<void> _requestCamerapermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera(){
    if (_cameraController != null){
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera(){
    if (_cameraController != null){
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras){
    if (_cameraController != null) {
      return ;
    }

    CameraDescription? camera;
    for (var i=0; i < cameras.length;i++){
      final CameraDescription current = cameras[i];
      if(current.lensDirection == CameraLensDirection.back ){
        camera = current;
        break;
      }
    }

    if (camera != null){
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
    );

    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

}
