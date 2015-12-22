/**
 * plantillaPlana.scad
 * 
 * Created by Diego Viejo
 * 21/Dec/2015
 * 
 */

ancho = 70;
largo = 150;
alto = 5;

anchoSlot = 3.5; //medir
largoSlot = 25;

difference()
{
    translate([-ancho/2, 0, 0]) cube([ancho, largo, alto]);
    
    translate([-(anchoSlot)/2, 1, -1]) cube([anchoSlot, largoSlot-1, alto+2]);
    
    for(i=[-1,1]) for(j=[0,1])
    {
        translate([i*(ancho-14)/2, 7+j*(largo-14), -1]) 
        {
            cylinder(d=3, h=alto+2, $fn=20);
            cylinder(d1=7, d2=3, h=1+3, $fn=20);
        }
    }
}