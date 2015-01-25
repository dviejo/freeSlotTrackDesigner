/**
 * ninco.scad
 * 
 * Models for Ninco(r) tracks. Visit www.ninco.com
 * For visualization only
 * 
 * Created by Diego Viejo
 * 
 */

nincoTrackHeight = 9; //TODO Check this!
nincoTrackWidth = 180;
nincoStraightLength = 400;

nincoRad1 = 61.37; //radio menor de la curva interior
nincoRad2 = nincoRad1 + nincoTrackWidth; //radio mayor de la curva interior = radio menor curva estandar
nincoRad3 = nincoRad2 + nincoTrackWidth; //radio mayor curva estandar = radio menor curva exterior
nincoRad4 = nincoRad3 + nincoTrackWidth; //radio mayor curva exterior = radio menor curva superexterior
nincoRad5 = nincoRad4 + nincoTrackWidth; //radio mayor curva superexterior

nincoTrack1 = 45;
nincoTrack2 = 90+nincoTrack1;

slotWidth = 3;				//TODO: Check
copperWidth = 4 + 4 + slotWidth;	//TODO Check
slotDepth = 3.5;
$fn=50;


module straight(l=nincoStraightLength)
{
  difference()
  {
    union()
    {
      color("DimGray") cube([l, nincoTrackWidth, nincoTrackHeight]);
      color("Gainsboro")
      {
	translate([0, nincoTrack1 - copperWidth/2, nincoTrackHeight]) cube([l, copperWidth, 0.5]);
	translate([0, nincoTrack2 - copperWidth/2, nincoTrackHeight]) cube([l, copperWidth, 0.5]);
      }
    }
    
    color("DimGray")
    {
      translate([-1, nincoTrack1 - slotWidth/2, nincoTrackHeight-slotDepth]) cube([l+2, slotWidth, slotDepth+0.5+0.1]);
      translate([-1, nincoTrack2 - slotWidth/2, nincoTrackHeight-slotDepth]) cube([l+2, slotWidth, slotDepth+0.5+0.1]);
    }
    
  }
}

module nincoCurve(r1=nincoRad1, r2=nincoRad2, deg = 45, center = true)
{
  aux = center == true? (r2-r1)/2 : 0;
  translate([0, -aux, 0]) difference()
  {
    union()
    {
      color("DimGray")nincoCurvedSlot(r1=r1, r2=r2, d=nincoTrackHeight, center = false, deg=deg);
      
      color("Gainsboro")
      {
	translate([0, nincoTrackWidth-nincoTrack1, nincoTrackHeight]) nincoCurvedSlot(r1 = r1+nincoTrack1-copperWidth/2, r2 = r1+nincoTrack1+copperWidth/2, d=0.5, deg=deg);
	translate([0, nincoTrackWidth-nincoTrack2, nincoTrackHeight]) nincoCurvedSlot(r1 = r1+nincoTrack2-copperWidth/2, r2 = r1+nincoTrack2+copperWidth/2, d=0.5, deg=deg);
      }
    }
    
    color("DimGray")
    {
	translate([0, nincoTrackWidth-nincoTrack1, nincoTrackHeight-slotDepth]) nincoCurvedSlot(r1 = r1+nincoTrack1-slotWidth/2, r2 = r1+nincoTrack1+slotWidth/2, d=slotDepth+0.5+0.1, deg=deg);
	translate([0, nincoTrackWidth-nincoTrack2, nincoTrackHeight-slotDepth]) nincoCurvedSlot(r1 = r1+nincoTrack2-slotWidth/2, r2 = r1+nincoTrack2+slotWidth/2, d=slotDepth+0.5+0.1, deg=deg);
    }
  }
}

module nincoCurvedSlot(r1=nincoRad1-slotWidth/2, r2=nincoRad1+slotWidth/2, d=slotDepth, deg=45, center = true)
{
  aux = center == true? (r2-r1)/2 : 0;
  translate([0, r2-aux, 0]) difference()
  {
    cylinder(r=r2, h=d);
    
    translate([-1, 0, -1]) cube([r2+2, r2+1, d+2]); 
    translate([-1, 0, -1]) rotate(-90+deg) cube([r2+2, r2+1, d+2]); 
    translate([-r2-1, -r2-1, -1]) cube([r2+1, 2*r2+2, d+2]);
    translate([0, 0, -2]) cylinder(r=r1, h=d+4);
  }
}

module nincoStraight() translate([0, -nincoTrackWidth/2, 0]) straight();
module nincoHalfStraight() translate([0, -nincoTrackWidth/2, 0])
  straight(l=nincoStraightLength/2);
module nincoQuarterStraight() translate([0, -nincoTrackWidth/2, 0])
  straight(l=nincoStraightLength/4);

module nincoInterior() nincoCurve();
module nincoHalfInterior() nincoCurve(deg=45/2);
module nincoStandard() nincoCurve(r1=nincoRad2, r2=nincoRad3);
module nincoHalfStandard() nincoCurve(r1=nincoRad2, r2=nincoRad3, deg=45/2);
module nincoExterior() nincoCurve(r1=nincoRad3, r2=nincoRad4, deg=45/2);
module nincoSuperExt() nincoCurve(r1=nincoRad4, r2=nincoRad5, deg=45/2);

nincoStraight();
translate([200, 180, 0]) nincoHalfStraight();
translate([300, 180*2, 0]) nincoQuarterStraight();

translate([405, -180, 0]) nincoSuperExt();
translate([405, 0, 0]) nincoExterior();
translate([405, 180, 0]) nincoStandard();
h2=nincoRad2+(nincoRad3-nincoRad2)/2;
translate([405, 180, 0]) 
  translate([h2*sin(45), h2-h2*cos(45), 0]) //El angulo anterior
    rotate(45) 				 //El angulo anterior
      nincoHalfStandard();
translate([405, 180*2, 0]) nincoInterior();
h=nincoRad1+(nincoRad2-nincoRad1)/2;
translate([405, 180*2, 0]) 
  translate([h*sin(45), h-h*cos(45), 0]) //El angulo anterior
    rotate(45) 				 //El angulo anterior
	nincoHalfInterior();
//nincoCurvedSlot(r1=nincoRad1, r2=nincoRad2, d=nincoTrackHeight, center = false);