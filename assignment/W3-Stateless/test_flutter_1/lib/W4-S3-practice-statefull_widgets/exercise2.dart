import 'package:flutter/material.dart';

void main(){
  runApp(
     MaterialApp(
      title: 'Favorite List',
      home: Scaffold(
        appBar: AppBar(
          title: const Center( child: Text('Favorite List')),
        ),
        body: const SingleChildScrollView(
          child:  Column(
            children: [
              ListFavoriteCard(),
              ListFavoriteCard(),
              ListFavoriteCard(),
            ]
      ),
    )
    )
  )
  );
}

class ListFavoriteCard extends StatefulWidget {
  const ListFavoriteCard({super.key});

  @override
  State<ListFavoriteCard> createState() => _ListFavoriteCardState();
}

class _ListFavoriteCardState extends State<ListFavoriteCard> {
  bool _isFav = false;
  void toggleFavorite() {
    setState(() {
      _isFav =!_isFav;
    });
  }
  @override
  void initState() {
    super.initState();
    _isFav = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    border: Border(
      top: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
      bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
    ),
  ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Favorite Card'),
                SizedBox(height: 20,),
                Text('Description: This is a favorite card'),
              ],
            ),
            ),
             IconButton(
            isSelected: _isFav,
            icon: const Icon(Icons.favorite, color: Colors.grey),
            selectedIcon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: toggleFavorite,)
            
          
        ]
        ,)
      )
    );
  }
}