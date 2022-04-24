import 'package:app/auth/auth.service.dart';
import 'package:app/components/alert_dialog.dart';
import 'package:app/components/error_page.dart';
import 'package:app/components/future_tracker.dart';
import 'package:app/components/loading-list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/model/aluno.dart';
import 'package:app/pages/app/account/aluno.service.dart';
import 'package:app/pages/app/account/tile_button.dart';
import 'package:app/services/arquivos.service.dart';
import 'package:flutter/material.dart';

enum PictureOptions { edit, delete }

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final _authService = AuthService.instance;
  final _arquivoService = ArquivoService();
  final _alunoService = AlunoService();
  final ImagePicker _picker = ImagePicker();

  late final Future<Aluno> _aluno = _alunoService.aluno;

  bool _uploadProgress = false;

  void _logout() async {
    await _authService.logout();
    final navigator = Navigator.of(context);
    navigator.pushNamed('/login');
  }

  _viewPicture(Aluno aluno) {
    if (aluno.usuario.fotoId == null) {
      _setProfilePicture(aluno);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ImageScreen(
          imageUrl: _arquivoService.getUrl(aluno.usuario.fotoId),
        );
      }));
    }
  }

  _setProfilePicture(Aluno aluno) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    _setUploadProgress(true);

    if (aluno.usuario.fotoId != null) {
      await _arquivoService.remove(aluno.usuario.fotoId!);
    }

    final arquivo = await _arquivoService.upload(image, null);

    _setUploadProgress(false);

    aluno.usuario.fotoId = arquivo.id;

    _authService
        .updateUser(aluno.usuario)
        .then((value) => setState(() => aluno.usuario = value));
  }

  _setUploadProgress(bool value) {
    setState(() {
      _uploadProgress = value;
    });
  }

  _removePicture(Aluno aluno) async {
    if (aluno.usuario.fotoId != null) {
      await _arquivoService.remove(aluno.usuario.fotoId!);
    }

    aluno.usuario.fotoId = null;

    _authService
        .updateUser(aluno.usuario)
        .then((value) => setState(() => aluno.usuario = value));
  }

  Future<void> _pictureOptions(Aluno aluno) async {
    switch (await showDialog<PictureOptions>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Mais opções'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, PictureOptions.edit);
                },
                child: const Text('Editar imagem'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, PictureOptions.delete);
                },
                child: const Text('Remover imagem'),
              ),
            ],
          );
        })) {
      case PictureOptions.delete:
        _removePicture(aluno);
        break;
      case PictureOptions.edit:
        _setProfilePicture(aluno);
        break;
      case null:
        break;
    }
  }

  bool showAvatar(Aluno aluno) {
    return aluno.usuario.fotoId != null && !_uploadProgress;
  }

  bool hasPicture(Aluno aluno) {
    return aluno.usuario.fotoId != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureTracker<Aluno>(
      future: _aluno,
      loading: const CustomShimmer(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: buildErrorPage(context),
      completed: (aluno) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => _viewPicture(aluno),
                    onLongPress: () => _pictureOptions(aluno),
                    child: showAvatar(aluno)
                        ? Avatar(
                            imageUrl:
                                _arquivoService.getUrl(aluno.usuario.fotoId),
                          )
                        : _uploadProgress
                            ? const AvatarLoading()
                            : const Icon(
                                Icons.account_circle,
                                size: 140,
                              ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    aluno.nome,
                    style: const TextStyle(fontSize: 25),
                  )
                ],
              ),
            ),
          ),
          TileButton(
            label: 'Meus dados',
            icon: Icons.account_circle_outlined,
            onTap: () =>
                Navigator.of(context).pushNamed('/account', arguments: aluno),
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
      ),
    );
  }
}

class AvatarLoading extends StatelessWidget {
  const AvatarLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(100)),
      height: 140,
      width: 140,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final String imageUrl;

  const Avatar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Hero(
        tag: 'profilePicture',
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(
            value: downloadProgress.progress,
            color: Colors.white,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      radius: 70,
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'profilePicture',
            child: CachedNetworkImage(imageUrl: imageUrl),
          ),
        ),
      ),
    );
  }
}
