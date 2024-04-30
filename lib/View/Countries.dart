import 'package:corona_update/Services/state_services.dart';
import 'package:corona_update/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountiesListScreen extends StatefulWidget {
  const CountiesListScreen({super.key});

  @override
  State<CountiesListScreen> createState() => _CountiesListScreenState();
}

class _CountiesListScreenState extends State<CountiesListScreen> {
  TextEditingController searchContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchContoller,
                onChanged: (value){
                  setState(() {

                  });

                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData){
                      print(snapshot.data);
                       return ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade700,
                              child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                            children: [

                                ListTile(
                            title: Container(height: 10, width: 89,color: Colors.white),
                            subtitle: Container(height: 10, width: 89,color: Colors.white),
                            leading: Container(height: 50, width: 50,color: Colors.white) ),
                            ],
                            ),
                            ),
                            );


                          });

                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];

                          if(searchContoller.text.isEmpty){
                            return Column(
                              children: [

                                InkWell(
                                  onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(

                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCases:snapshot.data![index]['cases'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['test'],
                                  recovered: snapshot.data![index]['recovered'],
                                    critical: snapshot.data![index]['critical'],

                                )));
                                 },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text('Total Cases:   '+snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                        height: 70,
                                        width: 70,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                  ),
                                )
                              ],
                            );

                          }else if(name.toLowerCase().contains(searchContoller.text.toLowerCase())){
                            return Column(
                              children: [

                                InkWell(
                                  onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(

                                image: snapshot.data![index]['countryInfo']['flag'],
                                name: snapshot.data![index]['country'],
                                totalCases:snapshot.data![index]['cases'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['test'],
                                recovered: snapshot.data![index]['recovered'],
                                critical: snapshot.data![index]['critical'],

                              )));
                            },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text('Total Cases:   '+snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                        height: 70,
                                        width: 70,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                  ),
                                )
                              ],
                            );

                          }else{
                            return Container();
                          }


                          });
                    }

                  },
                ),
            ),
          ],
        ),
      ),

    );
  }
}
