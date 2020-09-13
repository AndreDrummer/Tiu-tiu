import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiutiu/Custom/icons.dart';
import 'package:tiutiu/Widgets/circle_child.dart';
import 'package:tiutiu/Widgets/my_account_card.dart';
import 'package:tiutiu/Widgets/popup_message.dart';
import 'package:tiutiu/providers/auth2.dart';
import 'package:tiutiu/providers/user_provider.dart';
import 'package:tiutiu/utils/routes.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Widget appBar(UserProvider userProvider) {
    return PreferredSize(
      preferredSize: Size.fromHeight(200.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Container(
            // padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleChild(
                    avatarRadius: 60,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/profileEmpty.jpg'),
                      image: NetworkImage(
                        userProvider.photoURL,
                      ),
                      fit: BoxFit.cover,
                      width: 1000,
                      height: 1000,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          userProvider.displayName,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Usuário desde 16 de Setembro de 2020',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircleChild(
                                  avatarRadius: 15,
                                  child: Text('15',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Text(
                                  'Doados',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleChild(
                                  avatarRadius: 15,
                                  child: Text('10',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Text(
                                  'Adotados',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleChild(
                                  avatarRadius: 15,
                                  child: Text('2',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Text(
                                  'Desaparecidos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    GlobalKey<ScaffoldState> _formScaffold = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _formScaffold,
      backgroundColor: Colors.blueGrey[50],
      appBar: appBar(userProvider),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                MyAccountCard(
                  icone: PetDetailIcons.dog,
                  text: 'Meus PETS',
                  onTap: () {
                    _formScaffold.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Ainda não disponível'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    // Navigator.pushNamed(context, Routes.MEUS_PETS);
                  },
                ),
                MyAccountCard(
                  icone: Icons.favorite_border,
                  text: 'Meus Favoritos',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.FAVORITES);
                  },
                ),
              ],
            ),
            Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, Routes.SETTINGS);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: Colors.grey, size: 30),
                          SizedBox(width: 20),
                          Text(
                            'Configurações',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: 22,
                                      color: Colors.blueGrey[400],
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => PopUpMessage(
                          confirmAction: () {
                            auth.signOut();
                            Navigator.pop(context);
                          },
                          confirmText: 'Sim',
                          denyAction: () {
                            Navigator.pop(context);
                          },
                          denyText: 'Não',
                          warning: true,
                          message: 'Tem certeza que deseja deslogar?',
                          title: 'Signout',
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, color: Colors.grey, size: 30),
                          SizedBox(width: 20),
                          Text(
                            'Sair',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      fontSize: 22,
                                      color: Colors.blueGrey[400],
                                    ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Center(
//         child: ListView(
//           children: [
//             SizedBox(height: 20),
//             ListTileDrawer(
//               tileName: 'Meus PETS',
//               imageAsset: 'assets/dogCat2.png',
//               callback: () {
//                 _formScaffold.currentState.showSnackBar(
//                   SnackBar(
//                     content: Text('Ainda não disponível'),
//                     duration: Duration(seconds: 1),
//                   ),
//                 );
//                 // Navigator.pushNamed(context, Routes.MEUS_PETS);
//               },
//             ),
//             ListTileDrawer(
//               tileName: 'Meus Favoritos',
//               icon: Icons.star,
//               callback: () {
//                 Navigator.pushNamed(context, Routes.FAVORITES);
//               },
//             ),
//             ListTileDrawer(
//               tileName: 'Configurações',
//               icon: Icons.settings,
//               callback: () {
//                 Navigator.pushNamed(context, Routes.SETTINGS);
//               },
//             ),
//             Spacer(),
//             ListTileDrawer(
//               tileName: 'Sair',
//               icon: Icons.exit_to_app,
//               callback: () async {
//                 await showDialog(
//                   context: context,
//                   builder: (context) => PopUpMessage(
//                     confirmAction: () {
//                       auth.signOut();
//                       Navigator.pop(context);
//                     },
//                     confirmText: 'Sim',
//                     denyAction: () {
//                       Navigator.pop(context);
//                     },
//                     denyText: 'Não',
//                     warning: true,
//                     message: 'Tem certeza que deseja deslogar?',
//                     title: 'Signout',
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
