/*
 * Backup Lampe
 *
 * Klein, praktisch, ausfallsicher
 */

include <Utils.scad>;

frontGlas();
 

//Konstruktion der Glasscheibe mit Dichtringen
module frontGlas (){
 
  color("LightBlue"){
    cylinder (h = 8, r = 30 / 2);
  } 

  //O-Ringe
  color("Black"){
    //radial aussen d=2.0, r=
    translate ([0,0, +5]){
      ring ( 32/2, 30/2, 1.5);
    }

    //axial unten
    translate ([0,0,-10]){
      ring (  29/2, 27/2, 1);  
    } 
  }
}



