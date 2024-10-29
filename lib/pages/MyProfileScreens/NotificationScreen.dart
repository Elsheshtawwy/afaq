import 'package:afaq/pages/mainScreens/MyProfile.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool pushNotifications = false;
  bool sound = false;
  bool vibrate = false;
  bool generalNotification = false;
  bool promoDiscount = false;
  bool paymentOptions = false;
  bool appUpdate = false;
  bool newServiceAvailable = false;
  bool newTipsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ProfileOption(
            text: "Push Notifications",
            trailing: Switch(
              value: pushNotifications,
              onChanged: (bool value) {
                setState(() {
                  pushNotifications = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "Sound",
            trailing: Switch(
              value: sound,
              onChanged: (bool value) {
                setState(() {
                  sound = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "Vibrate",
            trailing: Switch(
              value: vibrate,
              onChanged: (bool value) {
                setState(() {
                  vibrate = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "General Notification",
            trailing: Switch(
              value: generalNotification,
              onChanged: (bool value) {
                setState(() {
                  generalNotification = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "Promo & Discount",
            trailing: Switch(
              value: promoDiscount,
              onChanged: (bool value) {
                setState(() {
                  promoDiscount = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "Payment Options",
            trailing: Switch(
              value: paymentOptions,
              onChanged: (bool value) {
                setState(() {
                  paymentOptions = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "App Update",
            trailing: Switch(
              value: appUpdate,
              onChanged: (bool value) {
                setState(() {
                  appUpdate = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "New Service Available",
            trailing: Switch(
              value: newServiceAvailable,
              onChanged: (bool value) {
                setState(() {
                  newServiceAvailable = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ProfileOption(
            text: "New Tips Available",
            trailing: Switch(
              value: newTipsAvailable,
              onChanged: (bool value) {
                setState(() {
                  newTipsAvailable = value;
                });
              },
              activeColor: Colors.teal,
              inactiveThumbColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
