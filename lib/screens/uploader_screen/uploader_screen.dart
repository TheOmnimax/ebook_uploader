import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebook_uploader/bloc/bloc.dart';
import 'package:ebook_uploader/screens/uploader_screen/bloc/bloc.dart';
import 'package:ebook_uploader/shared_widgets/shared_widgets.dart';

class UploaderScreen extends StatelessWidget {
  const UploaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UploaderBloc(),
      child: const UploaderMain(),
    );
  }
}

class UploaderMain extends StatelessWidget {
  const UploaderMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = context.watch<AppBloc>();
    return BlocBuilder<UploaderBloc, UploaderState>(builder: (context, state) {
      // Return either select file or upload button
      RoundButton getButton() {
        if (state is FileSelected) {
          return RoundButton(
              text: 'Upload file',
              onPressed: () async {
                context.read<UploaderBloc>().add(
                      UploadFile(
                        file: state.file,
                        token: await appBloc.authToken,
                      ),
                    );
              });
        }
        return RoundButton(
            text: 'Select file',
            onPressed: () {
              context.read<UploaderBloc>().add(const SelectorButton());
            });
      }

      return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              LoginTile(
                username: appBloc.state.username,
                logout: () async {
                  await showPopup(
                    context: context,
                    title: 'Log out',
                    buttons: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Stay'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<AppBloc>().add(const Logout());
                        },
                        child: const Text('Log out'),
                      ),
                    ],
                    body: const Text(
                      'Are you sure you would like to log out?',
                    ),
                  );
                },
                login: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Text(state.message),
              getButton(),
            ],
          ),
        ),
      );
    });
  }
}

class LoginTile extends StatelessWidget {
  const LoginTile({
    Key? key,
    this.username = '',
    required this.login,
    required this.logout,
  }) : super(key: key);

  final String username;
  final Function() login;
  final Function() logout;

  @override
  Widget build(BuildContext context) {
    if (username == '') {
      return ListTile(
        title: const Text('Log in'),
        onTap: login,
      );
    } else {
      return ListTile(
        title: Text(username),
        trailing: TextButton(
          onPressed: logout,
          child: const Text('Log out'),
        ),
      );
    }
  }
}
