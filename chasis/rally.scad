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
//work in progress: checking all sizes is still needed
numSlots = 1;
guideWidth = 32;
guideInternalWidth = 21.5;
guideHeight = 7;
guideHoleHeight = 4.5;
guideSupportLength = 7;
guideLength = 32; //guideSupportLength + numSlots*4- 2;
engineHolderHoleSep = 20;

//front axle
axleLength = 27;
bearingDiam = 5;
axleHeight = 6.75;


module guide(chassisLink=1)
difference()
{
    union()
    {
        cube([guideWidth, guideLength, guideHeight], center=true);
        translate([0, -guideLength/2 + axleLength, 0]) hull()
        {
            cube([guideWidth, bearingDiam*2.5, guideHeight], center = true);
            translate([0, 0, axleHeight+1]) cube([guideWidth, bearingDiam*1.85, 2], center=true);
        }
    }
    
    //main holes
    translate([0, guideSupportLength-1.5, 0]) cube([guideInternalWidth, guideLength, guideHeight*2], center=true);
    translate([0, 0, guideHoleHeight-1.25]) cube([guideInternalWidth, guideLength+2, guideHeight], center=true);
    translate([0, -(guideLength-6)/2-0.25, guideHoleHeight-1.25]) cube([25, 6, guideHeight], center=true);
    translate([0, guideSupportLength+6, 0]) cube([guideWidth - 2*2.5, guideLength, guideHeight*3], center=true);
    
    for(i=[1:numSlots])
    {
        translate([-guideWidth/2-1, -guideLength/2 + guideSupportLength +i*4-4, -guideHeight/2+guideHoleHeight])
            rotate([0, 90, 0]) cylinder(d=2, h=guideWidth+2);
    }
    
    if(chassisLink==1)
    for(i=[-1,1])
    {
        translate([i*engineHolderHoleSep/2, (guideSupportLength-guideLength)/2-0.75, -guideHeight/2-1+guideHeight/4+1.5+0.3]) cylinder(d=2.5, h=guideHeight/2+2);
        translate([i*engineHolderHoleSep/2, (guideSupportLength-guideLength)/2-0.75, -guideHeight/2-1]) cylinder(d=5, h=guideHeight/4+1.5);
    }
    
    translate([0, -guideLength/2 + axleLength, axleHeight-bearingDiam/2]) 
    {
        translate([0, 0, guideHeight/2]) cube([guideWidth+2, bearingDiam*0.8, guideHeight], center = true);
        translate([0, 0, -0.5]) cube([guideWidth+2, 1.5, guideHeight], center = true);
        rotate([0, 90, 0]) hull()
        {
            cylinder(d=bearingDiam, h=guideWidth+2, center=true, $fn=20);
            translate([-1.75, 0, 0]) cylinder(d=bearingDiam, h=guideWidth+2, center=true, $fn=20);
        }
    }
}

guide();