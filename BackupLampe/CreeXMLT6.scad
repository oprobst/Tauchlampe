/*
 * Grobes Modell der Cree XM-L T6 Power LED
 * 
 */


include <Utils.scad>; 

ledCreeXMLT6(true);



module ledCreeXMLT6 (withStar){
   
  color("LightSteelBlue"){
    difference (){ 
     sphere (2.29);
      translate ([-5,-5,-5]){
       cube ([10,10,5]);
      }
    }
    translate ([-5/2,-5/2,-.73]){
      cube ([5,5,.73]);     
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