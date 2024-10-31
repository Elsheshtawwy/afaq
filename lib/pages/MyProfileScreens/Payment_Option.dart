import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Payment Options',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Booking Balance'),
            BalanceDisplay(),
            SizedBox(height: 24),
            SectionTitle(title: 'Refill Afaq Cards'),
            Text(
              'You can buy Afaq cards from:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 12),
            PaymentMethodsRow(),
            SizedBox(height: 24),
            CustomTextField(
              labelText: 'Card Number: XXX-XXX-XXX',
            ),
            SizedBox(height: 24),
            PaymentOptionsList(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No balance available');
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        if (!data.containsKey('Balance')) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'Balance': 0.0});
          var balance = data['Balance'];
          return Text(
            '$balance Dinar',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        var balance = data['Balance'];
        return Text(
          '$balance Dinar',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class PaymentMethodsRow extends StatelessWidget {
  const PaymentMethodsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildImage('assets/paymentMethods/methd.png'),
        buildImage('assets/paymentMethods/mobicash.png'),
        buildImage('assets/paymentMethods/sadad.png'),
        buildImage('assets/paymentMethods/sadad.png'),
      ],
    );
  }

  Widget buildImage(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(imageUrl, height: 40),
    );
  }
}

class PaymentOptionsList extends StatelessWidget {
  const PaymentOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        buildPaymentOption('assets/paymentMethods/methd.png', context),
        buildPaymentOption('assets/paymentMethods/mobicash.png', context),
        buildPaymentOption('assets/paymentMethods/sadad.png', context),
      ],
    );
  }

  Widget buildPaymentOption(String imageUrl, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
          Image.asset(imageUrl, height: 40),
        ],
      ),
    );
  }
}
