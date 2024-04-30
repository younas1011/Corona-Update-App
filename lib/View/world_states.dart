import 'package:corona_update/Model/WorldStateModel.dart';
import 'package:corona_update/Services/state_services.dart';
import 'package:corona_update/View/Countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList =<Color> [
   const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(height:  MediaQuery.of(context).size.height * .01,),

              FutureBuilder(
                  future: statesServices.fecthWorldStateRecords(),
                  builder: (context,AsyncSnapshot<WorldStateModel> snapshot){

                    if(!snapshot.hasData){

                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          )
                      );
                    }else{
                    return Column(
                      children: [

                        PieChart(
                          dataMap: {
                            "Total" : double.parse(snapshot.data!.cases!.toString()),
                            "Recovered" : double.parse(snapshot.data!.recovered.toString()),
                            "Deaths" : double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),

                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          animationDuration: Duration(microseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),

                        SizedBox(height:60,),

                        Card(

                          child: Column(
                            children: [

                              ReuseableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),

                              SizedBox(height: 10,),
                              ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),

                              SizedBox(height: 10,),
                              ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),

                              SizedBox(height: 10,),
                              ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),

                              SizedBox(height: 10,),
                              ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),

                              SizedBox(height: 10,),
                              ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),

                              SizedBox(height: 10,),
                              ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CountiesListScreen() ));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff1aa260),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Set the border radius
                            ),
                            padding: EdgeInsets.all(0),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                             'Track Countires',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),


                        // Container(
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: Color(0xff1aa260),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child:  Center(child: Text("Track Countires"),),
                        // ),

                      ],
                    );
                    }
                  }

              ),



            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;

   ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10, bottom: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(title),
              Text(value),

              // SizedBox(height: 5,),
              // Divider()
            ],
          ),
        ],
      ),
    );
  }
}
