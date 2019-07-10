import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainModels.dart';

class MainScope extends Model with
    MainModel,
    LoadingModel,
    AuthModel,
    SharedModel,
    NahalShopModel
{}