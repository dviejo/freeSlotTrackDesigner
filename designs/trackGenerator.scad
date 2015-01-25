/**
 * Track Generator
 * 
 * Helper file for generating tracks from different brands
 * 
 * Created by Diego Viejo
 * 25/January/2015
 */

include<../sizes.conf>



module straight(l=nincoStraightLength, copperWidth=12)
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

module curve(r1=nincoRad1, r2=nincoRad2, deg = 45, center = true, copperWidth=12)
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

module curvedSlot(r1=nincoRad1-nincoSlotWidth/2, r2=nincoRad1+nincoSlotWidth/2, d=nincoSlotDepth, deg=45, center = true, copperWidth=12)
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
