/*
 * Gehäuse des Lampenkopfes
 * 
 */


include <Utils.scad>;
 
LampenkopfGehaeuse  ();

hoehe = 40;

module LampenkopfGehaeuse (){ 
 difference (){ 
   ring (34/2, 10, hoehe);
   
   //Einfassung Glas
   translate ([0,0, hoehe -14]){
     cylinder (h= 15, r= 30/2);
   } 

   //Nut für radiale Dichtung 
   translate ([0,0,hoehe - 5 - 4.3/2]){  
     cylinder (h = 3.4 ,r= 16); //TODO O-Ring raussuchen und Nut anpassen
   }

   //Nut für axiale Dichtung 
   translate ([0,0,hoehe - 14 - 3.4]){
    ring (14.5, 13 ,3.5);//TODO O-Ring raussuchen und Nut anpassen
   }

   //Einfassung Optik und StarPlatine
   translate ([0,0,hoehe - 14 - 17]){ //TODO: Exakte höhe Emely + Diode  
     cylinder (h = 30,r= 12); //TODO O-Ring raussuchen und Nut anpassen
   }
    
 }

}
