using Genie.Router, Genie.Renderer.Json, Genie.Requests
using RubiksGUI.UIsController
using RubiksGUI.RubiksControls

route("/") do
  serve_static_file("welcome.html")
end

route("/cube", UIsController.buildCube)

route("/cube/controls", method=POST) do
  
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
    message = jsonpayload()
    ("response" => RubiksControls.labelCube(solvedCube)) |> json
end