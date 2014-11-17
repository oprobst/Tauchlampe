/*
 * Grobes Modell der McR27XR by LEDguy
 * 
 */


include <Utils.scad>;
use <CreeXMLT6.scad>;

McR27XR();

module McR27XR (){
  difference (){
    union (){
      translate ([0,0,0]){
        cylinder (h=24.7-15.61, r = 27.43 /2);
        translate ([0,0,-1* (15.61-9.95)]){
          cylinder (h=15.61-9.95, r = 24.13 /2);
          translate ([0,0,-1* (9.95-4.09)]){
            cylinder (h=9.95-4.09, r = 20.62 /2);
            translate ([0,0, -4.09]){
              cylinder (h=4.09, r = 12.45 /2);
            }
          }
        }
      }
    }
    translate ([0,0, -16]){
      cylinder (h=25,  r1 = 4.5,  r2 = 27 /2);
    }
    translate ([0,0, 24.7-15.61 - 1]){
      cylinder (h=5,   r = 27 /2);
    }
  }

}
