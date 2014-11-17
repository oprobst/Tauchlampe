/*
 * Batteriefach
 * 
 */


include <Utils.scad>;
 
batterieFach (70,65,100);

module batterieFach (aussenRadius, innenRadius, hoehe){ 
  difference (){ 
    ring (aussenRadius, innenRadius, hoehe);
   
    //Einfassung Glas
    translate ([0,0,hoehe -10]){
      cylinder (h= 12, r= aussenRadius -2.5);
    } 
    //Nut für radiale Dichtung 
    translate ([0,0,hoehe - 5 - 4.3/2]){  
      cylinder (h = 3.4 ,r= aussenRadius - 1.25);
    }
    // cylinder (h=140, r=aussenRadius -1);
   
  }
  
}
