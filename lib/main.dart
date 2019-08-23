import 'package:flutter/material.dart';
import 'field.dart';
import 'lamp.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Electrician(),
    );
  }
}

class Electrician extends StatefulWidget {
   @override
  _ElectricianState createState() => _ElectricianState();
}

class _ElectricianState extends State<Electrician> {
  final List<Color> _colors = [
    Color(0xFFFFFCB5),
    Color(0xFFFFF716),
    Color(0xFFFFD900),
    Color(0xFFFFAC01),
    Color(0xFFF7680C),
    Color(0xFFED0200)];
  List<double> _resistance;
  List<Color> _indication;
  List<bool> _accepted;
  bool _on = false;
  bool _done = false;

  @override
  initState() {
    super.initState();
    _resistance = List.generate(6, (_) => 1);
    _indication = List.generate(6, (_) => Colors.white24);
    _accepted = List.generate(6, (_) => false);
  }

  Widget _lamp(String resistance, double size, Color color){
    return Draggable(
      data: resistance,
      child: CustomPaint(
        size: Size.square(size),
        painter: Lamp(resistance, color),
      ),
      feedback: CustomPaint(
        size: Size.square(size),
        painter: Lamp(resistance, color),
      ),
      childWhenDragging: CustomPaint(
        size: Size.square(size),
        painter: Lamp(resistance, color),
      ),
    );
  }

  _try() async{
    for(bool item in _accepted){if(!item) return;}
    Map<int, double> powerMap = Map();
    List<double> power = List(6);
    int counter = 0;
    double r15 = _resistance[1]*_resistance[5]/(_resistance[1]+_resistance[5]);
    double r215 = _resistance[2]+r15;
    double r04 = _resistance[0]+_resistance[4];
    double r = _resistance[3]+r04*r215/(r04+r215);
    double cur = 200/r;
    double cur04 = cur*r215/(r215+r04);
    double cur215 = cur-cur04;
    double cur1 = cur215*_resistance[5]/(_resistance[1]+_resistance[5]);
    double cur5 = cur215-cur1;
    power[0] = _resistance[0]*cur04*cur04*100/(40000/_resistance[0]);
    power[4] = _resistance[4]*cur04*cur04*100/(40000/_resistance[4]);
    power[3] = _resistance[3]*cur*cur*100/(40000/_resistance[3]);
    power[2] = _resistance[2]*cur215*cur215*100/(40000/_resistance[2]);
    power[1] = _resistance[1]*cur1*cur1*100/(40000/_resistance[1]);
    power[5] = _resistance[5]*cur5*cur5*100/(40000/_resistance[5]);
    for(int i=0; i<6; i++) {
      power[i] = double.parse(power[i].toStringAsFixed(2));
      powerMap[i] = power[i];
    }
    List<int> sortedKeys = powerMap.keys.toList(growable:false)..sort((k1, k2) => powerMap[k1].compareTo(powerMap[k2]));
    _indication[sortedKeys[0]] = _colors[0];
    for(int i=0; i<5; i++){
      if(power[sortedKeys[i]] != power[sortedKeys[i+1]]) counter++;
      _indication[sortedKeys[i+1]] = _colors[counter];
    }
    _on = !_on;
    _done = false;
    if(_on && counter==0) _done = true;
    if(!_on) _indication = List.generate(6, (_) => Colors.white24);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width*2/11;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFFDED6C3),Color(0xFFCCC4AD)]
          )
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'find the right combination when all the lamps have the same glow',
                    style: TextStyle(color: Color(0xFF3D3835), fontSize: 22.0, fontFamily: 'FjallaOne-Regular'),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: size*6,
                  child: Stack(
                    children: <Widget>[
                      CustomPaint(
                        size: Size.infinite,
                        painter: Field(),
                      ),
                      Positioned(
                        left: size,
                        child: Column(
                          children: List.generate(6, (index){
                            return DragTarget(
                              key: UniqueKey(),
                              builder: (context, List<String> candidateData, rejectedData) {
                                return SizedBox.fromSize(
                                  size: Size.square(size),
                                  child: !_accepted[index] ? Container() : GestureDetector(
                                    onTap: (){
                                      if(_on) return;
                                      _accepted[index] = false;
                                      _resistance[index] = 1;
                                      _indication[index] = Colors.white24;
                                      setState(() {});
                                    },
                                    child: CustomPaint(
                                        key: UniqueKey(),
                                        size: Size.square(size),
                                        painter: Lamp(_resistance[index].toString(), _indication[index])
                                    )
                                  )
                                );
                              }, onWillAccept: (data) {
                                return true;
                              }, onAccept: (data) {
                                if(_on) return;
                                _resistance[index] = double.parse(data);
                                _accepted[index] = true;
                                setState(() {});
                            },);
                          }),
                        )
                      ),
                      Positioned(
                        top: 2*size+size/2,
                        left: 3*size,
                        child: GestureDetector(
                          onTap: (){_try();},
                          child: SizedBox(
                            width: size*3/2,
                            height: 3*size,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.flash_on, color: _on ? Colors.red[800] : Colors.white54, size: 100),
                                Text('200V', style: TextStyle(color: Colors.black54, fontSize: 22, fontFamily: 'FjallaOne-Regular')),
                                Text('TRY', style: TextStyle(color: Colors.black54, fontSize: 32, fontFamily: 'FjallaOne-Regular'))
                              ],
                            ),
                          ),
                        )
                      ),
                      Positioned(
                        top: 2*size,
                        left: 3*size,
                        child: Text(
                          _done ? 'DONE!' : '',
                          style: TextStyle(color: Colors.green[900], fontSize: 32, fontFamily: 'FjallaOne-Regular'),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _lamp('1600.0', size, Colors.white24),
                    _lamp('800.0', size, Colors.white24),
                    _lamp('400.0', size, Colors.white24),
                    _lamp('266.67', size, Colors.white24),
                  ],
                )
              ],
            )
          )
        ),
      ),
    );
  }
}