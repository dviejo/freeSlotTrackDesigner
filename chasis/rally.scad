/**
 * rally.scad
 * 
 * Created by Diego Viejo
 * 
 * 11/Dic/2015
 * 
 * This is my attemp on creating a chassis for a rally slot car
 * 
 */

//guide arm's holder
//work in progress: check for all the sizes is still needed
numSlots = 3;
guideWidth = 40;
guideInternalWidth = 30;
guideHeight = 6;
guideHoleHeight = 3;
guideSupportLength = 7;
guideLength = guideSupportLength + 2 + numSlots*4;
engineHolderHoleSep = 20;

module guide(chassisLink=1)
difference()
{
    cube([guideWidth, guideLength, guideHeight], center=true);
    
    translate([0, guideSupportLength, 0]) cube([guideInternalWidth, guideLength, guideHeight+2], center=true);
    translate([0, 0, guideHeight/2]) cube([guideInternalWidth, guideLength+2, guideHeight], center=true);
    
    for(i=[1:10])
    {
        translate([-guideWidth/2-1, -guideLength/2 + guideSupportLength +i*4, -guideHeight/2+guideHoleHeight])
            rotate([0, 90, 0]) cylinder(d=2, h=guideWidth+2);
    }
    
    if(chassisLink==1)
    for(i=[-1,1])
    {
        translate([i*engineHolderHoleSep/2, (guideSupportLength-guideLength)/2, -guideHeight/2-1+guideHeight/4+1+0.3]) cylinder(d=2.5, h=guideHeight/2+2);
        translate([i*engineHolderHoleSep/2, (guideSupportLength-guideLength)/2, -guideHeight/2-1]) cylinder(d=5, h=guideHeight/4+1);
    }
}

guide();