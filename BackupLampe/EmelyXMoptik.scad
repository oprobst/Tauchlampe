/*
 * Grobes Modell der Lendil Emely XM Optik.
 * 
 */


include <Utils.scad>;
use <CreeXMLT6.scad>;

EmelyXMoptik();

module EmelyXMoptik(){
  difference (){
    union(){
      color("LightSteelBlue"){
      
        translate ([0,0, 0]){
          cylinder (h= 10.85, r2 = 26 /2, r1=6);
        }
        translate ([0,0,-4]){      
          cylinder (h= 4.0, r = 26 /2);
        }
      }
    }
    translate ([0,0,-3.5]){      
      ledCreeXMLT6 (false);
    }  
  }
}