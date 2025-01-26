extends Line2D


@export var circle_radius: float = 50.0  # Radius of the circle
@export var circle_segments: int = 64   # Number of points in the circle
@export var line_width: float = 4.0     # Thickness of the line
@export var line_color: Color = Color(1.0, 1.0, 0.0)  # Default color: yellow

func _ready() -> void:
    # Set Line2D properties
    self.width = line_width
    self.default_color = line_color

    # Draw the circular outline
    generate_circle_points(circle_radius, circle_segments)

func generate_circle_points(radius: float, segments: int) -> void:
    # Clear any existing points
    self.clear_points()

    # Generate points around the circle
    for i in range(segments):
        var angle = (i / float(segments)) * TAU  # Angle in radians
        var point = Vector2(cos(angle), sin(angle)) * radius
        self.add_point(point)

    # Ensure the circle is closed
    self.close_curve = true
