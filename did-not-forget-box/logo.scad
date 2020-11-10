$fn=50;
resize([25,20, 4]) {
    linear_extrude(height = 4, center = true, convexity = 10) {
     //import(file = "planet.svg", center = false, dpi = 96);
     //import(file = "small-star.svg", center = false, dpi = 96);
     //#import(file = "small-star-2.svg", center = false, dpi = 96);
     //import(file = "star-man.svg", center = false, dpi = 96);
     import(file = "text.svg", center = false, dpi = 96);
    }
}