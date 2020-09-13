import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:tiutiu/Custom/pet_detail_icons_icons.dart';
import 'package:tiutiu/Widgets/button.dart';
import 'package:tiutiu/Widgets/card_details.dart';
import 'package:tiutiu/Widgets/divider.dart';
import 'package:tiutiu/Widgets/dots_indicator.dart';
import 'package:tiutiu/backend/Controller/user_controller.dart';
import 'package:tiutiu/backend/Model/pet_model.dart';
import 'package:tiutiu/providers/auth2.dart';
import 'package:tiutiu/providers/favorites_provider.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetails extends StatefulWidget {
  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  final PageController _pageController = PageController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FavoritesProvider favoritesProvider;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendEmail(
      String emailAddress, String subject, String message) async {
    var url = 'mailto:$emailAddress?subject=$subject&body=$message';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Map<String, dynamic>> loadOwnerInfo(Pet pet) async {
    final user = await pet.ownerReference.get();

    List petDetails = [
      {'title': 'TIPO', 'text': pet.type, 'icon': PetDetailIcons.guidedog},
      {'title': 'RAÇA', 'text': pet.breed, 'icon': PetDetailIcons.dog},
      {
        'title': 'TAMANHO',
        'text': pet.size,
        'icon': PetDetailIcons.resize_small
      },
      {'title': 'SAÚDE', 'text': pet.health, 'icon': PetDetailIcons.healing},
      {
        'title': 'IDADE',
        'text': '${pet.ano}a ${pet.meses}m',
        'icon': PetDetailIcons.calendar
      },
    ];

    List ownerDetails = [
      {
        'text': user.data()['displayName'] ?? '',
        'launchIcon': Icons.remove_red_eye,
        'imageN': user.data()['photoURL'] ?? '',
        'callback': () {
          print('Exibir perfil de usuário');
        },
      },
      {
        'text': user.data()['betterContact'] == 0
            ? user.data()['phoneNumber']
            : user.data()['betterContact'] == 1
                ? user.data()['landline']
                : user.data()['email'],
        'icon': user.data()['betterContact'] == 0
            ? PetDetailIcons.whatsapp
            : user.data()['betterContact'] == 1 ? Icons.phone : Icons.email,
        'color': user.data()['betterContact'] == 0
            ? Colors.green
            : user.data()['betterContact'] == 1 ? Colors.orange : Colors.red,
        'callback': () {
          String serializedNumber = user
              .data()['phoneNumber']
              .split('(')[1]
              .replaceAll(')', '')
              .replaceAll('-', '')
              .replaceAll(' ', '');
          if (user.data()['betterContact'] == 0) {
            FlutterOpenWhatsapp.sendSingleMessage('+55$serializedNumber',
                'Olá! Tenho interesse e gostaria de saber mais detalhes sobre o PET *${pet.name}* que postou no app *_Tiu, Tiu_*.');
          } else if (user.data()['betterContact'] == 1) {
            String serializedNumber = user
                .data()['landline']
                .split('(')[1]
                .replaceAll(')', '')
                .replaceAll('-', '')
                .replaceAll(' ', '');
            _makePhoneCall('tel: $serializedNumber');
          } else {
            _sendEmail(
              user.data()['email'],
              'Tenho interesse no PET ${pet.name}',
              'Olá! Tenho interesse e gostaria de saber mais detalhes sobre o PET ${pet.name} que postou no app Tiu, Tiu.',
            );
          }
        }
      },
      {
        'text': 'Localização',
        'image': 'assets/static_map.jpg',
        // 'imageN': 'https://maps.googleapis.com/maps/api/staticmap?center=${pet.latitude}, ${pet.longitude}&zoom=14&markers=color&markers=color:red%7Clabel:%7c-16.7502014,%20-49.256370000000004&size=600x400&key=${Constantes.WEB_API_KEY}',
        'callback': () {
          MapsLauncher.launchCoordinates(
            pet.latitude,
            pet.longitude,
            pet.name,
          );
        }
      },
    ];

    final result = {'petDetails': petDetails, 'ownerDetails': ownerDetails};

    return Future.value(result);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<FavoritesProvider>(context, listen: false)
        .loadFavoritesReference();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;

    Pet pet = arguments['petInfo'];
    String kind = arguments['kind'];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Detalhes de ${pet.name}'),
      ),
      body: FutureBuilder(
          future: loadOwnerInfo(arguments['petInfo']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingBumpingLine.circle(
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Carregando informações',
                      style: Theme.of(context).textTheme.headline1.copyWith(),
                    )
                  ],
                ),
              );
            }
            return Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/cao e gato.png',
                      ),
                    )),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      showImages(pet.photos),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data['petDetails'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardDetails(
                                title: snapshot.data['petDetails'][index]
                                    ['title'],
                                icon: snapshot.data['petDetails'][index]
                                    ['icon'],
                                text: snapshot.data['petDetails'][index]
                                    ['text'],
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8.0,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: 0.0, maxHeight: 120),
                                child: Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Text(
                                                'Descrição',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .copyWith(
                                                        color: Colors.black54),
                                              ),
                                            ),
                                            Divider(),
                                            Text(pet.details),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomDivider(text: 'Informações do anunciante'),
                      Container(
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data['ownerDetails'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return UserCardInfo(
                                text: snapshot.data['ownerDetails'][index]
                                    ['text'],
                                icon: snapshot.data['ownerDetails'][index]
                                    ['icon'],
                                image: snapshot.data['ownerDetails'][index]
                                    ['image'],
                                imageN: snapshot.data['ownerDetails'][index]
                                    ['imageN'],
                                color: snapshot.data['ownerDetails'][index]
                                    ['color'],
                                callback: snapshot.data['ownerDetails'][index]
                                    ['callback'],
                                launchIcon: snapshot.data['ownerDetails'][index]
                                    ['launchIcon'],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 140.0),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 18.0,
                  left: kind == 'DONATE'
                      ? 20.0
                      : MediaQuery.of(context).size.width * 0.17,
                  child: ButtonWide(
                    text:
                        kind == 'DONATE' ? 'QUERO ADOTAR' : 'VI ELE AQUI PERTO',
                    color: kind == 'DONATE' ? Colors.red : Colors.green,
                    action: () {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Row(
                          children: [
                            Expanded(
                              child: Text(
                                kind == 'DONATE'
                                    ? 'Você é o 10º interessado no ${pet.name}. Te avisaremos caso o dono aceite seu pedido de adoção!'
                                    : 'Obrigado pela informação! ${snapshot.data['ownerDetails'][0]['text']} será avisado.',
                              ),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 5),
                      ));
                    },
                  ),
                )
              ],
            );
          }),
      floatingActionButton: kind == 'DONATE'
          ? Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                bool isFavorite = favoritesProvider.getFavoritesPETSIDList.contains(pet.id);                
                return FloatingActionButton(
                  onPressed: () async {
                    final user = UserController();
                    final auth =
                        Provider.of<Authentication>(context, listen: false);

                    await user.favorite(auth.firebaseUser.uid, pet.petReference, !isFavorite);

                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(isFavorite
                          ? 'Removido dos favoritos'
                          : 'Adicionado como favorito'),
                    ));

                    favoritesProvider.loadFavoritesReference();
                    favoritesProvider.handleFavorite(pet.id);                    
                  },
                  tooltip: isFavorite ? 'Favorito' : 'Favoritar',
                  backgroundColor: isFavorite ? Colors.white : Colors.red,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                );
              },
            )
          : null,
    );
  }

  Widget showImages(Map photos) {
    return Stack(
      children: [
        Container(
          color: Colors.blueGrey[50],
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          child: PageView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: photos.values.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                photos.values.elementAt(index),
                fit: BoxFit.fill,
                loadingBuilder: loadingImage,
              );
            },
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: DotsIndicator(
              controller: _pageController,
              itemCount: photos.values.length,
              onPageSelected: (int page) {
                _pageController.animateToPage(
                  page,
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.ease,
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget loadingImage(
      BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Carregando imagem..'),
          LoadingJumpingLine.circle(),
        ],
      ),
    );
  }
}
