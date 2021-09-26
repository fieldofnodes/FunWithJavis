using Pkg
Pkg.activate(".")
#using Luxor,Cairo,Plots,Javis,LaTeXStrings
using Javis

function ground(args...) 
    Luxor.background("white") # canvas background
    sethue("black") # pen color
end

function object(p=O, color="black")
    sethue(color)
    Luxor.circle(p, 25, :fill)
    return p
end

function path!(points, pos, color)
    sethue(color)
    push!(points, pos) # add pos to points
    Luxor.circle.(points, 2, :fill) # draws a circle for each point using broadcasting
end


function connector(p1, p2, color)
    sethue(color)
    Luxor.line(p1,p2, :stroke)
end

N = 500
myvideo = Video(500, 500)

path_of_red = Point[]
path_of_blue = Point[]
path_of_green = Point[]

Background(1:N, ground)

red_ball = Object(1:N, (args...)->object(O, "red"), Point(50,0))
act!(red_ball, Action(anim_rotate_around(6π, O)))
blue_ball = Object(1:N, (args...)->object(O, "blue"), Point(50,50))
act!(blue_ball, Action(anim_rotate_around(18π, 0.0, red_ball)))
green_ball = Object(1:N, (args...)->object(O, "green"), Point(100,100))
act!(green_ball, Action(anim_rotate_around(9π, 0.0, red_ball)))

#Object(1:N, (args...)->connector(pos(red_ball), pos(blue_ball), "black"))
#Object(1:N, (args...)->connector(pos(blue_ball), pos(green_ball), "black"))
Object(1:N, (args...)->path!(path_of_red, pos(red_ball), "red"))
Object(1:N, (args...)->path!(path_of_blue, pos(blue_ball), "blue"))
Object(1:N, (args...)->path!(path_of_green, pos(green_ball), "green"))

#=
render(
    myvideo;
    pathname="animations/circle_creation.mp4"
)
=#
render(
    myvideo;
    pathname="animations/circle_creation.gif"
)

