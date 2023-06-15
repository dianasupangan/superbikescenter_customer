import 'package:flutter/material.dart';
import 'package:superbikes/global/logo_header.dart';
import 'package:superbikes/home/components/account_details.dart';
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
      // backgroundColor: Color.fromRGBO(76, 134, 182, 1),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 89, 162, 1),
                Color.fromRGBO(76, 134, 182, 1),
              ],
            ),
          ),
          child: FractionallySizedBox(
            heightFactor: 0.7,
            widthFactor: 0.7,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: const LogoHeader(),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Account Details
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Account Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            color: Colors.blue.shade50,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: AccountDetails(),
                            ),
                          ),
                        ),

                        //Payment Details
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Last Payment Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            color: Colors.blue.shade50,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: PaymentDetails(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 89, 162, 1),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Exit'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> fetchUser() async {
  //   print('Fetch');
  //   const url =
  //       'https://actsafe-automatedcontacttracing.000webhostapp.com/getUser.php';

  //   final uri = Uri.parse(url);
  //   HttpOverrides.global = MyHttpOverrides();
  //   final response = await http.get(uri);
  //   // final body = response.body;
  //   // final json = jsonDecode(body);

  //   // print(response.statusCode);
  //   // print(response.body);
  // }
}
