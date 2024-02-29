module RubiksControls
# using DataFrames
# using CSV

# # 1 = W; 2 = B; 3 = R; 4 = O; 5 = G; 6 = Y;
# Memory = DataFrame(step=Int[], move=Int[], psolve=Int[], result = Vector{Matrix{Int64}}[])


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
    1=>"white",
    2=>"blue",
    3=>"yellow",
    4=>"green",
    5=>"orange",
    6=>"red"
)

function getSolvedCube()
    return deepcopy(solvedCube)
end

function labelCube(c)
    labeledCube = Dict{String,Any}()
    for i in eachindex(c)
        merge!(labeledCube, Dict(sideLabels[trunc(Int, (c[i][5] / 10))] => c[i]))
    end
    return labeledCube
end

function prettyPrintCubeOld(cube)
    println(' ')
    println("1: " * string(cube[1]))
    println("2: " * string(cube[2]))
    println("3: " * string(cube[3]))
    println("4: " * string(cube[4]))
    println("5: " * string(cube[5]))
    println("6: " * string(cube[6]))
    println(' ')
end

function prettyPrintCube(cube)
    indent = "           "
    println(' ')
    println(indent * "--------")
    println(indent * replace(replace(replace(string(cube[3]), "; " => "\n" * indent), "[" => ""), "]" => ""))
    println(indent * "--------")
    println(indent * replace(replace(replace(string(cube[2]), "; " => "\n" * indent), "[" => ""), "]" => ""))
    println("------------------------------")
    print(string(cube[5][1,1]) * " " * string(cube[5][1,2]) * " " * string(cube[5][1,3]) * " | ")
    print(string(cube[1][1,1]) * " " * string(cube[1][1,2]) * " " * string(cube[1][1,3]) * " | ")
    println(string(cube[6][1,1]) * " " * string(cube[6][1,2]) * " " * string(cube[6][1,3]) * " ")
    print(string(cube[5][2,1]) * " " * string(cube[5][2,2]) * " " * string(cube[5][2,3]) * " | ")
    print(string(cube[1][2,1]) * " " * string(cube[1][2,2]) * " " * string(cube[1][2,3]) * " | ")
    println(string(cube[6][2,1]) * " " * string(cube[6][2,2]) * " " * string(cube[6][2,3]) * " ")
    print(string(cube[5][3,1]) * " " * string(cube[5][3,2]) * " " * string(cube[5][3,3]) * " | ")
    print(string(cube[1][3,1]) * " " * string(cube[1][3,2]) * " " * string(cube[1][3,3]) * " | ")
    println(string(cube[6][3,1]) * " " * string(cube[6][3,2]) * " " * string(cube[6][3,3]) * " ")
    println("------------------------------")
    println(indent * replace(replace(replace(string(cube[4]), "; " => "\n" * indent), "[" => ""), "]" => ""))
    println(indent * "--------")
    println(' ')
end

function R(c)
    temp = deepcopy(c)
    R!(temp)
    return temp
end

function R!(c)
    temp = deepcopy(c)

    # Rotate the right column
    c[1][1, 3] = temp[4][1, 3]
    c[1][2, 3] = temp[4][2, 3]
    c[1][3, 3] = temp[4][3, 3]

    c[2][1, 3] = temp[1][1, 3]
    c[2][2, 3] = temp[1][2, 3]
    c[2][3, 3] = temp[1][3, 3]

    c[3][1, 3] = temp[2][1, 3]
    c[3][2, 3] = temp[2][2, 3]
    c[3][3, 3] = temp[2][3, 3]

    c[4][1, 3] = temp[3][1, 3]
    c[4][2, 3] = temp[3][2, 3]
    c[4][3, 3] = temp[3][3, 3]

    # Rotate the right face clockwise
    c[6][1, 1] = temp[6][3, 1]
    c[6][1, 2] = temp[6][2, 1]
    c[6][1, 3] = temp[6][1, 1]
    c[6][2, 1] = temp[6][3, 2]
    c[6][2, 2] = temp[6][2, 2]
    c[6][2, 3] = temp[6][1, 2]
    c[6][3, 1] = temp[6][3, 3]
    c[6][3, 2] = temp[6][2, 3]
    c[6][3, 3] = temp[6][1, 3]
end

function RPrime(c)
    temp = deepcopy(c)
    RPrime!(temp)
    return temp
end

function RPrime!(c)
    temp = deepcopy(c)

    # Rotate the right column
    c[1][1, 3] = temp[2][1, 3]
    c[1][2, 3] = temp[2][2, 3]
    c[1][3, 3] = temp[2][3, 3]

    c[2][1, 3] = temp[3][1, 3]
    c[2][2, 3] = temp[3][2, 3]
    c[2][3, 3] = temp[3][3, 3]

    c[3][1, 3] = temp[4][1, 3]
    c[3][2, 3] = temp[4][2, 3]
    c[3][3, 3] = temp[4][3, 3]

    c[4][1, 3] = temp[1][1, 3]
    c[4][2, 3] = temp[1][2, 3]
    c[4][3, 3] = temp[1][3, 3]

    #Rotate the right face counter clockwise
    c[6][1, 1] = temp[6][1, 3]
    c[6][1, 2] = temp[6][2, 3]
    c[6][1, 3] = temp[6][3, 3]
    c[6][2, 1] = temp[6][1, 2]
    c[6][2, 2] = temp[6][2, 2]
    c[6][2, 3] = temp[6][3, 2]
    c[6][3, 1] = temp[6][1, 1]
    c[6][3, 2] = temp[6][2, 1]
    c[6][3, 3] = temp[6][3, 1]
end

function L(c)
    temp = deepcopy(c)
    L!(temp)
    return temp
end

function L!(c)
    temp = deepcopy(c)

    # Rotate the left column
    c[1][1, 1] = temp[2][1, 1]
    c[1][2, 1] = temp[2][2, 1]
    c[1][3, 1] = temp[2][3, 1]

    c[2][1, 1] = temp[3][1, 1]
    c[2][2, 1] = temp[3][2, 1]
    c[2][3, 1] = temp[3][3, 1]

    c[3][1, 1] = temp[4][1, 1]
    c[3][2, 1] = temp[4][2, 1]
    c[3][3, 1] = temp[4][3, 1]

    c[4][1, 1] = temp[1][1, 1]
    c[4][2, 1] = temp[1][2, 1]
    c[4][3, 1] = temp[1][3, 1]

    # Rotate the left face clockwise
    c[5][1, 1] = temp[5][3, 1]
    c[5][1, 2] = temp[5][2, 1]
    c[5][1, 3] = temp[5][1, 1]
    c[5][2, 1] = temp[5][3, 2]
    c[5][2, 2] = temp[5][2, 2]
    c[5][2, 3] = temp[5][1, 2]
    c[5][3, 1] = temp[5][3, 3]
    c[5][3, 2] = temp[5][2, 3]
    c[5][3, 3] = temp[5][1, 3]
end

function LPrime(c)
    temp = deepcopy(c)
    LPrime!(temp)
    return temp
end

function LPrime!(c)
    temp = deepcopy(c)

    # Rotate the left column
    c[1][1, 1] = temp[4][1, 1]
    c[1][2, 1] = temp[4][2, 1]
    c[1][3, 1] = temp[4][3, 1]

    c[2][1, 1] = temp[1][1, 1]
    c[2][2, 1] = temp[1][2, 1]
    c[2][3, 1] = temp[1][3, 1]

    c[3][1, 1] = temp[2][1, 1]
    c[3][2, 1] = temp[2][2, 1]
    c[3][3, 1] = temp[2][3, 1]

    c[4][1, 1] = temp[3][1, 1]
    c[4][2, 1] = temp[3][2, 1]
    c[4][3, 1] = temp[3][3, 1]

    #Rotate the left face counter clockwise
    c[5][1, 1] = temp[5][1, 3]
    c[5][1, 2] = temp[5][2, 3]
    c[5][1, 3] = temp[5][3, 3]
    c[5][2, 1] = temp[5][1, 2]
    c[5][2, 2] = temp[5][2, 2]
    c[5][2, 3] = temp[5][3, 2]
    c[5][3, 1] = temp[5][1, 1]
    c[5][3, 2] = temp[5][2, 1]
    c[5][3, 3] = temp[5][3, 1]
end

function B(c)
    temp = deepcopy(c)
    B!(temp)
    return temp
end

function B!(c)
    temp = deepcopy(c)

    # Rotate the back column
    c[6][1, 1] = temp[3][3, 3]
    c[6][1, 2] = temp[3][3, 2]
    c[6][1, 3] = temp[3][3, 1]

    c[1][1, 1] = temp[6][1, 1]
    c[1][1, 2] = temp[6][1, 2]
    c[1][1, 3] = temp[6][1, 3]

    c[5][1, 1] = temp[1][1, 1]
    c[5][1, 2] = temp[1][1, 2]
    c[5][1, 3] = temp[1][1, 3]

    c[3][3, 1] = temp[5][1, 3]
    c[3][3, 2] = temp[5][1, 2]
    c[3][3, 3] = temp[5][1, 1]

    # Rotate the back face clockwise
    c[2][1, 1] = temp[2][3, 1]
    c[2][1, 2] = temp[2][2, 1]
    c[2][1, 3] = temp[2][1, 1]
    c[2][2, 1] = temp[2][3, 2]
    c[2][2, 2] = temp[2][2, 2]
    c[2][2, 3] = temp[2][1, 2]
    c[2][3, 1] = temp[2][3, 3]
    c[2][3, 2] = temp[2][2, 3]
    c[2][3, 3] = temp[2][1, 3]
end

function BPrime(c)
    temp = deepcopy(c)
    BPrime!(temp)
    return temp
end

function BPrime!(c)
    temp = deepcopy(c)

    # Rotate the back column
    c[6][1, 1] = temp[1][1, 1]
    c[6][1, 2] = temp[1][1, 2]
    c[6][1, 3] = temp[1][1, 3]

    c[1][1, 1] = temp[5][1, 1]
    c[1][1, 2] = temp[5][1, 2]
    c[1][1, 3] = temp[5][1, 3]

    c[5][1, 1] = temp[3][3, 3]
    c[5][1, 2] = temp[3][3, 2]
    c[5][1, 3] = temp[3][3, 1]

    c[3][3, 1] = temp[6][1, 3]
    c[3][3, 2] = temp[6][1, 2]
    c[3][3, 3] = temp[6][1, 1]

    #Rotate the back face counter clockwise
    c[2][1, 1] = temp[2][1, 3]
    c[2][1, 2] = temp[2][2, 3]
    c[2][1, 3] = temp[2][3, 3]
    c[2][2, 1] = temp[2][1, 2]
    c[2][2, 2] = temp[2][2, 2]
    c[2][2, 3] = temp[2][3, 2]
    c[2][3, 1] = temp[2][1, 1]
    c[2][3, 2] = temp[2][2, 1]
    c[2][3, 3] = temp[2][3, 1]
end

function F(c)
    temp = deepcopy(c)
    F!(temp)
    return temp
end

function F!(c)
    temp = deepcopy(c)

    # Rotate the front column
    c[6][3, 1] = temp[1][3, 1]
    c[6][3, 2] = temp[1][3, 2]
    c[6][3, 3] = temp[1][3, 3]

    c[1][3, 1] = temp[5][3, 1]
    c[1][3, 2] = temp[5][3, 2]
    c[1][3, 3] = temp[5][3, 3]

    c[5][3, 1] = temp[3][1, 3]
    c[5][3, 2] = temp[3][1, 2]
    c[5][3, 3] = temp[3][1, 1]

    c[3][1, 1] = temp[6][3, 3]
    c[3][1, 2] = temp[6][3, 2]
    c[3][1, 3] = temp[6][3, 1]

    # Rotate the front face clockwise
    c[4][1, 1] = temp[4][3, 1]
    c[4][1, 2] = temp[4][2, 1]
    c[4][1, 3] = temp[4][1, 1]
    c[4][2, 1] = temp[4][3, 2]
    c[4][2, 2] = temp[4][2, 2]
    c[4][2, 3] = temp[4][1, 2]
    c[4][3, 1] = temp[4][3, 3]
    c[4][3, 2] = temp[4][2, 3]
    c[4][3, 3] = temp[4][1, 3]
end

function FPrime(c)
    temp = deepcopy(c)
    FPrime!(temp)
    return temp
end

function FPrime!(c)
    temp = deepcopy(c)

    # Rotate the front column
    c[6][3, 1] = temp[3][1, 3]
    c[6][3, 2] = temp[3][1, 2]
    c[6][3, 3] = temp[3][1, 1]

    c[1][3, 1] = temp[6][3, 1]
    c[1][3, 2] = temp[6][3, 2]
    c[1][3, 3] = temp[6][3, 3]

    c[5][3, 1] = temp[1][3, 1]
    c[5][3, 2] = temp[1][3, 2]
    c[5][3, 3] = temp[1][3, 3]

    c[3][1, 1] = temp[5][3, 3]
    c[3][1, 2] = temp[5][3, 2]
    c[3][1, 3] = temp[5][3, 1]

    #Rotate the front face counter clockwise
    c[4][1, 1] = temp[4][1, 3]
    c[4][1, 2] = temp[4][2, 3]
    c[4][1, 3] = temp[4][3, 3]
    c[4][2, 1] = temp[4][1, 2]
    c[4][2, 2] = temp[4][2, 2]
    c[4][2, 3] = temp[4][3, 2]
    c[4][3, 1] = temp[4][1, 1]
    c[4][3, 2] = temp[4][2, 1]
    c[4][3, 3] = temp[4][3, 1]
end

function U(c)
    temp = deepcopy(c)
    U!(temp)
    return temp
end

function U!(c)
    temp = deepcopy(c)

    # Rotate the top column
    c[4][1, 1] = temp[6][3, 1]
    c[4][1, 2] = temp[6][2, 1]
    c[4][1, 3] = temp[6][1, 1]

    c[5][1, 3] = temp[4][1, 1]
    c[5][2, 3] = temp[4][1, 2]
    c[5][3, 3] = temp[4][1, 3]

    c[2][3, 1] = temp[5][3, 3]
    c[2][3, 2] = temp[5][2, 3]
    c[2][3, 3] = temp[5][1, 3]

    c[6][1, 1] = temp[2][3, 1]
    c[6][2, 1] = temp[2][3, 2]
    c[6][3, 1] = temp[2][3, 3]

    # Rotate the front top clockwise
    c[1][1, 1] = temp[1][3, 1]
    c[1][1, 2] = temp[1][2, 1]
    c[1][1, 3] = temp[1][1, 1]
    c[1][2, 1] = temp[1][3, 2]
    c[1][2, 2] = temp[1][2, 2]
    c[1][2, 3] = temp[1][1, 2]
    c[1][3, 1] = temp[1][3, 3]
    c[1][3, 2] = temp[1][2, 3]
    c[1][3, 3] = temp[1][1, 3]
end

function UPrime(c)
    temp = deepcopy(c)
    UPrime!(temp)
    return temp
end

function UPrime!(c)
    temp = deepcopy(c)

    # Rotate the front column
    c[4][1, 1] = temp[5][1, 3]
    c[4][1, 2] = temp[5][2, 3]
    c[4][1, 3] = temp[5][3, 3]

    c[5][1, 3] = temp[2][3, 3]
    c[5][2, 3] = temp[2][3, 2]
    c[5][3, 3] = temp[2][3, 1]

    c[2][3, 1] = temp[6][1, 1]
    c[2][3, 2] = temp[6][2, 1]
    c[2][3, 3] = temp[6][3, 1]

    c[6][1, 1] = temp[4][1, 3]
    c[6][2, 1] = temp[4][1, 2]
    c[6][3, 1] = temp[4][1, 1]

    #Rotate the top face counter clockwise
    c[1][1, 1] = temp[1][1, 3]
    c[1][1, 2] = temp[1][2, 3]
    c[1][1, 3] = temp[1][3, 3]
    c[1][2, 1] = temp[1][1, 2]
    c[1][2, 2] = temp[1][2, 2]
    c[1][2, 3] = temp[1][3, 2]
    c[1][3, 1] = temp[1][1, 1]
    c[1][3, 2] = temp[1][2, 1]
    c[1][3, 3] = temp[1][3, 1]
end

function D(c)
    temp = deepcopy(c)
    D!(temp)
    return temp
end

function D!(c)
    temp = deepcopy(c)

    # Rotate the bottom column
    c[4][3, 1] = temp[5][1, 1]
    c[4][3, 2] = temp[5][2, 1]
    c[4][3, 3] = temp[5][3, 1]

    c[5][1, 1] = temp[2][1, 3]
    c[5][2, 1] = temp[2][1, 2]
    c[5][3, 1] = temp[2][1, 1]

    c[2][1, 1] = temp[6][1, 3]
    c[2][1, 2] = temp[6][2, 3]
    c[2][1, 3] = temp[6][3, 3]

    c[6][1, 3] = temp[4][3, 3]
    c[6][2, 3] = temp[4][3, 2]
    c[6][3, 3] = temp[4][3, 1]

    # Rotate the bottom face clockwise
    c[3][1, 1] = temp[3][3, 1]
    c[3][1, 2] = temp[3][2, 1]
    c[3][1, 3] = temp[3][1, 1]
    c[3][2, 1] = temp[3][3, 2]
    c[3][2, 2] = temp[3][2, 2]
    c[3][2, 3] = temp[3][1, 2]
    c[3][3, 1] = temp[3][3, 3]
    c[3][3, 2] = temp[3][2, 3]
    c[3][3, 3] = temp[3][1, 3]
end

function DPrime(c)
    temp = deepcopy(c)
    DPrime!(temp)
    return temp
end

function DPrime!(c)
    temp = deepcopy(c)

    # Rotate the bottom column
    c[4][3, 1] = temp[6][3, 3]
    c[4][3, 2] = temp[6][2, 3]
    c[4][3, 3] = temp[6][1, 3]

    c[5][1, 1] = temp[4][3, 1]
    c[5][2, 1] = temp[4][3, 2]
    c[5][3, 1] = temp[4][3, 3]

    c[2][1, 1] = temp[5][3, 1]
    c[2][1, 2] = temp[5][2, 1]
    c[2][1, 3] = temp[5][1, 1]

    c[6][1, 3] = temp[2][1, 1]
    c[6][2, 3] = temp[2][1, 2]
    c[6][3, 3] = temp[2][1, 3]

    #Rotate the bottom face counter clockwise
    c[3][1, 1] = temp[3][1, 3]
    c[3][1, 2] = temp[3][2, 3]
    c[3][1, 3] = temp[3][3, 3]
    c[3][2, 1] = temp[3][1, 2]
    c[3][2, 2] = temp[3][2, 2]
    c[3][2, 3] = temp[3][3, 2]
    c[3][3, 1] = temp[3][1, 1]
    c[3][3, 2] = temp[3][2, 1]
    c[3][3, 3] = temp[3][3, 1]
end

function M(c)
    temp = deepcopy(c)
    M!(temp)
    return temp
end

function M!(c)
    LPrime!(c)
    R!(c)

    # temp = deepcopy(c)

    # Rotate the middle column clockwise
    # c[1][1, 2] = temp[4][1, 2]
    # c[1][2, 2] = temp[4][2, 2]
    # c[1][3, 2] = temp[4][3, 2]

    # c[2][1, 2] = temp[1][1, 2]
    # c[2][2, 2] = temp[1][2, 2]
    # c[2][3, 2] = temp[1][3, 2]

    # c[3][1, 2] = temp[2][1, 2]
    # c[3][2, 2] = temp[2][2, 2]
    # c[3][3, 2] = temp[2][3, 2]

    # c[4][1, 2] = temp[3][1, 2]
    # c[4][2, 2] = temp[3][2, 2]
    # c[4][3, 2] = temp[3][3, 2]
end

function MPrime(c)
    temp = deepcopy(c)
    MPrime!(temp)
    return temp
end

function MPrime!(c)
    L!(c)
    RPrime!(c)

    # temp = deepcopy(c)

    # Rotate the middle column counter-clockwise
    # c[1][1, 2] = temp[2][1, 2]
    # c[1][2, 2] = temp[2][2, 2]
    # c[1][3, 2] = temp[2][3, 2]

    # c[2][1, 2] = temp[3][1, 2]
    # c[2][2, 2] = temp[3][2, 2]
    # c[2][3, 2] = temp[3][3, 2]

    # c[3][1, 2] = temp[4][1, 2]
    # c[3][2, 2] = temp[4][2, 2]
    # c[3][3, 2] = temp[4][3, 2]

    # c[4][1, 2] = temp[1][1, 2]
    # c[4][2, 2] = temp[1][2, 2]
    # c[4][3, 2] = temp[1][3, 2]
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