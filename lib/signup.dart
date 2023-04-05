
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'forget.dart';
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
class SignupScreen extends StatefulWidget{
  const SignupScreen({Key ? key}) : super (key:key);

  @override
  _SignupScreenState createState()=> _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>{
  var nameController = TextEditingController();
  static const String KEYNAME = "name";
  var nameValue = "No Value Saved";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }
  bool isChecked=false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async

  {
    var response = await http.post(
          Uri.parse('https://reqres.in/api/login'),
          body: ({
            'email' : emailController.text,
            'password' : passwordController.text,
          })
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const forget()));

      }
      else {
        print('failed');
      }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Checkbox(
                checkColor: Colors.white,
                //fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {

                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
                  TextButton(
                    child: const Text(
                      'remember me?',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () async {

                    var name = nameController.text.toString();
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString(KEYNAME, nameController.text.toString());

                  },

                      //signup screen

                  ),

                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text('Login'),),
                  ),
                ],
              ),
            )
          ],

        ),
      ),

    );

  }


    void getValue() async {
      var prefs = await SharedPreferences.getInstance();
      var getName = prefs.getString(KEYNAME);

      nameValue = getName != null ? getName : "";
      if (isChecked == true){
        setState(() {

        }

        );
    }


  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   var nameController = TextEditingController();
//   static const String KEYNAME = "name";
//   var nameValue = "No Value Saved";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getValue();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("shared pref"),
//         ),
//         body: Container(
//           child: Center(
//
//             child:SizedBox(
//               width: 200,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                       label:Text('Name'),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(21)
//                       )
//                   ),
//                 ),
//                   SizedBox(
//                     height: 11,
//                   ),
//                   ElevatedButton(onPressed: () async {
//                     var name = nameController.text.toString();
//                     var prefs = await SharedPreferences.getInstance();
//                     prefs.setString(KEYNAME, nameController.text.toString());
//
//                   },
//                       child: Text('Save')),
//                   SizedBox(height: 11),
//                   Text(nameValue)
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }
//
//   void getValue() async {
//     var prefs = await SharedPreferences.getInstance();
//     var getName = prefs .getString(KEYNAME);
//     nameValue = getName!=null ? getName : "No Value saved";
//     setState(() {
//
//     });
//
//   }
// }


// );

