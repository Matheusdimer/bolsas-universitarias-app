import 'package:app/auth/auth.service.dart';
import 'package:app/components/alert_dialog.dart';
import 'package:app/config/constants.dart';
import 'package:app/pages/app/account/tile_button.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final _authService = AuthService.instance;

  void _logout() async {
    await _authService.logout();
    final navigator = Navigator.of(context);
    navigator.pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              children: const [
                CircleAvatar(
                  foregroundImage: NetworkImage('$apiUrl/arquivos/1'),
                  radius: 70,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Matheus Dimer',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        ),
        TileButton(
          label: 'Minha conta',
          icon: Icons.account_circle_outlined,
          onTap: () => Navigator.of(context).pushNamed('/account'),
          top: true,
        ),
        TileButton(
          label: 'Endereço',
          icon: Icons.map_sharp,
          onTap: () => Navigator.of(context).pushNamed('/address'),
        ),
        TileButton(
          label: 'Sair',
          icon: Icons.logout,
          color: Colors.red.shade700,
          onTap: () => showAlertDialog(
            context: context,
            confirm: _logout,
            message: 'Tem certeza que realmente deseja sair?',
            confirmLabel: 'Sair',
            warn: true,
          ),
        ),
      ],
    );
  }
}