/*
 * Generic Light Head large
 *
 * Ein generisches Lampengehäuse für Prototypen.
 * Komplett verschraubt und geräumig - dadurch genug
 * Platz um verschiedene Elektroniken und LEDs zu testen.
 *
 */


// Äußerer Gehäuseradius
outerRadius = 44;

//Radius:
kernlochKabelverschraubung = 5.1; //TODO: Welches Gewinde?

//Höhe des Reflektors 
reflektorHoehe = 24;

//Höhe der Dichtringe im gepressten Zustand.
dichtringDurchmesser = 2.4;

//Halter Glasscheibe
translate ([0,0,240]){
  deckelscheibe();
}


// Borsilika Glas
// ø: 70 (± 0,5) x 12 (± 0,5)
translate ([0,0,200]){
  color("LightBlue"){
    cylinder (h = 12, r = 35);
  }
}

//O-Ringe
//ø: 3.0 -> Nuttiefe = 2.3mm (± 0,06), Nutbreite 4mm
translate ([0,0,215]){
  color("Black"){
    ring ( 34, 34 - dichtringDurchmesser, dichtringDurchmesser);
  }
}
translate ([0,0,195]){
  color("Black"){
    ring ( 34, 34 - dichtringDurchmesser, dichtringDurchmesser);
  }
}



//LED
translate ([0,0,160]){  
  rotate ([0,0,25]){
    led (); 
  }
}

//LED Trägerplatte mit Kernlochbohrungen für LED Modul
difference (){
  //LED carrier
  translate ([0,0,150]){
    ledCarrier();
  }

  // Bohrungen für LED
  rotate ([0,0,25]){
    for (i=  [[17,17,150-0.005],
             [-17,17,150-0.005],
             [17,-17,150-0.005],
             [-17,-17, 150-0.005]]){
      translate (i){
        cylinder (h = 10, r = 1.25);
      }
    }
  }
}

mainCorpus();


// Hauptkörper der Lampe
module mainCorpus (){

  difference(){
    union (){
      cylinder (h = 90, r = 30); 
  
      translate ([0,0,70 - reflektorHoehe ] ){
        cylinder (h = reflektorHoehe, r = 35);
      }

      translate ([0,0,70]){
       cylinder (h = 20, r = outerRadius);
      }
  
      //Kühlrippen
      for (i=[0:5:20]){
        translate ([0,0,i + 20]){
          cylinder (h = 2, r = 35);
        }
      }

      for (i=[0:5:20]){
        translate ([0,0,i + 45]){
          cylinder (h = 2, r = outerRadius);
        }
      }

     
    }
    
    // M3 Kernlochbohrungen außen
    for ( i = [0 : 8] ) {
      rotate( i * 360 / 9, [0, 0, 1]){
        translate ([40 ,0 , 75]){
          cylinder (h = 15.05, r = 1.25);           
        }     
      }  
    } 

    //Elektronik
    translate ([0,0,3]){
      cylinder (h = 87.05, r = 25); 
    }

   //Aufnahme LED Träger
    difference (){
      translate ([0,0, 90 - 12 - dichtringDurchmesser *2 - reflektorHoehe]){
        cylinder (h = 87.05, r = 30.2); 
      }
      // M3 Kernlochbohrungen 
      for ( i = [0 : 7] ) {
        rotate( i * 360 / 8, [0, 0, 1]){
          translate ([27,0, 90 - 12 - dichtringDurchmesser *2 - reflektorHoehe -25]){
            cylinder (h = 25.05, r = 1.25);           
          }     
        }  
      } 
    }

   //Aufnahme Frontscheibe
   translate ([0, 0, 90 - 12 - dichtringDurchmesser *2]){
     difference (){        
       cylinder (h = 17.05, r = 35.2); 
       //Nut für O-Ring (Nuttiefe = 2.3mm (± 0,06), Nutbreite 4mm
       translate ([0, 0, -2.35]){
         ring (outerRadius-9  , outerRadius-13 , 2.55);
       }
     }
   }   
   //Kabelverschraubung
   translate ([0,0,-.05]){
      cylinder (h = 6.1, r = kernlochKabelverschraubung); 
   }

  }
 
  //Leichte erhöhung für Gewinde der Kabelverschraubung
  difference(){
    
    cylinder (h = 6, r = kernlochKabelverschraubung *2); 
    
    //Gewinde für M16 x 1,5 Verschraubung
    translate ([0,0,-.05]){
      cylinder (h = 6.1, r = kernlochKabelverschraubung);  
    }

  }
}

//Auf diesen Träger wird die LED geschraubt
// 
module ledCarrier(){
  
  difference (){
    union (){
      cylinder (h = 5, r = 30);

      // Kühlrippen
      translate ([0,0, -5]){
        for (i=[4: 3: 20]){
          difference(){      
            cylinder (h = 5, r = i + 1.5);
            translate ([0, 0, -0.1]){
              cylinder (h = 5.1, r = i);
            }
          }
        }
      }
    }
 
  // M3, DIN 912, Innensechskant 
    for ( i = [0 : 7] ) {
      rotate( i * 360 / 8, [0, 0, 1]){
        translate ([0,26, -.1]){
          cylinder (h = 5.2, r = 1.6);
          translate ([0,0, 1.6]){
            cylinder (h = 3.55, r= 3.0);
          }
        }     
      }  
    }
  }

}


// Die LED die aufgeschraubt wird
module led(){
  
  color("SlateGray"){
    difference (){ 
      cylinder (h = 1.42, r = 28);
      translate ([-20,20,-0.005]){
        cube ( [40, 20, 1.44]);
      }
      translate ([-20,-40,-0.005]){
        cube ( [40, 20, 1.44]);
      }
     
      for (i=[[17,17,-0.01],
             [-17,17,-0.01],
             [17,-17,-0.01],
             [ -17,-17, -0.01]]){
        translate (i){
          cylinder (h = 1.435, r= 1.75);
        }
      }  
          
    }
  }

  color("Gray"){
    difference (){ 
      translate ([-20, -20, 1.42]){
        cube ( [40, 40, 2.86]);
      }
      translate ([-20, -20, 1.41]){
        for (i=[[0,40,-0.005],
                [40,0,-0.005],
                [0,0,-0.005],
                [40  ,40 ,-0.005]]){
          translate (i){                   
            cylinder (h = 2.895, r= 10);
          }
        }
      }
    }
  }
  
  color ("Yellow"){
    translate ([-10.5, -10.5, 1.43]){
      cube ( [21, 21, 2.88]);
    }
  }

}

module deckelscheibe (){
  difference(){
    cylinder (h = 8, r = outerRadius); 
    translate ([0, 0, -0.05]){
     cylinder (h = 8.1, r = outerRadius - 16);
    }
    // M3 Durchführung außen
    for ( i = [0 : 8] ) {
      rotate( i * 360 / 9, [0, 0, 1]){
        translate ([40 ,0 , -0.05]){
          cylinder (h = 8.1, r = 1.6);  
            translate ([0,0, 4.5]){
            cylinder (h = 3.65, r= 3.0);
          }         
        }     
      }  
    }
    //Nut für O-Ring (Nuttiefe = 2.3mm (± 0,06), Nutbreite 4mm
    translate ([0, 0, -0.05]){
      ring (outerRadius-11  , outerRadius-15 , 2.35);
    }
  }
}


module ring(r1, r2, h) {
    difference() {
        cylinder(r = r1, h = h);
        translate([ 0, 0, -1 ]) cylinder(r = r2, h = h+2);
    }
}


