$fn=50;


//dagger
polyhedron(
    points = [[0, 0, 0], [12, 5, 0], [0, 10, 0], [-12, 5, 0],
        [0, 1, 100], [10, 5, 100], [0, 8, 100], [-10, 5, 100], [0, 4, 120]],
    faces = [[0, 1, 2, 3], [1, 0, 4, 5], [2, 1, 5, 6], [3, 2, 6, 7], [0, 3, 7, 4],
    [5, 4, 8], [6, 5, 8], [7, 6, 8], [4, 7, 8]]);
//dagger connector
translate([-2, 3, -4]) cube([4, 4, 4]);
