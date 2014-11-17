/*
 * Backup Lampe
 *
 * Klein, praktisch, ausfallsicher
 */
$fn=150;

include <Utils.scad>
use <Frontglas.scad>
use <CreeXMLT6.scad>
use <EmelyXMoptik.scad>
use <Buck.scad>
use <Akkus.scad>
use <Batteriefach.scad>
 
use <LampenkopfGehaeuse.scad>;
 


translate ([0,0, 290]){
  frontGlas();
}

translate ([0,0, 260]){
  //McR27XR ();
  EmelyXMoptik();
}


translate ([0,0, 250]){
  ledCreeXMLT6(true);
}

translate ([0,0, 230]){
  buck();
}

translate ([0,0, 180]){
  LampenkopfGehaeuse ();
}





translate ([40,0, 0]){
  akkuBlock(26.5,68); //26650er
}


batterieFach(35/2, 25/2, 150);



 









