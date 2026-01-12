import 'package:flutter/material.dart';
import 'package:iti_final_project/feature/homenav/explore/searchResult/view.dart';


import '../../../core/resources/app_text_style.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, this.showBackButton = false});
  final bool showBackButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 25,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showBackButton?GestureDetector(
                      onTap: () => Navigator.of(context).pop(context),
                      child: Icon(Icons.arrow_back)):SizedBox.shrink(),
                  SizedBox(width:8 ),
                  SizedBox(
                    width: 320,
                    height: 55,
                    child:TextField(
                      decoration: InputDecoration(
                      fillColor: Color(0xffF8F7F7),
                      filled: true,
                      suffix: Icon(Icons.cancel,color: Colors.grey,),
                      prefixIcon: Icon(Icons.search),
                      hint: Text("Search here",style: AppTextStyle.secondaryStyleAsk,),
                      enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          ),
                          borderRadius: BorderRadius.circular(25)
                      )
                      ),
                      onSubmitted: (value){
                        final q =value.trim();
                        if (q.isEmpty)return;
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SearchResult(query: value)
                            )
                        );
                      },
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}


