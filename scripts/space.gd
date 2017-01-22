extends Control

func _draw():
    var center = Vector2(5000,5000)
    var radius = 1500
    var angle_from = 0
    var angle_to = 360
    var color = Color(1.0, 0.0, 0.0)
    draw_circle_arc( center, radius, angle_from, angle_to, color )
    color = Color(0.34, 0.32, 0.52)
    draw_circle_arc( center, 730, angle_from, angle_to, color )
    draw_circle_arc( center, 610, angle_from, angle_to, color )
    draw_circle_arc( center, 950, angle_from, angle_to, color )
    draw_circle_arc( center, 455, angle_from, angle_to, color )
    draw_circle_arc( center, 1225, angle_from, angle_to, color )

func draw_circle_arc( center, radius, angle_from, angle_to, color ):
    var nb_points = 360
    var points_arc = Vector2Array()

    for i in range(nb_points+1):
        var angle_point = angle_from + i*(angle_to-angle_from)/nb_points - 90
        var point = center + Vector2( cos(deg2rad(angle_point)), sin(deg2rad(angle_point)) ) * radius
        points_arc.push_back( point )

    for indexPoint in range(nb_points):
        draw_line(points_arc[indexPoint], points_arc[indexPoint+1], color)