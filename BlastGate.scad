// The outer diameter of the pipe being used.
$pipeDiameter = 61; // mm

// The wall thickness of the pipe portion of the flange
$pipeWallsize = 1.5; // [1.5:0.1:10]

// The diameter of the fastener holes
$fastenerSize = 3.7; // [1:0.1:14]

// The part of the blast gate to render
$render = "all"; // [all, flange, spacer, gate]

if (($render == "all") || ($render == "flange")) {
    color("gray") {
        flange($pipeDiameter, $pipeWallsize);
        
        if(($render == "all")) {
            translate([0,0,-10])
                rotate([180,0,0])
                    flange($pipeDiameter, $pipeWallsize);
        }
    }
}

if (($render == "all") || ($render == "spacer")) {
    color("orange") {
        translate([0,0,-5])
            spacer($pipeDiameter, $pipeWallsize);
    }
}

if (($render == "all") || ($render == "gate")) {
    color("green") {
        translate([0,-11,-7])
            gate($pipeDiameter, $pipeWallsize);
    }
}

module gate(pipeDiameter, pipeWallsize) {

    $_pipeRadius = ((pipeDiameter / 2) + pipeWallsize);
    $_flangeSize = ($_pipeRadius + 20) * 2;
    
    union() {
        translate([0, -5,2])
              cube([
                $_flangeSize - 41, 
                $_flangeSize - 5, 
              4], center=true);
        
        translate([-(($_flangeSize - 41)/2), -($_flangeSize / 2), 4])
            rotate([0,90,0])
                cylinder(r=1.5, h = $_flangeSize - 41);
    }
}

module spacer(pipeDiameter, pipeWallsize) {
    
    $_pipeRadius = ((pipeDiameter / 2) + pipeWallsize);
    $_flangeSize = ($_pipeRadius + 20) * 2;
    
    difference() {
        cube([$_flangeSize, $_flangeSize, 4], center=true);
        translate([0,-10 - 0.001,2])
          cube([
            $_flangeSize - 40 - 0.001, 
            $_flangeSize - 15 - 0.001, 
          10], center=true);
        
        translate([-($_flangeSize / 2) + 8, -($_flangeSize / 2) + 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

        translate([($_flangeSize / 2) - 8, ($_flangeSize / 2) - 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

        translate([($_flangeSize / 2) - 8, -($_flangeSize / 2) + 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

        translate([-($_flangeSize / 2) + 8, ($_flangeSize / 2) - 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);
        
    }
    
}

module flange(pipeDiameter, pipeWallsize) {
    $_pipeRadius = ((pipeDiameter / 2) + pipeWallsize);
    $_flangeSize = ($_pipeRadius + 20) * 2;

    difference() {
        union() {
            cube([$_flangeSize, $_flangeSize, 4], center = true);
            
            translate([0,0,2 - 0.001])
                cylinder(r=$_pipeRadius, h=26);
        }
        translate([0,0,-4])    
            cylinder(r = $pipeDiameter / 2, h=32);
        
        translate([-($_flangeSize / 2) + 8, -($_flangeSize / 2) + 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

        translate([($_flangeSize / 2) - 8, ($_flangeSize / 2) - 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

        translate([($_flangeSize / 2) - 8, -($_flangeSize / 2) + 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

        translate([-($_flangeSize / 2) + 8, ($_flangeSize / 2) - 8, -3])
            cylinder(r = ($fastenerSize / 2), h=6);

    }

}

/* Rendering options */
$fa=1;
$fs=0.4;