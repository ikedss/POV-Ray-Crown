#include "colors.inc"
#include "textures.inc"


#declare Radius = 5;
#declare LightX = 0;
#declare LightY = 40;
#declare LightZ = -40;
#declare SRadius = 0;
#declare SFalloff = 11;
//------------------------------------   
light_source {
   <-10, 20, -10> color White

   area_light <1, 1, 0>, <0, 1, 1>, 1, 1
   adaptive 1
   jitter

   // Show what the light source looks like
   looks_like {
      box {
         <-2, 0, -2>, <2, 0.5, 2>
         pigment { White } finish { Luminous }
      }
   }
}
 plane { <0, 2, 0>, -2
    pigment {
      checker color White, color Black
    }
  }

#declare P_R =0.1; #declare P_H =0.75;
#declare Profile =
union{
 sphere  {<0, P_H,0>,P_R }
 cylinder{<0,-P_H,0>,<0,P_H,0>,P_R}
 sphere  {<0,-P_H,0>,P_R }
 texture{
   pigment{color Orange}
   finish {
   ambient 0.1
   diffuse 0.7
   phong 1}}
}  
#declare N_major = 0.5;
#if (clock <= 4)
    #declare N_major = 0.5 + clock;
#else
    #declare N_major = 4.5 - (clock - 4);
#end
#declare Radius_major = 5.00; 
#declare N_minor = 2500;
//------------------------------------
#declare Nr=0;               // começo
#declare EndNr=N_major*N_minor;// fim 
 
camera {
  location <3,5,-10>
  look_at <0,-2,1>
 }

light_source {
    <0,40,-50> color White
}
light_source {
    <0,10,0> color White
    spotlight
    point_at <0, 0, 0>
    tightness 0
    radius SRadius
    falloff SFalloff 
}        

#while (Nr< EndNr)
 object{Profile
         rotate<0,0,Nr*360/N_minor>
        translate<Radius_major,0,0>
         rotate<0,Nr*360/EndNr,0>}
 #declare Nr = Nr + 1; //próximo Nr
#end // --------------- fim do loop--   