import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/Risque.dart';
import 'package:CTAMA/screens/Saved_Parcelle.dart';
import 'package:CTAMA/screens/parcelle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;


List<dynamic> answers = [null,null,null,null,null,null,""];

final GlobalKey<FormState> formkey = GlobalKey<FormState>();


class FlightsStepper extends StatefulWidget {
  
  // TextEditingController radio = TextEditingController();
  // int _radioValue = 0;
  // void handleRadioValueChange(int value) {
  //   setState(() {
  //     _radioValue = value;

  //     switch (_radioValue) {
  //       case 0:
  //         break;
  //       case 1:
  //         break;
  //       case 2:
  //         break;
  //     }
  //   });
  // }
  @override
  _FlightsStepperState createState() => _FlightsStepperState();
}

class _FlightsStepperState extends State<FlightsStepper> {
  
  int pageNumber = 0;

//  void  toNextPage() {
//   if (pageNumber < pageList.length)
//   pageNumber++;
// }
//  void toPreviousPage() {
//   if (pageNumber >= 0)
//   pageNumber--;
// }
  
  void goToNext(int page){

    setState(() {
      pageNumber = page;
    });

  }

  void gotoPrevious(int page){

    setState(() {
      pageNumber = page;
    });

  }


  List<Widget> get pageList => [  
    
    Page(
      key: Key('page1'),
      onOptionSelected: () => goToNext(1),
      question: 'Travaillez-vous seul ?',
      answers: <String>['Oui','Non'],
      number: 1,
    ),

    Page(
      key: Key('page2'),
      onOptionSelected: () =>  goToNext(2),
      question: 'Utilisez-vous des chiens pour vos activités de garde ?',
      answers: <String>['Oui','Non'],
      number: 2,
    ),
    Page(
      key: Key('page3'),
      onOptionSelected: () =>  goToNext(3),
      question: 'Avez-vous déjà eu une assurance pour votre activite indépendante actuelle au cours des 5 dernières années ?',
      answers: <String>['Oui','Non'],
      number: 3,
    ),
    Page(
      key: Key('page4'),
      onOptionSelected: () =>  goToNext(4),
      question: 'Avez-vous subi des dommages au cours des 5 dernières années ?',
      answers: <String>['Oui','Non'],
      number: 4,
    ),
    Page(
      key: Key('page5'),
      onOptionSelected: () =>  goToNext(5),
      question: "Utilisez-vous des substances dangereuses pour l'environnement comme peintures, vernis, produits de nettoyages et carburants: essence ou mazout .si vous avez des petites quantités (jusqu'à 50 litres) vous pouvez répondre par non ?",
      answers: <String>['Oui','Non'],
      number: 5,
    ),
    Page(
      key: Key('page6'),
      onOptionSelected: ()=> goToNext(6),
      question: "Avez-vous des machines de travail et tracteurs pour travaux sous contrat et location ?",
      answers: <String>['Oui','Non'],
      number: 6,
    ),
    Page(
       key: Key('page7'),
      answers: ["a","b","c"],
       question: "qu'est ce que vous produisez ?",
       number: 7,
     ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:double.infinity ,
        height: double.infinity,
        decoration: backgroundDecoration,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ArrowIcons(
                onUpTaped: ()=> pageNumber==0 ? "":gotoPrevious(pageNumber-1),
                onDownTaped: ()=> pageNumber==6 ? "":gotoPrevious(pageNumber+1),
              ),
              Sonbla(),
              Line(),
              Positioned.fill(
                left: 32.0 + 8,
                child: AnimatedSwitcher(
                  child: pageList[pageNumber],
                  duration: Duration(milliseconds: 250),
                ), 
              ),
            ],
          ),
          ),
        ),
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 32 +8,
      top: 40,
      bottom: 0,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.5)),
      );
  }
}

class Page extends StatefulWidget {

  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  const Page({Key key,
      @required this.onOptionSelected,
      @required this.number,
      @required this.question,
      @required this.answers})
      : super(key: key);


  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin{
  
  List<GlobalKey<_ItemFaderState>> keys;
  int selectedOptionKeyIndex;
  AnimationController _animationController;

  @override
  void initState(){
    super.initState();
    keys =  widget.answers.length !=null ?List.generate(
      2 + widget.answers.length,
      (_) => GlobalKey<_ItemFaderState>(),
    ):[];
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    onInit();
  }

  Future<void> animateDot(Offset startOffset) async {
    OverlayEntry entry = OverlayEntry(
      builder:(context){
        double minTop = MediaQuery.of(context).padding.top + 52;
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) { 
            return Positioned(
              left: 26.0 + 32 +8,
              top: minTop + (startOffset.dy - minTop) * (1 - _animationController.value),
              child: child,
              );
          },
          child: Dot(),
          );
      },
      );

      Overlay.of(context).insert(entry);
    await _animationController.forward(from: 0);
    entry.remove();

  }

    @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 32),
        ItemFader(key: keys[0],child: StepNumber(number: widget.number)),
        ItemFader(key: keys[1],child: StepQuestion(question: widget.question),
        ),
        Spacer(),
       if (widget.answers.length==2)... widget.answers.map((String answer){
          int answerIndex = widget.answers.indexOf(answer);
          int keyIndex = answerIndex + 2;
          return ItemFader(          
              key: keys[keyIndex],
              child: OptionItem(
                color: answers[widget.number-1]==null ? 
                Colors.white: answers[widget.number-1]==true && keyIndex==2 ?
                Colors.green: answers[widget.number-1]==false && keyIndex==3 ?
                Colors.green:Colors.white,
                name: answer,
                onTap: (offset) => onTap(keyIndex, offset),
                showDot: selectedOptionKeyIndex != keyIndex,
              ),
              );
        })else Padding(
          padding: const EdgeInsets.only(left: 26.0 + 32 +8,),
          child: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: Row(
            children: [
              SizedBox(
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    initialValue: answers[6],
                    validator: (string){
                      if (string.length<=5){
                        return "Enter une valide reponse!";
                      }
                      return null;
                    },
                  onChanged: (prod){
                    answers[widget.number-1]=prod;
                  },
              ),
                ),width: MediaQuery.of(context).size.width*.4,),
              SizedBox(width: 20,),
              MaterialButton(
                onPressed: () async{
                  if (formkey.currentState.validate()){
                     if (answers.any((element) => element==null)){
                     toast.Fluttertoast.showToast(
                      msg: "S'il vous plait répondre a toutes les questions",
                             timeInSecForIosWeb: 3,
                             backgroundColor: Colors.red.withOpacity(0.8),
                      gravity: toast.ToastGravity.TOP
                  );
                   }else{
                     final Risque risque = Risque(
                      ans1: answers[0],
                      ans2: answers[1],
                      ans3: answers[2],
                      ans4: answers[3],
                      ans5: answers[4],
                      ans6: answers[5],
                      ans7: answers[6],
                    );
                      DatabaseService().addRisqueToDb(
                        AuthenticationService().getCurrentUser().uid, risque
                        ).then((value){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (cntx)=>HomePage()), (route) => false);
                    }
                    );
                   }
                  }
                   },
                child: Text("Continue"),
                color: Colors.red,
                )
            ],
          )
          ),
        ),
        SizedBox(height: 64),
      ],
    );
  }



  void onTap(int keyIndex, Offset offset) async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
      if (keys.indexOf(key) == keyIndex) {
        setState((){
          if (keyIndex==2){
            answers[widget.number-1]=true;
          }else{
           answers[widget.number-1]=false;  
          }
          selectedOptionKeyIndex = keyIndex;
        });
        animateDot(offset).then((_) => widget.onOptionSelected());
      }
    }
  }

  void onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState?.show();
    }
  }

}

class StepNumber extends StatelessWidget {
  final int number;

  const StepNumber({Key key, @required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Text(
        '0$number',
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}
 
class StepQuestion extends StatelessWidget {
  final String question;

  const StepQuestion({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Text(
        question,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white,),      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  
  final String name;
  final Color color;
  final void Function(Offset dotOffset) onTap;
  final bool showDot;

  const OptionItem(
          {Key key, @required this.name, @required this.onTap, this.showDot = true, this.color})
          : super(key: key);
  
  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RenderBox object = context.findRenderObject();
        Offset globalPosition = object.localToGlobal(Offset.zero);
        widget.onTap(globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 26),
            Dot(visible:  widget.showDot),
            SizedBox(width: 26),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: widget.color),
              ),
              )
          ],
        ),
        ),
    );
  }
}

class ItemFader extends StatefulWidget {

  final  Widget child;
  const ItemFader({Key key, @required this.child})
  :super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();

}

class _ItemFaderState extends State<ItemFader> 
with SingleTickerProviderStateMixin {

    int position = 1;
    AnimationController _animationController;
    Animation _animation;


    void show() {
      setState(() => position = 1);
      _animationController.forward();
    }

    void hide() {
       setState(() => position = -1);
      _animationController.reverse();
    }

    @override
    void initState() {
      super.initState();
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      );
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      );
    }

    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  
    @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 64 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
            ),
          );
      },
       child: widget.child,
    );
  }
}
class Dot extends StatelessWidget {
  final bool visible;

  const Dot({Key key, this.visible = true}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: visible ? Colors.white : Colors.transparent,
      ),
    );
  }
}

class ArrowIcons extends StatefulWidget {

  final Function onUpTaped;
  final Function onDownTaped;

  const ArrowIcons({Key key, this.onUpTaped, this.onDownTaped}) : super(key: key);
  
  @override
  _ArrowIconsState createState() => _ArrowIconsState();
}

class _ArrowIconsState extends State<ArrowIcons> {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_upward,color: Colors.white,),
            onPressed: widget.onUpTaped,
          ),
            Container(
              decoration:BoxDecoration(
                shape: BoxShape.circle,
                ),
              child: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_downward,color: Colors.white,), 
                onPressed: widget.onDownTaped,
                ),
            ),
        ],
        ),
    );
  }
}

class Sonbla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -41.0 ,
      top: 20,
      child: RotatedBox(
        quarterTurns: 0,
         child: ImageIcon(AssetImage('assets/images/sonbla.png'),
        size: 150,
          ),
        ),
    );
  }
}


const backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(253, 160, 3, 1),
      Color.fromRGBO(30, 58, 229, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);

enum SingingCharacter {ail ,carotte,celeri,celerirave,chou  }
