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
http://www.leds.de/High-Power-LEDs/Cree-High-Power-LEDs/Cree-XP-G2-R5-weiss-139lm-mit-Platine-Star.html

Reflektor:
McR-27-XR-mm
Maße: http://dmcleish.com/CPF/reflectors/McR-27-XR-mm.pdf
http://theledguy.chainreactionweb.com/index.php?cPath=48_50_64

26650er LiFePo4 e.g. 3.3Ah

Step Down converter:
https://pcb-components.de/led-abwaertswandler-buck-step-down/micro-2800ma-detail.html
23mm (rund) x 7.6mm Höhe


*/
translate ([0,0, 250]){
  frontGlas();
}

translate ([0,0, 220]){
  //McR27XR ();
  EmelyXMoptik();
}


translate ([0,0, 200]){
  ledCreeXpG2 (true);
}

translate ([0,0, 180]){
  buck();
}

translate ([40,0, 0]){
  akkuBlock(26.5,68); //26650er
}

%aussenRohr(15, 12.5, 150);




//Konstruktion der Borsilikascheibe mit Dichtringen
module frontGlas (){

 
  color("LightBlue"){
    cylinder (h = 8, r = 27 / 2);
  } 

  //O-Ringe
  color("Black"){
    //radial aussen 
    translate ([0,0, +5]){
      ring ( 29/2, 27/2, 1.5);
    }

    //axial unten
    translate ([0,0,-10]){
      ring (  27/2, 26/2, 1);  
    } 
  }
}


module buck (){
  color("Blue"){
    translate ([0,0,0]){
      cylinder (h=2, r =  23 /2);
    }
  }
  color("Black"){
    translate ([0,0,2]){
     cube ([6,6,5]);
    } 
    translate ([-3,-2,2]){
     cube ([4,2,3]);
    } 
    translate ([-4,-7,2]){
     cube ([4,5,2]);
    }
  }
}


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
    translate ([0,0,-3.2]){      
      ledCreeXpG2   ();
    }  
  }
}

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
 difference (){ 
   ring (aussenRadius, innenRadius, hoehe);
   cylinder (h=140, r=aussenRadius -1);
 }
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

