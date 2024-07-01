import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/state/app_states.dart';
import 'package:klearn/shared/styles/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/data/cache_helper.dart';
import '../shared/data/constants.dart';

class ProfileScreen extends StatelessWidget {
  const  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          final String _url =
              "https://www.termsfeed.com/live/e87ed723-3c4c-4479-b31c-70f11671bc5d";

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16,),
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Iconsax.user, color: AppStyles.primaryColor, size: 42,),
                    backgroundColor: Colors.grey.withOpacity(0.15),
                  ),
                  SizedBox(height: 6,),
                  Text("Islem Belhadef", style: AppStyles.headingTextStyle(),),
                  SizedBox(height: 18,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      Icon leadingIcon;
                      String title;
                      VoidCallback onTap;

                      switch (index) {
                        case 0:
                          leadingIcon = Icon(Iconsax.user);
                          title = "Profile";
                          onTap = () {
                            navigateTo(context, ProfileScreen());
                          };
                          break;
                        case 1:
                          leadingIcon = Icon(Iconsax.refresh);
                          title = "Historique";
                          onTap = () {
                            navigateTo(context, ProfileScreen());
                          };
                          break;
                        case 2:
                          leadingIcon = Icon(Iconsax.call);
                          title = "Contactez-nous";
                          onTap = () {
                            _showContactDialog(context);
                          };
                          break;
                          // case 3:
                          //   leadingIcon = Icon(Iconsax.star);
                          //   title = 'Evaluer cette application';
                          //   onTap = () {
                          //     showToast(
                          //         color: Colors.red,
                          //         message: 'Application n\'est pas encore en Playstore');
                          //   };
                          break;
                        case 3:
                          leadingIcon = Icon(Iconsax.information);
                          title = "A propos de nous";
                          onTap = () {
                            _showInfoDialog(context);
                          };
                          break;
                        case 4:
                          leadingIcon = Icon(Iconsax.judge);
                          title = "Contrat de license";
                          onTap = () {
                            _launchUrl(_url);
                          };
                          break;
                        case 5:
                          leadingIcon = Icon(Iconsax.global);
                          title = "Langues";
                          onTap = () {
                            _showLanguageDialog(cubit, context);
                          };
                          break;
                        case 6:
                          leadingIcon = Icon(Iconsax.logout, color: Colors.red);
                          title = "Se déconnecter";
                          onTap = () {
                            _showConfirmationDialog(context, cubit);
                          };
                          break;
                        case 7:
                          leadingIcon =
                              Icon(Iconsax.user_remove, color: Colors.red);
                          title = "Supprimer mes informations";
                          onTap = () {
                            _showDeleteAccountDialog(context, cubit);
                          };
                          break;
                        default:
                          leadingIcon = Icon(Iconsax.add);
                          title = 'Unknown';
                          onTap = () {}; // Do nothing for unknown
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0x98ECECF2)),
                          child: ListTile(
                            leading: leadingIcon,
                            title:
                            title == "Se déconnecter" ||
                                title ==
                                    "Supprimer mes informations"
                                ? Text(title,
                                style: AppStyles.regularTextStyle(
                                    color: AppStyles.dangerColor))
                                : Text(title,
                                style: AppStyles.regularTextStyle()),
                            onTap: onTap,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {

        },
    );
  }
}

void _showConfirmationDialog(BuildContext context, var cubit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Déconnecter",
          style: AppStyles.headingTextStyle(),
        ),
        content: Text(
          "Etes vous sur que vous voulez déconnecter de votre compte ?",
          style: AppStyles.regularTextStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Annuler",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              cubit.logout(context);
            },
            child: Text("Confirmer",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: AppStyles.dangerColor)),
          )
        ],
      );
    },
  );
}

void _showDeleteAccountDialog(BuildContext context, var cubit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Supprimer mon compte",
          style: AppStyles.headingTextStyle(),
        ),
        content: Text(
          "Etes vous sur que vous voulez supprimer votre compte et tous les informations",
          style: AppStyles.regularTextStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Annuler",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              cubit.deleteAccount(context);
            },
            child: Text("Confirmer",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: AppStyles.dangerColor)),
          )
        ],
      );
    },
  );
}

void _showContactDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Contactez-nous",
          style: AppStyles.headingTextStyle(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact",
              style: AppStyles.regularTextStyle(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Iconsax.call,
                  color: AppStyles.secondaryColor,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '0540 532 845',
                  style: AppStyles.headingTextStyle(
                      color: AppStyles.secondaryColor, fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Iconsax.call,
                  color: AppStyles.secondaryColor,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '0560 060 900',
                  style: AppStyles.headingTextStyle(
                      color: AppStyles.secondaryColor, fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Iconsax.instagram,
                  color: AppStyles.secondaryColor,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    '@mefrouza.pro_service_cnstntine',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.headingTextStyle(
                        color: AppStyles.secondaryColor, fontSize: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Annuler",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: AppStyles.textColor)),
          )
        ],
      );
    },
  );
}

void _showLanguageDialog(var cubit, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Langues",
          style: AppStyles.headingTextStyle(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selectionnez votre langue préférée",
              style: AppStyles.regularTextStyle(),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  cubit.changeLang('fr', context);
                },
                child: Text(
                  'Français',
                  style: AppStyles.regularTextStyle(
                      weight: CacheHelper.getData(key: 'lang') == 'fr'
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
            TextButton(
                onPressed: () {
                  cubit.changeLang('en', context);
                },
                child: Text(
                  'English',
                  style: AppStyles.regularTextStyle(
                      weight: CacheHelper.getData(key: 'lang') == 'en'
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
            TextButton(
                onPressed: () {
                  cubit.changeLang('ar', context);
                },
                child: Text(
                  'العربية',
                  style: AppStyles.regularTextStyle(
                      weight: CacheHelper.getData(key: 'lang') == 'ar'
                          ? FontWeight.bold
                          : FontWeight.normal),
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Annuler",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: AppStyles.textColor)),
          )
        ],
      );
    },
  );
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "A propos de nous",
          style: AppStyles.headingTextStyle(),
        ),
        content: Text(
          "Mefrouza s'engage à résoudre les problèmes et les imprévus de votre quotidien مشاكلكم مفروزين و انتوما مريحين 🛵🗒️🎁🔑",
          style: AppStyles.regularTextStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Annuler",
                style: AppStyles.regularTextStyle(
                    weight: FontWeight.w600, color: AppStyles.textColor)),
          )
        ],
      );
    },
  );
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}