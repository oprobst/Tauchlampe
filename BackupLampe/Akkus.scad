/*
 * 28650 Akku Block
 * 
 */


include <Utils.scad>;
 
akkuBlock (28,65);

module akkuBlock (durchmesser, hoehe){
  liFePO4 (durchmesser,hoehe);
  translate ([0,0, hoehe + 2]){
    liFePO4 (durchmesser,hoehe);
  }
}
  

module liFePO4 (durchmesser, hoehe) {
  color ("Blue"){
    cylinder (r = durchmesser /2, h = hoehe); 
  }
  color ("Silver"){
    translate ([0,0,-.1]){
      cylinder (r = durchmesser /2 -2, h = hoehe +.2);
    }   
  }
}
