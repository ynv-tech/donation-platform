import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ynv_donation_platform/services/firebase_services.dart';
import 'package:ynv_donation_platform/utils/app_colors.dart';
import 'package:ynv_donation_platform/utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HhomeScreenState();
}

class HhomeScreenState extends State<HomeScreen> {
  late TextEditingController nameCntrl;
  DocumentSnapshot<Map<String, dynamic>>? screenSaverData;

  @override
  void initState() {
    super.initState();
    nameCntrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      screenSaverData = await FirebaseServices.fetchFireStoreDb();
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(AppStrings.donationPlatform),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameCntrl,
              decoration: const InputDecoration(
                hintText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
