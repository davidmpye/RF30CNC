include <MCAD/stepper.scad>

$fn=50;

mill_mount_bolt_dia = 8; //To machine, M8 bolts.

bolt_clearance_hole_dia = 5; //M5 bolts
bolt_tapped_hole_dia = 4; //to tap out to M5.
bolt_head_dia = 10;
bolt_head_height = 10;//for depth of countersink

//FK details.
FK_clearance_dia = 40; //hole size to take the FK mount

//stepper motor details
stepper_clearance_hole_dia = 30;
stepper_groove_hole_dia = 19.05*2;
stepper_groove_depth = 2;

thin_alu_thickness = 10;
thick_alu_thickness = 18;
    
module spacer() {
    bracket_x = 80;
    bracket_y = thin_alu_thickness;
    bracket_z = 60;
    
    difference() {
        cube([bracket_x, bracket_y, bracket_z]);

        //Two holes for mounting the stepper bracket
        translate([bracket_x - 5, bracket_y+0.5, 12.5]) rotate([90,0,0]) cylinder(r=bolt_tapped_hole_dia/2, h=bracket_y+1);
        translate([bracket_x - 5, bracket_y+0.5, 47.5]) rotate([90,0,0]) cylinder(r=bolt_tapped_hole_dia/2, h=bracket_y+1);;
    
        //Two holes to mount this piece to the FK mounting bracket.
        translate([-0.5,5,12.5]) rotate([0,90,0]) #cylinder(r=bolt_tapped_hole_dia/2, h=30 + 1);    
        translate([-0.5,5,47.5]) rotate([0,90,0]) #cylinder(r=bolt_tapped_hole_dia/2, h=30 + 1);   
    }
}



module fk_bracket() {
    bracket_x = 140;
    bracket_y = thick_alu_thickness;
    bracket_z = 60;
    
    difference() {
        
        cube([bracket_x, bracket_y, bracket_z]);
    
        //clearance hole for the FK mount
        translate([70, bracket_y + 0.5, 30 ]) rotate([90,0,0]) cylinder(r=FK_clearance_dia/2, h= bracket_y + 1);
        //The four holes (to tap to M5) for the mounting bolts for the FK mount
        translate([52.32, bracket_y + 0.5, 47.68 ]) rotate([90,0,0]) cylinder(r=bolt_tapped_hole_dia/2, h= bracket_y + 1);
        translate([52.32, bracket_y + 0.5, 12.32 ]) rotate([90,0,0]) cylinder(r=bolt_tapped_hole_dia/2, h= bracket_y + 1);
        translate([87.68, bracket_y + 0.5, 47.68 ]) rotate([90,0,0]) cylinder(r=bolt_tapped_hole_dia/2, h= bracket_y + 1);
        translate([87.68, bracket_y + 0.5, 12.32 ]) rotate([90,0,0]) cylinder(r=bolt_tapped_hole_dia/2, h= bracket_y + 1);
        
        //The two M8 bolt holes to attach this to the machine.
        translate([30, bracket_y + 0.5, 30])  rotate([90,0,0]) cylinder(r=mill_mount_bolt_dia/2, h= bracket_y + 1);
        translate([110, bracket_y + 0.5, 30]) rotate([90,0,0]) cylinder(r=mill_mount_bolt_dia/2, h= bracket_y + 1);
        
        //The M5 bolt mounts to mount to the spacers.
        
        hole_centres = [  [10,0,12.5 ], [10,0,47.5], [130,0,12.5], [130,0,47.5] ];
        for (point = hole_centres) {
            //the hole
            translate(point) translate([0,bracket_y + 0.5, 0])   rotate([90,0,0])cylinder(r=bolt_clearance_hole_dia/2, h= bracket_y + 1);
            //countersink for bolt head.
            translate(point) translate([0, bracket_y+0.1, 0])   rotate([90,0,0]) cylinder(r=bolt_head_dia/2, h= bolt_head_height + 0.1);

        
        }
        
        
    }
    
}


module stepper_bracket() {
    bracket_x = 110;
    bracket_y = thin_alu_thickness;
    bracket_z = 60;
    
    
 translate([55, bracket_y -9, 30 ])motor(Nema23, NemaLong,true,[0,0,0],[90,0,0]);
     difference() {
        
        cube([bracket_x, bracket_y, bracket_z]);
       
        //clearance hole for the stepper
        translate([55, bracket_y + 0.5, 30 ]) rotate([90,0,0]) cylinder(r=stepper_clearance_hole_dia/2, h= bracket_y + 1);
         
        //The flange that locates the stepper in place.
        translate([55, stepper_groove_depth, 30 ]) rotate([90,0,0]) cylinder(r=stepper_groove_hole_dia/2, h= bracket_y + 1);
         
    
        //Four bolt holes for the stepper
        translate([31.34,bracket_y+0.5,6.45]) rotate([90,0,0]) #cylinder (r=bolt_tapped_hole_dia/2, h=bracket_y+1);
        translate([31.34,bracket_y+0.5,53.55])  rotate([90,0,0]) #cylinder (r=bolt_tapped_hole_dia/2, h=bracket_y+1);
        translate([78.57,bracket_y+0.5,6.45])  rotate([90,0,0])#cylinder (r=bolt_tapped_hole_dia/2, h=bracket_y+1);
        translate([78.57,bracket_y+0.5,53.55])  rotate([90,0,0]) #cylinder (r=bolt_tapped_hole_dia/2, h=bracket_y+1);

         


        //bolt holes for the m5 bolts from the standoffs.
        translate([-0.5,5,12.5])  rotate([0,90,0]) cylinder(r=bolt_tapped_hole_dia/2, h=30.5);
        translate([-0.5,5,47.5])  rotate([0,90,0]) cylinder(r=bolt_tapped_hole_dia/2, h=30.5);
        translate([bracket_x-30,5,12.5])  rotate([0,90,0]) cylinder(r=bolt_tapped_hole_dia /2, h=30.5);
        translate([bracket_x-30,5,47.5])  rotate([0,90,0]) cylinder(r=bolt_tapped_hole_dia /2, h=30.5);

     }
    
    
}


//Assembly

fk_bracket();
translate([12.5-7.5,-2,0]) rotate([0,0,-90]) spacer();
translate([140-10 - 12.5+7.5, -2,0]) rotate([0,0,-90]) spacer();
translate([15,-80,0]) stepper_bracket();


