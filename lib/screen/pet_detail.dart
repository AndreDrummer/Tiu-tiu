import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:tiutiu/Widgets/dots_indicator.dart';
import 'package:tiutiu/backend/Model/pet_model.dart';

class PetDetails extends StatefulWidget {
  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Pet pet = ModalRoute.of(context).settings.arguments;

    return Scaffold(
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
      body: Stack(
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
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  showImages(pet.photos),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.blueGrey[50],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Anunciante: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${pet.ownerName}",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(height: 45),
                            Row(
                              children: [
                                Text(
                                  'Raça: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${pet.breed}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Tamanho: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${pet.size}",
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Idade: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${pet.ano} anos e  ${pet.meses} meses.",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Saúde: ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${pet.health}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descrição',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Divider(),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(top: 5.0),                          
                          height: 100,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(pet.details, style: TextStyle(letterSpacing: 1.5)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _divider(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Contato:   ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '(62) 9 8115-3518',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'LIGAR',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'MENSAGEM',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider(color: Colors.grey)),
          Text(" ADOTAR ", style: TextStyle(color: Colors.grey)),
          Expanded(child: Divider(color: Colors.grey)),
        ],
      ),
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
