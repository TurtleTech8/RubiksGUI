module RubiksControls
# using DataFrames
# using CSV

# # 1 = W; 2 = B; 3 = R; 4 = O; 5 = G; 6 = Y;
# Memory = DataFrame(step=Int[], move=Int[], psolve=Int[], result = Vector{Matrix{Int64}}[])

const TL = 1
const TM = 4
const TR = 7
const ML = 2
const MM = 5
const MR = 8
const BL = 3
const BM = 6
const BR = 9

const TOP    = 1
const BACK   = 2
const BOTTOM = 3
const FRONT  = 4
const LEFT   = 5
const RIGHT  = 6

const WHITE  = 1
const BLUE   = 2
const YELLOW = 3
const GREEN  = 4
const ORANGE = 5
const RED    = 6

solvedCube = [
    [11 12 13
     14 15 16
     17 18 19],
    [21 22 23
     24 25 26
     27 28 29],
    [31 32 33 
     34 35 36
     37 38 39],
    [41 42 43
     44 45 46
     47 48 49],
    [51 52 53
     54 55 56
     57 58 59],
    [61 62 63
     64 65 66
     67 68 69],
]

sideLabels = Dict(
    TOP=>"top",
    BACK=>"back",
    BOTTOM=>"bottom",
    FRONT=>"front",
    LEFT=>"left",
    RIGHT=>"right"
)

colorMap = Dict(
    "white"  => WHITE,
    "yellow" => YELLOW,
    "blue"   => BLUE,
    "green"  => GREEN,
    "red"    => RED,
    "orange" => ORANGE
)

oppositeSides = Dict(
    WHITE  => YELLOW,
    YELLOW => WHITE,
    BLUE   => GREEN,
    GREEN  => BLUE,
    RED    => ORANGE,
    ORANGE => RED
)

function getSolvedCube()
    return deepcopy(solvedCube)
end

function labelCube(c)
    labeledCube = Dict{String,Any}()
    for i in eachindex(c)
        merge!(labeledCube, Dict(sideLabels[i] => c[i]))
    end
    return labeledCube
end

function changeTopFace(c, color)

end

#--------------------------------------------------#
#                DIRECTIONAL INPUTS                #
#--------------------------------------------------#

function R(c)
    temp = deepcopy(c)
    R!(temp)
    return temp
end

function R!(c)
    temp = deepcopy(c)

    # Rotate the right column
    c[TOP][TR] = temp[FRONT][TR]
    c[TOP][MR] = temp[FRONT][MR]
    c[TOP][BR] = temp[FRONT][BR]

    c[BACK][TR] = temp[TOP][TR]
    c[BACK][MR] = temp[TOP][MR]
    c[BACK][BR] = temp[TOP][BR]

    c[BOTTOM][TR] = temp[BACK][TR]
    c[BOTTOM][MR] = temp[BACK][MR]
    c[BOTTOM][BR] = temp[BACK][BR]

    c[FRONT][TR] = temp[BOTTOM][TR]
    c[FRONT][MR] = temp[BOTTOM][MR]
    c[FRONT][BR] = temp[BOTTOM][BR]

    # Rotate the right face clockwise
    c[RIGHT][TL] = temp[RIGHT][BL]
    c[RIGHT][TM] = temp[RIGHT][ML]
    c[RIGHT][TR] = temp[RIGHT][TL]
    c[RIGHT][ML] = temp[RIGHT][BM]
    c[RIGHT][MM] = temp[RIGHT][MM]
    c[RIGHT][MR] = temp[RIGHT][TM]
    c[RIGHT][BL] = temp[RIGHT][BR]
    c[RIGHT][BM] = temp[RIGHT][MR]
    c[RIGHT][BR] = temp[RIGHT][TR]
end

function RPrime(c)
    temp = deepcopy(c)
    RPrime!(temp)
    return temp
end

function RPrime!(c)
    temp = deepcopy(c)

    # Rotate the right column
    c[TOP][TR] = temp[BACK][TR]
    c[TOP][MR] = temp[BACK][MR]
    c[TOP][BR] = temp[BACK][BR]

    c[BACK][TR] = temp[BOTTOM][TR]
    c[BACK][MR] = temp[BOTTOM][MR]
    c[BACK][BR] = temp[BOTTOM][BR]

    c[BOTTOM][TR] = temp[FRONT][TR]
    c[BOTTOM][MR] = temp[FRONT][MR]
    c[BOTTOM][BR] = temp[FRONT][BR]

    c[FRONT][TR] = temp[TOP][TR]
    c[FRONT][MR] = temp[TOP][MR]
    c[FRONT][BR] = temp[TOP][BR]

    #Rotate the right face counter clockwise
    c[RIGHT][TL] = temp[RIGHT][TR]
    c[RIGHT][TM] = temp[RIGHT][MR]
    c[RIGHT][TR] = temp[RIGHT][BR]
    c[RIGHT][ML] = temp[RIGHT][TM]
    c[RIGHT][MM] = temp[RIGHT][MM]
    c[RIGHT][MR] = temp[RIGHT][BM]
    c[RIGHT][BL] = temp[RIGHT][TL]
    c[RIGHT][BM] = temp[RIGHT][ML]
    c[RIGHT][BR] = temp[RIGHT][BL]
end

function L(c)
    temp = deepcopy(c)
    L!(temp)
    return temp
end

function L!(c)
    temp = deepcopy(c)

    # Rotate the left column
    c[TOP][TL] = temp[BACK][TL]
    c[TOP][ML] = temp[BACK][ML]
    c[TOP][BL] = temp[BACK][BL]

    c[BACK][TL] = temp[BOTTOM][TL]
    c[BACK][ML] = temp[BOTTOM][ML]
    c[BACK][BL] = temp[BOTTOM][BL]

    c[BOTTOM][TL] = temp[FRONT][TL]
    c[BOTTOM][ML] = temp[FRONT][ML]
    c[BOTTOM][BL] = temp[FRONT][BL]

    c[FRONT][TL] = temp[TOP][TL]
    c[FRONT][ML] = temp[TOP][ML]
    c[FRONT][BL] = temp[TOP][BL]

    # Rotate the left face clockwise
    c[LEFT][TL] = temp[LEFT][BL]
    c[LEFT][TM] = temp[LEFT][ML]
    c[LEFT][TR] = temp[LEFT][TL]
    c[LEFT][ML] = temp[LEFT][BM]
    c[LEFT][MM] = temp[LEFT][MM]
    c[LEFT][MR] = temp[LEFT][TM]
    c[LEFT][BL] = temp[LEFT][BR]
    c[LEFT][BM] = temp[LEFT][MR]
    c[LEFT][BR] = temp[LEFT][TR]
end

function LPrime(c)
    temp = deepcopy(c)
    LPrime!(temp)
    return temp
end

function LPrime!(c)
    temp = deepcopy(c)

    # Rotate the left column
    c[TOP][TL] = temp[FRONT][TL]
    c[TOP][ML] = temp[FRONT][ML]
    c[TOP][BL] = temp[FRONT][BL]

    c[BACK][TL] = temp[TOP][TL]
    c[BACK][ML] = temp[TOP][ML]
    c[BACK][BL] = temp[TOP][BL]

    c[BOTTOM][TL] = temp[BACK][TL]
    c[BOTTOM][ML] = temp[BACK][ML]
    c[BOTTOM][BL] = temp[BACK][BL]

    c[FRONT][TL] = temp[BOTTOM][TL]
    c[FRONT][ML] = temp[BOTTOM][ML]
    c[FRONT][BL] = temp[BOTTOM][BL]

    #Rotate the left face counter clockwise
    c[LEFT][TL] = temp[LEFT][TR]
    c[LEFT][TM] = temp[LEFT][MR]
    c[LEFT][TR] = temp[LEFT][BR]
    c[LEFT][ML] = temp[LEFT][TM]
    c[LEFT][MM] = temp[LEFT][MM]
    c[LEFT][MR] = temp[LEFT][BM]
    c[LEFT][BL] = temp[LEFT][TL]
    c[LEFT][BM] = temp[LEFT][ML]
    c[LEFT][BR] = temp[LEFT][BL]
end

function B(c)
    temp = deepcopy(c)
    B!(temp)
    return temp
end

function B!(c)
    temp = deepcopy(c)

    # Rotate the back column
    c[RIGHT][TL] = temp[BOTTOM][BR]
    c[RIGHT][TM] = temp[BOTTOM][BM]
    c[RIGHT][TR] = temp[BOTTOM][BL]

    c[TOP][TL] = temp[RIGHT][TL]
    c[TOP][TM] = temp[RIGHT][TM]
    c[TOP][TR] = temp[RIGHT][TR]

    c[LEFT][TL] = temp[TOP][TL]
    c[LEFT][TM] = temp[TOP][TM]
    c[LEFT][TR] = temp[TOP][TR]

    c[BOTTOM][BL] = temp[LEFT][TR]
    c[BOTTOM][BM] = temp[LEFT][TM]
    c[BOTTOM][BR] = temp[LEFT][TL]

    # Rotate the back face clockwise
    c[BACK][TL] = temp[BACK][BL]
    c[BACK][TM] = temp[BACK][ML]
    c[BACK][TR] = temp[BACK][TL]
    c[BACK][ML] = temp[BACK][BM]
    c[BACK][MM] = temp[BACK][MM]
    c[BACK][MR] = temp[BACK][TM]
    c[BACK][BL] = temp[BACK][BR]
    c[BACK][BM] = temp[BACK][MR]
    c[BACK][BR] = temp[BACK][TR]
end

function BPrime(c)
    temp = deepcopy(c)
    BPrime!(temp)
    return temp
end

function BPrime!(c)
    temp = deepcopy(c)

    # Rotate the back column
    c[RIGHT][TL] = temp[TOP][TL]
    c[RIGHT][TM] = temp[TOP][TM]
    c[RIGHT][TR] = temp[TOP][TR]

    c[TOP][TL] = temp[LEFT][TL]
    c[TOP][TM] = temp[LEFT][TM]
    c[TOP][TR] = temp[LEFT][TR]

    c[LEFT][TL] = temp[BOTTOM][BR]
    c[LEFT][TM] = temp[BOTTOM][BM]
    c[LEFT][TR] = temp[BOTTOM][BL]

    c[BOTTOM][BL] = temp[RIGHT][TR]
    c[BOTTOM][BM] = temp[RIGHT][TM]
    c[BOTTOM][BR] = temp[RIGHT][TL]

    #Rotate the back face counter clockwise
    c[BACK][TL] = temp[BACK][TR]
    c[BACK][TM] = temp[BACK][MR]
    c[BACK][TR] = temp[BACK][BR]
    c[BACK][ML] = temp[BACK][TM]
    c[BACK][MM] = temp[BACK][MM]
    c[BACK][MR] = temp[BACK][BM]
    c[BACK][BL] = temp[BACK][TL]
    c[BACK][BM] = temp[BACK][ML]
    c[BACK][BR] = temp[BACK][BL]
end

function F(c)
    temp = deepcopy(c)
    F!(temp)
    return temp
end

function F!(c)
    temp = deepcopy(c)

    # Rotate the front column
    c[RIGHT][BL] = temp[TOP][BL]
    c[RIGHT][BM] = temp[TOP][BM]
    c[RIGHT][BR] = temp[TOP][BR]

    c[TOP][BL] = temp[LEFT][BL]
    c[TOP][BM] = temp[LEFT][BM]
    c[TOP][BR] = temp[LEFT][BR]

    c[LEFT][BL] = temp[BOTTOM][TR]
    c[LEFT][BM] = temp[BOTTOM][TM]
    c[LEFT][BR] = temp[BOTTOM][TL]

    c[BOTTOM][TL] = temp[RIGHT][BR]
    c[BOTTOM][TM] = temp[RIGHT][BM]
    c[BOTTOM][TR] = temp[RIGHT][BL]

    # Rotate the front face clockwise
    c[FRONT][TL] = temp[FRONT][BL]
    c[FRONT][TM] = temp[FRONT][ML]
    c[FRONT][TR] = temp[FRONT][TL]
    c[FRONT][ML] = temp[FRONT][BM]
    c[FRONT][MM] = temp[FRONT][MM]
    c[FRONT][MR] = temp[FRONT][TM]
    c[FRONT][BL] = temp[FRONT][BR]
    c[FRONT][BM] = temp[FRONT][MR]
    c[FRONT][BR] = temp[FRONT][TR]
end

function FPrime(c)
    temp = deepcopy(c)
    FPrime!(temp)
    return temp
end

function FPrime!(c)
    temp = deepcopy(c)

    # Rotate the front column
    c[RIGHT][BL] = temp[BOTTOM][TR]
    c[RIGHT][BM] = temp[BOTTOM][TM]
    c[RIGHT][BR] = temp[BOTTOM][TL]

    c[TOP][BL] = temp[RIGHT][BL]
    c[TOP][BM] = temp[RIGHT][BM]
    c[TOP][BR] = temp[RIGHT][BR]

    c[LEFT][BL] = temp[TOP][BL]
    c[LEFT][BM] = temp[TOP][BM]
    c[LEFT][BR] = temp[TOP][BR]

    c[BOTTOM][TL] = temp[LEFT][BR]
    c[BOTTOM][TM] = temp[LEFT][BM]
    c[BOTTOM][TR] = temp[LEFT][BL]

    #Rotate the front face counter clockwise
    c[FRONT][TL] = temp[FRONT][TR]
    c[FRONT][TM] = temp[FRONT][MR]
    c[FRONT][TR] = temp[FRONT][BR]
    c[FRONT][ML] = temp[FRONT][TM]
    c[FRONT][MM] = temp[FRONT][MM]
    c[FRONT][MR] = temp[FRONT][BM]
    c[FRONT][BL] = temp[FRONT][TL]
    c[FRONT][BM] = temp[FRONT][ML]
    c[FRONT][BR] = temp[FRONT][BL]
end

function U(c)
    temp = deepcopy(c)
    U!(temp)
    return temp
end

function U!(c)
    temp = deepcopy(c)

    # Rotate the top column
    c[FRONT][TL] = temp[RIGHT][BL]
    c[FRONT][TM] = temp[RIGHT][ML]
    c[FRONT][TR] = temp[RIGHT][TL]

    c[LEFT][TR] = temp[FRONT][TL]
    c[LEFT][MR] = temp[FRONT][TM]
    c[LEFT][BR] = temp[FRONT][TR]

    c[BACK][BL] = temp[LEFT][BR]
    c[BACK][BM] = temp[LEFT][MR]
    c[BACK][BR] = temp[LEFT][TR]

    c[RIGHT][TL] = temp[BACK][BL]
    c[RIGHT][ML] = temp[BACK][BM]
    c[RIGHT][BL] = temp[BACK][BR]

    # Rotate the front top clockwise
    c[TOP][TL] = temp[TOP][BL]
    c[TOP][TM] = temp[TOP][ML]
    c[TOP][TR] = temp[TOP][TL]
    c[TOP][ML] = temp[TOP][BM]
    c[TOP][MM] = temp[TOP][MM]
    c[TOP][MR] = temp[TOP][TM]
    c[TOP][BL] = temp[TOP][BR]
    c[TOP][BM] = temp[TOP][MR]
    c[TOP][BR] = temp[TOP][TR]
end

function UPrime(c)
    temp = deepcopy(c)
    UPrime!(temp)
    return temp
end

function UPrime!(c)
    temp = deepcopy(c)

    # Rotate the front column
    c[FRONT][TL] = temp[LEFT][TR]
    c[FRONT][TM] = temp[LEFT][MR]
    c[FRONT][TR] = temp[LEFT][BR]

    c[LEFT][TR] = temp[BACK][BR]
    c[LEFT][MR] = temp[BACK][BM]
    c[LEFT][BR] = temp[BACK][BL]

    c[BACK][BL] = temp[RIGHT][TL]
    c[BACK][BM] = temp[RIGHT][ML]
    c[BACK][BR] = temp[RIGHT][BL]

    c[RIGHT][TL] = temp[FRONT][TR]
    c[RIGHT][ML] = temp[FRONT][TM]
    c[RIGHT][BL] = temp[FRONT][TL]

    #Rotate the top face counter clockwise
    c[TOP][TL] = temp[TOP][TR]
    c[TOP][TM] = temp[TOP][MR]
    c[TOP][TR] = temp[TOP][BR]
    c[TOP][ML] = temp[TOP][TM]
    c[TOP][MM] = temp[TOP][MM]
    c[TOP][MR] = temp[TOP][BM]
    c[TOP][BL] = temp[TOP][TL]
    c[TOP][BM] = temp[TOP][ML]
    c[TOP][BR] = temp[TOP][BL]
end

function D(c)
    temp = deepcopy(c)
    D!(temp)
    return temp
end

function D!(c)
    temp = deepcopy(c)

    # Rotate the bottom column
    c[FRONT][BL] = temp[LEFT][TL]
    c[FRONT][BM] = temp[LEFT][ML]
    c[FRONT][BR] = temp[LEFT][BL]

    c[LEFT][TL] = temp[BACK][TR]
    c[LEFT][ML] = temp[BACK][TM]
    c[LEFT][BL] = temp[BACK][TL]

    c[BACK][TL] = temp[RIGHT][TR]
    c[BACK][TM] = temp[RIGHT][MR]
    c[BACK][TR] = temp[RIGHT][BR]

    c[RIGHT][TR] = temp[FRONT][BR]
    c[RIGHT][MR] = temp[FRONT][BM]
    c[RIGHT][BR] = temp[FRONT][BL]

    # Rotate the bottom face clockwise
    c[BOTTOM][TL] = temp[BOTTOM][BL]
    c[BOTTOM][TM] = temp[BOTTOM][ML]
    c[BOTTOM][TR] = temp[BOTTOM][TL]
    c[BOTTOM][ML] = temp[BOTTOM][BM]
    c[BOTTOM][MM] = temp[BOTTOM][MM]
    c[BOTTOM][MR] = temp[BOTTOM][TM]
    c[BOTTOM][BL] = temp[BOTTOM][BR]
    c[BOTTOM][BM] = temp[BOTTOM][MR]
    c[BOTTOM][BR] = temp[BOTTOM][TR]
end

function DPrime(c)
    temp = deepcopy(c)
    DPrime!(temp)
    return temp
end

function DPrime!(c)
    temp = deepcopy(c)

    # Rotate the bottom column
    c[FRONT][BL] = temp[RIGHT][BR]
    c[FRONT][BM] = temp[RIGHT][MR]
    c[FRONT][BR] = temp[RIGHT][TR]

    c[LEFT][TL] = temp[FRONT][BL]
    c[LEFT][ML] = temp[FRONT][BM]
    c[LEFT][BL] = temp[FRONT][BR]

    c[BACK][TL] = temp[LEFT][BL]
    c[BACK][TM] = temp[LEFT][ML]
    c[BACK][TR] = temp[LEFT][TL]

    c[RIGHT][TR] = temp[BACK][TL]
    c[RIGHT][MR] = temp[BACK][TM]
    c[RIGHT][BR] = temp[BACK][TR]

    #Rotate the bottom face counter clockwise
    c[BOTTOM][TL] = temp[BOTTOM][TR]
    c[BOTTOM][TM] = temp[BOTTOM][MR]
    c[BOTTOM][TR] = temp[BOTTOM][BR]
    c[BOTTOM][ML] = temp[BOTTOM][TM]
    c[BOTTOM][MM] = temp[BOTTOM][MM]
    c[BOTTOM][MR] = temp[BOTTOM][BM]
    c[BOTTOM][BL] = temp[BOTTOM][TL]
    c[BOTTOM][BM] = temp[BOTTOM][ML]
    c[BOTTOM][BR] = temp[BOTTOM][BL]
end

function M(c)
    temp = deepcopy(c)
    M!(temp)
    return temp
end

function M!(c)
    LPrime!(c)
    R!(c)
end

function MPrime(c)
    temp = deepcopy(c)
    MPrime!(temp)
    return temp
end

function MPrime!(c)
    L!(c)
    RPrime!(c)
end

function E(c)
    temp = deepcopy(c)
    E!(temp)
    return temp
end

function E!(c)
    U!(c)
    DPrime!(c)
end

function EPrime(c)
    temp = deepcopy(c)
    EPrime!(temp)
    return temp
end

function EPrime!(c)
    UPrime!(c)
    D!(c)
end

function S(c)
    temp = deepcopy(c)
    S!(temp)
    return temp
end

function S!(c)
    FPrime!(c)
    B!(c)
end

function SPrime(c)
    temp = deepcopy(c)
    SPrime!(temp)
    return temp
end

function SPrime!(c)
    F!(c)
    BPrime!(c)
end


directionMapping = Dict{String, Function}(
    "L"  => L,
    "L`" => LPrime,
    "R"  => R,
    "R`" => RPrime,
    "M"  => M,
    "M`" => MPrime,
    "U"  => U,
    "U`" => UPrime,
    "E"  => E,
    "E`" => EPrime,
    "D"  => D,
    "D`" => DPrime,
    "F"  => F,
    "F`" => FPrime,
    "S"  => S,
    "S`" => SPrime,
    "B"  => B,
    "B`" => BPrime
)

function mapDirection(direction)
    return directionMapping[direction]
end

function percentSolved(c) 
    r = 0
    for i in eachindex(c)
        x = c[i]
        sx = solvedCube[i]
        for y in 1:3
            for z in 1:3
                r += x[y, z] == sx[y, z] ? 1 : 0
            end
        end
    end
    return trunc(Int, (r / 54) * 100)
end

function mixCube(c, moves)
    temp = deepcopy(c)
    mixCube!(temp, moves)
    return temp
end

function mixCube!(c, moves)
    for i in 1:moves
        rnum = rand(1:12)
        println(rnum)
        if(rnum == 1)
            R!(c)
        elseif(rnum == 2)
            RPrime!(c)
        elseif(rnum == 3)
            L!(c)
        elseif(rnum == 4)
            LPrime!(c)
        elseif(rnum == 5)
            B!(c)
        elseif(rnum == 6)
            BPrime!(c)
        elseif(rnum == 7)
            F!(c)
        elseif(rnum == 8)
            FPrime!(c)
        elseif(rnum == 9)
            U!(c)
        elseif(rnum == 10)
            UPrime!(c)
        elseif(rnum == 11)
            D!(c)
        elseif(rnum == 12)
            DPrime!(c)
        end
    end
end

# function solveCube!(c, moves)
#     push!(Memory, (0, 0, percentSolved(c), c))
#     for i in 1:moves
#         rnum = rand(1:12)
#         if(rnum == 1)
#             R!(c)
#         elseif(rnum == 2)
#             RPrime!(c)
#         elseif(rnum == 3)
#             L!(c)
#         elseif(rnum == 4)
#             LPrime!(c)
#         elseif(rnum == 5)
#             B!(c)
#         elseif(rnum == 6)
#             BPrime!(c)
#         elseif(rnum == 7)
#             F!(c)
#         elseif(rnum == 8)
#             FPrime!(c)
#         elseif(rnum == 9)
#             U!(c)
#         elseif(rnum == 10)
#             UPrime!(c)
#         elseif(rnum == 11)
#             D!(c)
#         elseif(rnum == 12)
#             DPrime!(c)
#         end
#         push!(Memory, (i, rnum, percentSolved(c), c))
#         if(c == solvedCube)
#             break
#         end
#     end
# end

end