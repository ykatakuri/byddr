import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final double topContainerHeight = 190.0;

  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: topContainerHeight,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: topContainerHeight * .58,
                      color: Colors.deepPurple,
                    ),
                    Container(
                      height: topContainerHeight * .42,
                      color: Colors.white,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  child: SizedBox(
                    height: 132,
                    width: 132,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Image.asset("assets/images/user.png",
                            color: Colors.black26),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 160,
                  bottom: 22,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      homeController.logout();
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 215,
                        height: 45,
                        child: const Center(child: Text("Déconnexion"))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.white,
            child: const ListTile(
              leading: Icon(Icons.favorite, color: Colors.amber),
              title: Text('Favoris'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.amber,
                  ),
                  title: Text('Compte'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () async {
                    Fluttertoast.showToast(
                        msg: await homeController.checkLogin().toString());
                  },
                ),
                Divider(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.chat, color: Colors.amber),
                  title: Text('Discussions'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.notification_add, color: Colors.amber),
                  title: Text('Notifications'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.white,
            child: Column(
              children: const [
                ListTile(
                  title: Text('FAQs'),
                ),
                Divider(
                  height: 20,
                ),
                ListTile(
                  title: Text("Conditions d'utilisation"),
                ),
                Divider(
                  height: 20,
                ),
                ListTile(
                  title: Text('Politique de confidentialité'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              "BYDDR APP - 2022",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}
