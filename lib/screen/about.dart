import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tiutiu/Widgets/background.dart';
import 'package:tiutiu/Widgets/play_store_rating.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Sobre Tiu, tiu'.toUpperCase(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Background(),
            ListView(
              children: [
                AutoSizeText(
                  '   Não somos uma ONG!',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                        letterSpacing: 2,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 10),
                AutoSizeText(
                  '   TiuTiu é um aplicativo de celular que tem a idéia de estabelecer vínculo entre pessoas que amam e querem adotar animais que estejam abandonados, em situação de rua ou ainda porque seus atuais donos não podem mais ficar com o PET por motivos diversos.',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                        color: Colors.black45,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 10),
                AutoSizeText(
                  '   Ele é fácil de utilizar, tem interface bem intuitiva e qualquer pessoa de qualquer idade pode manusear sem necessidade de tutoriais complexos.',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                        color: Colors.black45,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 10),
                AutoSizeText(
                  '   Por ser sem fins lucrativos, o app é gratuito e apenas está disponível para dispositivos android. Para fazer esta boa idéia ficar disponível para dispositivos iOS, entre em contato através de nossas redes sociais e faça uma contribuição.',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                        color: Colors.black45,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 10),
                RatingUs()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
