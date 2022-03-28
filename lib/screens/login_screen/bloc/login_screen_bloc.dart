import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebook_uploader/screens/login_screen/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState());
}
