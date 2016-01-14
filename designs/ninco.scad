/**
 * ninco.scad
 * 
 * Models for Ninco(r) tracks. Visit www.ninco.com
 * For visualization only
 * 
 * Created by Diego Viejo
 * 
 * TODO: Add change in curve
 * TODO: Add change in straight
 */

include <../sizes.conf>
use <trackGenerator.scad>

$fn=50;

copperWidth = 4 + 4 + nincoSlotWidth;	//TODO Check

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


//uncomment for testing
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
