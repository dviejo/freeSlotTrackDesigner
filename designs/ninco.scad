/**
 * ninco.scad
 * 
 * Models for Ninco(r) tracks. Visit www.ninco.com
 * For visualization only
 * 
 * Created by Diego Viejo
 * 
 */

include <../sizes.conf>
use <trackGenerator.scad>

$fn=50;

copperWidth = 4 + 4 + nincoSlotWidth;	//TODO Check

/*
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
      translate([-1, nincoTrack1 - nincoSlotWidth/2, nincoTrackHeight-nincoSlotDepth]) cube([l+2, nincoSlotWidth, nincoSlotDepth+0.5+0.1]);
      translate([-1, nincoTrack2 - nincoSlotWidth/2, nincoTrackHeight-nincoSlotDepth]) cube([l+2, nincoSlotWidth, nincoSlotDepth+0.5+0.1]);
    }
    
  }
}

module curve(r1=nincoRad1, r2=nincoRad2, deg = 45, center = true)
{
  aux = center == true? (r2-r1)/2 : 0;
  translate([0, -aux, 0]) difference()
  {
    union()
    {
      color("DimGray")curvedSlot(r1=r1, r2=r2, d=nincoTrackHeight, center = false, deg=deg);
      
      color("Gainsboro")
      {
	translate([0, nincoTrackWidth-nincoTrack1, nincoTrackHeight]) curvedSlot(r1 = r1+nincoTrack1-copperWidth/2, r2 = r1+nincoTrack1+copperWidth/2, d=0.5, deg=deg);
	translate([0, nincoTrackWidth-nincoTrack2, nincoTrackHeight]) curvedSlot(r1 = r1+nincoTrack2-copperWidth/2, r2 = r1+nincoTrack2+copperWidth/2, d=0.5, deg=deg);
      }
    }
    
    color("DimGray")
    {
	translate([0, nincoTrackWidth-nincoTrack1, nincoTrackHeight-nincoSlotDepth]) curvedSlot(r1 = r1+nincoTrack1-nincoSlotWidth/2, r2 = r1+nincoTrack1+nincoSlotWidth/2, d=nincoSlotDepth+0.5+0.1, deg=deg);
	translate([0, nincoTrackWidth-nincoTrack2, nincoTrackHeight-nincoSlotDepth]) curvedSlot(r1 = r1+nincoTrack2-nincoSlotWidth/2, r2 = r1+nincoTrack2+nincoSlotWidth/2, d=nincoSlotDepth+0.5+0.1, deg=deg);
    }
  }
}


module curvedSlot(r1=nincoRad1-nincoSlotWidth/2, r2=nincoRad1+nincoSlotWidth/2, d=nincoSlotDepth, deg=45, center = true)
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
*/
module nincoStraight() translate([0, -nincoTrackWidth/2, 0]) 
  straight(copperWidth = 4 + 4 + nincoSlotWidth);
module nincoHalfStraight() translate([0, -nincoTrackWidth/2, 0])
  straight(l=nincoStraightLength/2, copperWidth = 4 + 4 + nincoSlotWidth);
module nincoQuarterStraight() translate([0, -nincoTrackWidth/2, 0])
  straight(l=nincoStraightLength/4, copperWidth = 4 + 4 + nincoSlotWidth);

module nincoInterior() curve(copperWidth = 4 + 4 + nincoSlotWidth);
module nincoHalfInterior() curve(deg=45/2, copperWidth = 4 + 4 + nincoSlotWidth);
module nincoStandard() curve(r1=nincoRad2, r2=nincoRad3, copperWidth = 4 + 4 + nincoSlotWidth);
module nincoHalfStandard() curve(r1=nincoRad2, r2=nincoRad3, deg=45/2, copperWidth = 4 + 4 + nincoSlotWidth);
module nincoExterior() curve(r1=nincoRad3, r2=nincoRad4, deg=45/2, copperWidth = 4 + 4 + nincoSlotWidth);
module nincoSuperExt() curve(r1=nincoRad4, r2=nincoRad5, deg=45/2, copperWidth = 4 + 4 + nincoSlotWidth);

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
//curvedSlot(r1=nincoRad1, r2=nincoRad2, d=nincoTrackHeight, center = false);