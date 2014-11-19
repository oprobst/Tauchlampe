/*
 * Backup Lampe
 *
 * Utility Library
 */
$fn=150;



// Ein einfacher Ring
module ring(aussenRadius, innenRadius, hoehe) {
    difference() {
        cylinder(r = aussenRadius, h = hoehe);
        translate([ 0, 0, -1 ]) cylinder(r = innenRadius, h = hoehe+2);
    }
}


// size is the XY plane size, height in Z
module octagon(size, height) {
  intersection() {
    cube([size, size, height], true);
    rotate([0,0,45]) cube([size, size, height], true);
  }
}

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}


module LEDSternBohrungen (radius, lochRadius, anzahl, tiefe){
  for ( i = [0 : anzahl] ) {
      rotate( i * 360 / anzahl + 1, [0, 0, 1]){
        translate ([radius ,0 , -0.1]){
          cylinder (h = tiefe + 0.1, r = lochRadius);            
        } 
        translate ([radius ,lochRadius * -1, -0.1]){
          cube ([lochRadius*2,lochRadius*2,tiefe]) ;
        }
      }  
    }
}

// Zeichnet eine Reihe von Zylindern auf einem festgelegtem Radius.
// Gut geeignet um auf einem Ring Bohrungen anzubringen.
module bohrungenAufRadius (radius, lochRadius, anzahl, tiefe){
  for ( i = [0 : anzahl] ) {
      rotate( i * 360 / anzahl + 1, [0, 0, 1]){
        translate ([radius ,0 , -0.1]){
          cylinder (h = tiefe + 0.1, r = lochRadius);            
        }     
      }  
    }
}

