import 'package:flutter/cupertino.dart';
import 'package:health_guard/models/objects.dart';
import 'package:logger/logger.dart';
import '../../controllers/sensorData_controller.dart';

class SensorDataProvider extends ChangeNotifier {
  //---------local sensorData model
  SensorDataModel? _sensorDataModel;
  //---------get sensorData model
  SensorDataModel? get sensorDataModel => _sensorDataModel;

  //---------store loading state
  bool _isLoading = false;
  //---------get loading state
  bool get isLoading => _isLoading;

  //---------change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---------fetch sensor data
  Future<void> fetchSensorData() async {
    try {
      //---------start the loader
      setLoading(true);

      await SensorDataController().fetchData().then((value) {
        _sensorDataModel = value;

        //Logger().i(_sensorDataModel.toJson());

        //---------calling this to notify that usermodel has been set
        notifyListeners();

        //---------stop the loader
        setLoading(false);
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
