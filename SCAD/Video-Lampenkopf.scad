/*
 * UW Video Leuchte
 * 
 * Breiter Fokus mit viel Lichtleistung
 * Möglichst modular aufgebaut.
 *
 */

//ACHTUNG: Das Glas hat eine Toleranz von ± 0.5mm, was eine Berechnung des 
// O-Rings und der dazugehörigen Nut erst ermöglicht, 
// wenn das Teil genau ausgemessen ist.

// Aktueller Raum für Elektronik: 48mm Durchmesser, 40mm Länge...

//Rendering information
$fn=100;

// Variablenblock:

// max. Gesamtradius des Gehäuses
gehaeuseRadius = 44;
auflageRadiusGlas = 30;
glasRadius = 35;
gesamtLaenge = 90;

//M3 DIN 912 Innensechskantschrauben
kernlochM3 = 1.25;
durchfuehrungM3 = 1.6;
schraubenkopfM3 = 2.85;
schraubenkopfM3hoehe = 3.0;

//Axiale O-Ringe fuer Scheibe (ID = 60mm, Dicke = 2.5mm)
oRingRadiusInnen = 30.0;
oRingRadiusAussen = oRingRadiusInnen + 2.5;
oRingNutbreite = 3.4;
oRingNutTiefe = 1.9; //(± 0,06)
oRingNutAussenRadius = gehaeuseRadius - 4 -durchfuehrungM3 - schraubenkopfM3 - kernlochM3;
oRingNutInnenRadius = oRingNutAussenRadius - oRingNutbreite ;

kernlochKabelverschraubung = 7;

echo ("O-Ring Nut Maße: ID= ", oRingNutInnenRadius * 2, " AD=", oRingNutAussenRadius *2);



//Konstruktion der Hauptkomponenten:

//Die Deckelscheibe hält das Glas in der Fassung.
translate ([0, 0, 230]){
  deckelscheibe(auflageRadiusGlas, gehaeuseRadius, 6);
}


//Glasscheibe mit Dichtringen
translate ([0, 0, 200]){  
  frontGlas (oRingRadiusInnen, oRingRadiusAussen);
}

//Linse vor LED
translate ([0, 0, 160]){
  rotate ([0,0,25]){
    linse ();
  }
}

//LED
translate ([0,0,140]){  
  rotate ([0,0,25]){
    led (); 
  }
}

//LED Trägerplatte mit Kernlochbohrungen für LED Modul
difference (){
  //LED carrier
  translate ([0,0,130]){
    ledCarrier(30, 5);
  }

  // Bohrungen für LED
  rotate ([0,0,25]){
    for (i=  [[17,17,130-1],
             [-17,17,130-1],
             [17,-17,130-1],
             [-17,-17, 130-1]]){
      translate (i){
        cylinder (h = 11, r = 1.25);
      }
    }
  }
}

korpus (gehaeuseRadius, glasRadius, 30);



//Konstruktion der Deckelscheibe.
// Diese klemmt die Borsilika Scheibe mit zwei O-Ringen.
// Sie wird mit 8 Schrauben auf dem Gehäuse befestigt.
module deckelscheibe (innenRadius, aussenRadius, hoehe){
  difference(){
    cylinder (h = hoehe, r = aussenRadius); 
    translate ([0, 0, -0.1]){
      cylinder (h = hoehe + 0.2, r = innenRadius);
    }

    // M3 Durchführung, 1mm vom Rand entfernt
    translate ([0, 0, -0.1]){
      bohrungenAufRadius (aussenRadius - 2 - schraubenkopfM3, durchfuehrungM3, 8 , hoehe + 0.2); 
    }
    // Senkung für M3, DIN 912, Innensechskant Schraubenköpfe
    translate ([0, 0, hoehe-schraubenkopfM3hoehe]){
      bohrungenAufRadius (aussenRadius - 2 - schraubenkopfM3, 
                          schraubenkopfM3, 8 , 
                          schraubenkopfM3hoehe + 0.1);
    }

    //Nut für O-Ring  
    translate ([0, 0, -1.0]){  
      // 2 mm vom Kernloch der Verschraubung entfernt:
      ring (oRingNutAussenRadius, 
            oRingNutInnenRadius, 
            oRingNutTiefe);  //  + 1.0 O-Ring klemmt nur und dichtet hier nicht.
    }
  }
}



//Konstruktion der Borsilikascheibe mit Dichtringen
module frontGlas (dichtringID, dichtringAD){

  // Borsilika Glas
  // ø: 70 (± 0.5) x 12 (± 0.5)
 
  color("LightBlue"){
    cylinder (h = 12, r = glasRadius);
  } 

  //O-Ringe
  color("Black"){
    //axial oben (nicht dichtend)
    translate ([0,0, 20]){
      ring ( dichtringAD, dichtringID, dichtringAD-dichtringID);
    }

    //axial unten
    translate ([0,0,-10]){
      ring ( dichtringAD, dichtringID,  dichtringAD-dichtringID);  
    } 
  }
}

 
// Linse für LED
module linse (){
  color("LightSteelBlue"){
    difference (){ 
      sphere (22.0);
      translate ([-25,-25,-23.0]){
       cube ([50,50,23]);
      }
    }
    translate ([-0,-0, -8]){
      cylinder(r=25,h=8);       
    }
  }
}


// Die LED die aufgeschraubt wird
module led(){
  
  color("SlateGray"){
    difference (){ 
      cylinder (h = 1.42, r = 28);
      translate ([-20,20,-1.0]){
        cube ( [40, 20, 2.43]);
      }
      translate ([-20,-40,-1]){
        cube ( [40, 20, 3.43]);
      }
     
      for (i=[[17,17,-1],
             [-17,17,-1],
             [17,-17,-1],
             [ -17,-17, -1]]){
        translate (i){
          cylinder (h = 2.430, r= 1.75);
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
        for (i=[[0,40,-1],
                [40,0,-1],
                [0,0,-1],
                [40  ,40 ,-1]]){
          translate (i){                   
            cylinder (h = 3.895, r= 10);
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


//Auf diesen Träger wird die LED geschraubt
module ledCarrier(aussenRadius, hoehe){
  
  difference (){
    
    cylinder (h = hoehe, r = aussenRadius);     
    
     // M3 Durchführung, 1mm vom Rand entfernt
    translate ([0, 0, -0.1]){
      bohrungenAufRadius (aussenRadius - 1 - schraubenkopfM3, durchfuehrungM3 , 8 , hoehe + 0.2); 
    }
    // Senkung für M3, DIN 912, Innensechskant Schraubenköpfe
    translate ([0, 0, hoehe-schraubenkopfM3hoehe]){
      bohrungenAufRadius (aussenRadius - 1 - schraubenkopfM3, 
                          schraubenkopfM3, 8 , 
                          schraubenkopfM3hoehe + 0.1);
    }
  }
}

//Der Hauptlampenkörper 
module korpus(aussenRadius, glasAufnahmeRadius, ledAufnahmeRadius){  

  difference(){
    cylinder (h = gesamtLaenge, r = aussenRadius);  
    
    // === Innen

    //Glasaufnahme
    translate ([0, 0, gesamtLaenge - 12]){    
      cylinder (h = gesamtLaenge, r =  glasAufnahmeRadius + 0.25); 
    }

    //Bohrungen für Glasplattenhalter
    translate ([0, 0, gesamtLaenge - 20]){
      bohrungenAufRadius (aussenRadius - 2 - schraubenkopfM3, kernlochM3, 8 ,gesamtLaenge ); 
    }
 
    //Nut für O-Ring  
    translate ([0, 0, gesamtLaenge - 12 - oRingNutTiefe]){  
      // 2 mm vom Kernloch der Verschraubung entfernt:
      ring (oRingNutAussenRadius, 
            oRingNutInnenRadius, 
            oRingNutTiefe + 1.0);
    }

    //LED Träger Aufnahme
    translate ([0, 0, gesamtLaenge - 12 - 35]){ //= -glas - ledcarrier
      cylinder (h = gesamtLaenge, r = ledAufnahmeRadius + 0.25); 
    }

    //Kernlochbohrungen für Trägeraufnahme M3
    translate ([0, 0, gesamtLaenge - 12 - 35 - 20]){    
      bohrungenAufRadius (ledAufnahmeRadius - 1 - schraubenkopfM3, kernlochM3, 8 , 150); 
    }

    //Raum elektronik
    translate ([0, 0, 3]){    
      cylinder (h = gesamtLaenge, r = 24); 
    }

    //Kabelverschraubung
    translate ([0,0,-.05]){
       cylinder (h = 6.1, r = kernlochKabelverschraubung); 
    }

    // === Außen
    
    // Aufnahme für Goodman Befestigung
    translate ([0, 0, gesamtLaenge - 30]){        
      ring (aussenRadius + 3.00, 
            aussenRadius - 1.0, 
            10.0);
    }

    // Kühlrippen
    for (i=[22:4:gesamtLaenge - 34]){
      translate ([0, 0, i]){     
        ring (aussenRadius + 3.00, 
              ledAufnahmeRadius + 3.0, 
              2.5);
      }
    }
    translate ([0, 0, 10]){     
      ring (aussenRadius + 3.00, 
            ledAufnahmeRadius + 11, //rippenlänge = 8mm 
            45);
    }
 
   
    translate ([0, 0, -1]){   
      ring (aussenRadius + 3.0,  27, 20); 
    } 
  }

  //Leichte erhöhung für Gewinde der Kabelverschraubung
  difference(){
    
    cylinder (h = 6, r = kernlochKabelverschraubung *1.6); 
    
    //Gewinde für M16 x 1,5 Verschraubung
    translate ([0,0,-.05]){
      cylinder (h = 6.1, r = kernlochKabelverschraubung);  
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


// Ein einfacher Ring
module ring(aussenRadius, innenRadius, hoehe) {
    difference() {
        cylinder(r = aussenRadius, h = hoehe);
        translate([ 0, 0, -1 ]) cylinder(r = innenRadius, h = hoehe+2);
    }
}
