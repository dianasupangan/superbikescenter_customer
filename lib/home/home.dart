import 'package:flutter/material.dart';
import 'package:superbikes/home/components/account_details.dart';
import 'package:superbikes/home/components/card_details.dart';
import 'package:superbikes/home/components/payment_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FractionallySizedBox(
                widthFactor: .3,
                child: Image.asset("assets/images/header.jpg"),
              ),
            ),
            FractionallySizedBox(
              widthFactor: .9,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: CardDetails(),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: .8,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: AccountDetails(),
              ),
            ),
            FractionallySizedBox(
              widthFactor: .78,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
            ),
            FractionallySizedBox(
              widthFactor: .8,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: PaymentDetails(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(Colors.red),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 1)))),
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> LogOut() async {
    Navigator.of(context).pop();
    // print('Fetch');
    // const url =
    //     'https://actsafe-automatedcontacttracing.000webhostapp.com/getUser.php';

    // final uri = Uri.parse(url);
    // HttpOverrides.global = MyHttpOverrides();
    // final response = await http.get(uri);
    // final body = response.body;
    // final json = jsonDecode(body);

    // print(response.statusCode);
    // print(response.body);
  }
}
