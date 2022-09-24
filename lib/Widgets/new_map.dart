import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tiutiu/core/constants/app_colors.dart';

class NewMap extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> with SingleTickerProviderStateMixin {
  // Location? locationProvider;

  @override
  void didChangeDependencies() {
    // locationProvider = Provider.of<Location>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
          'Tem que arrumar um meio de selecionar local no mapa... antes era place picker'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CardTextLocation extends StatelessWidget {
  CardTextLocation(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
