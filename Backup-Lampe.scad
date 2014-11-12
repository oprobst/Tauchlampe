/*
 * Backup Lampe
 *
 * Klein, praktisch, ausfallsicher
 */
$fn=150;

/*
// Materialliste 
Alurohr Aussendurchmesser = 30, Innendurchmesser = 27, länge = XX?
Cree XP-G2 R5, weiß, 521lm
26650er LiFePo4 e.g. 3.3Ah

*/

aussenRohr(15, 14, 150);

akkuBlock(26.5,68); //26650er

translate ([0,0, 140]){
  ledCreeXpG2 (true);
}


module ledCreeXpG2 (withStar){
   
  color("LightSteelBlue"){
    difference (){ 
     sphere (1.53);
      translate ([-5,-5,-3.53]){
       cube ([10,10,3.53]);
      }
    }
    translate ([-3.45/2,-3.45/2,-.83]){
      cube ([3.45,3.45,.83]);     
    }
  }

  if (withStar){
    color("DarkGreen"){
      translate ([0,0,-1.5]){
        difference (){
          octagon(20,1.5);
          rotate ([0,0, 22.5]){
            translate ([0,0,-5]){
              LEDSternBohrungen(9,1.6,8,10);
            }
          }
        } 
      }
    }  
  }  
}

module aussenRohr (aussenRadius, innenRadius, hoehe){ 
 
 %ring (aussenRadius, innenRadius, hoehe);
}


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

