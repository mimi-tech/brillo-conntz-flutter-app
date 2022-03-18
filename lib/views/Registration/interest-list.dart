
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:flutter/material.dart';

class InterestList extends StatefulWidget {
    InterestList({Key? key}) : super(key: key);
  @override
  _InterestListState createState() => _InterestListState();
}

class _InterestListState extends State<InterestList> {
 List<String> interests = <String>["Football","Basketball", "Volley ball","Swimming", "Running"];
  @override
  Widget build(BuildContext context) {
    return  AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 600),
      curve: Curves.decelerate,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kMargin),
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(

          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child:Text('Please Select your interest'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kTextColor,fontWeight: FontWeight.bold),

                ),
              ),

              ListView.builder(
                  itemCount: interests.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return ListTile(
                      onTap: (){
                        //pass the user selected interest to the interest text controller which is set globally
                        setState(() {

                          userInterest.text = interests[index].toString();
                        });
                        Navigator.pop(context);
                      },
                      leading: Text("${index + 1}".toString()),
                      title: Text(interests[index]),
                    );
                  })




            ],
          ),
        ),
      ),
    );
  }




}
