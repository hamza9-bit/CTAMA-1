class Risque {

 bool ans1;
 bool ans2;
 bool ans3;
 bool ans4;
 bool ans5;
 bool ans6;
 String ans7;

  Risque({
    this.ans1, 
    this.ans2, 
    this.ans3, 
    this.ans4, 
    this.ans5, 
    this.ans6, 
    this.ans7
    });

  Map<String, dynamic> toMap(Risque risque) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["ans1"] = risque.ans1;
    map["ans2"] = risque.ans2;
    map["ans3"] = risque.ans3;
    map["ans4"] = risque.ans4;
    map["ans5"] = risque.ans5;
    map["ans6"] = risque.ans6;
    map["ans7"] = risque.ans7;

    return map;

  }

  Risque.fromMap(Map<String, dynamic> map) {
    
    this.ans1=map["ans1"];
    this.ans2=map["ans2"];
    this.ans3=map["ans3"];
    this.ans4=map["ans4"];
    this.ans5=map["ans5"];
    this.ans6=map["ans6"];
    this.ans7=map["ans7"];
  
  }

}