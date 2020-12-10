import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tiutiu/Widgets/badge.dart';
import 'package:tiutiu/Widgets/play_store_rating.dart';
import 'package:tiutiu/backend/Controller/user_controller.dart';
import 'package:tiutiu/backend/Model/user_model.dart';
import 'package:tiutiu/providers/auth2.dart';
import 'package:tiutiu/providers/chat_provider.dart';
import 'package:tiutiu/providers/pets_provider.dart';
import 'package:tiutiu/providers/refine_search.dart';
import 'package:tiutiu/providers/user_provider.dart';
import 'package:tiutiu/screen/donate_disappeared_list.dart';
import 'package:tiutiu/utils/routes.dart';

class PetsList extends StatefulWidget {
  PetsList({
    this.petKind = 'Donate',
  });
  final String petKind;

  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> with SingleTickerProviderStateMixin {
  TabController _controller;
  int initialIndex = 0;
  PetsProvider petsProvider;
  ChatProvider chatProvider;
  RefineSearchProvider refineSearchProvider;

  @override
  void didChangeDependencies() {
    petsProvider = Provider.of<PetsProvider>(context);
    chatProvider = Provider.of<ChatProvider>(context);
    refineSearchProvider = Provider.of<RefineSearchProvider>(context);
    petsProvider.loadDisappearedPETS(state: refineSearchProvider.getStateOfResultSearch);
    petsProvider.loadDonatePETS(state: refineSearchProvider.getStateOfResultSearch);
    onPetTypeChange();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = TabController(
      vsync: this,
      length: 2,
      initialIndex: initialIndex,
    );

    super.initState();
  }

  void onPetTypeChange() {
    initialIndex = _controller.index;

    if (widget.petKind == 'Disappeared') {
      petsProvider.changePetKind('Disappeared');
      if (refineSearchProvider.getSearchPetByTypeOnHome && refineSearchProvider.getIsHomeFilteringByDisappeared) {
        refineSearchProvider.changeSearchHomePetTypeInitialValue(refineSearchProvider.getHomePetTypeFilterByDisappeared);
        petsProvider.changePetType(refineSearchProvider.getHomePetTypeFilterByDisappeared);
        petsProvider.changeIsFiltering(true);
      } else {
        refineSearchProvider.changeSearchHomePetTypeInitialValue(refineSearchProvider.getSearchHomePetType.first);
        petsProvider.changeIsFiltering(false);
      }

      petsProvider.loadDisappearedPETS(state: refineSearchProvider.getStateOfResultSearch);
      if (petsProvider.getIsFilteringByBreed || petsProvider.getIsFilteringByName) petsProvider.changeTypingSearchResult(petsProvider.getPetsDisappeared);
    } else {
      petsProvider.changePetKind('Donate');
      if (refineSearchProvider.getSearchPetByTypeOnHome && refineSearchProvider.getIsHomeFilteringByDonate) {
        refineSearchProvider.changeSearchHomePetTypeInitialValue(refineSearchProvider.getHomePetTypeFilterByDonate);
        petsProvider.changePetType(refineSearchProvider.getHomePetTypeFilterByDonate);
        petsProvider.changeIsFiltering(true);
      } else {
        refineSearchProvider.changeSearchHomePetTypeInitialValue(refineSearchProvider.getSearchHomePetType.first);
        petsProvider.changeIsFiltering(false);
      }

      petsProvider.loadDonatePETS(state: refineSearchProvider.getStateOfResultSearch);
      if (petsProvider.getIsFilteringByBreed || petsProvider.getIsFilteringByName) petsProvider.changeTypingSearchResult(petsProvider.getPetsDonate);
    }
  }

  void openSocial() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: RatingUs(),
        );
      },
    );
  }

  int filterOnlyMyChats(AsyncSnapshot<QuerySnapshot> snapshot, String uid) {
    int qtd = 0;
    List<QueryDocumentSnapshot> messagesList = [];
    if (snapshot.data != null) {
      snapshot.data.docs.forEach((element) {
        if (User.fromMap(element.get('firstUser')).id == uid || User.fromMap(element.get('secondUser')).id == uid) messagesList.add(element);
      });

      messagesList.forEach((e) {
        if (e.get('open') != null && !e.get('open') && e.get('lastSender') != uid) {
          qtd++;
        }
      });

      return qtd;
    }
    return qtd;
  }

  @override
  Widget build(BuildContext context) {
    void navigateToAuth() {
      Navigator.pushNamed(context, Routes.AUTH, arguments: true);
    }

    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: Row(
            children: [
              InkWell(
                onTap: openSocial,
                child: Text(
                  'Tiu, tiu',
                  style: GoogleFonts.miltonianTattoo(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.SEARCH_REFINE);
                    },
                    icon: Icon(
                      Icons.settings_input_component_sharp,
                      color: Colors.white,
                    ),
                  ),
                  Consumer<UserProvider>(
                    builder: (_, userProvider, child) => Consumer<Authentication>(
                      builder: (_, auth, child) => auth.firebaseUser == null
                          ? Container()
                          : Stack(
                              children: [
                                IconButton(
                                  onPressed: auth.firebaseUser == null
                                      ? navigateToAuth
                                      : () {
                                          Navigator.pushNamed(context, Routes.CHATLIST);
                                        },
                                  icon: Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: chatProvider.newMessages(),
                                  builder: (context, snapshot) {
                                    int newMessagesQty = filterOnlyMyChats(snapshot, userProvider.uid) ?? 0;
                                    return Positioned(
                                      right: 10,
                                      child: Badge(
                                        color: Colors.red,
                                        text: newMessagesQty,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                    ),
                  ),
                  Consumer<UserProvider>(
                    builder: (_, userProvider, child) => Consumer<Authentication>(
                      builder: (_, auth, child) => auth.firebaseUser == null
                          ? Container()
                          : Stack(
                              children: [
                                IconButton(
                                  onPressed: auth.firebaseUser == null
                                      ? navigateToAuth
                                      : () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.NOTIFICATIONS,
                                          );
                                        },
                                  icon: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: UserController().loadNotificationsCount(userProvider.uid),
                                  builder: (context, snapshot) {
                                    return Positioned(
                                      right: 10,
                                      child: Badge(
                                        color: Colors.red,
                                        text: snapshot.data?.docs?.length ?? 0,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // bottom: TabBar(
          //   controller: _controller,
          //   indicatorColor: Colors.purple,
          //   labelColor: Colors.white,
          //   tabs: [
          //     Tab(icon: Icon(Tiutiu.dog), text: 'ADOTAR'),
          //     Tab(icon: Icon(Tiutiu.exclamation), text: 'DESAPARECIDOS'),
          //   ],
          // ),
        ),
        body: Container(
          child: DonateDisappearedList(
            stream: widget.petKind == 'Donate' ? petsProvider.petsDonate : petsProvider.petsDisappeared,
          ),
        )
        //  TabBarView(
        //   controller: _controller,
        //   children: [

        //     DonateDisappearedList(stream: petsProvider.petsDisappeared),
        //   ],
        // ),
        );
  }
}
