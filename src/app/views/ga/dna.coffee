total_points = 5;
maxWidth = 70;
maxHeight = 140;

exports.generate = ()->

  points = []

  i = 0
  while i < total_points
    x = Math.random() * maxWidth;
    y = Math.random() * maxHeight;
    p = {x, y}
    points.push(p)
    i++

  points
