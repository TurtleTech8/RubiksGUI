using Genie.Router, Genie.Renderer.Json, Genie.Requests, GenieSession, GenieSessionFileSession
using RubiksGUI.UIsController
using RubiksGUI.RubiksControls

GenieSession.__init__()



route("/") do
  serve_static_file("welcome.html")
end

route("/cube", UIsController.buildCube)

route("/cube/turnCube", method=POST) do
  s = session()
  direction = params(:direction, "")
  GenieSession.set!(s, :currentCube, RubiksControls.mapDirection(direction)(s.data[:currentCube]))
  println(s.data[:currentCube])
  ("response" => RubiksControls.labelCube(s.data[:currentCube])) |> json
end

route("/cube/resetCube", method=POST) do
  s = session()
  GenieSession.set!(s, :currentCube, RubiksControls.getSolvedCube())
  println(s.data[:currentCube])
  ("response" => RubiksControls.labelCube(s.data[:currentCube])) |> json
end

route("/cube/mixCube", method=POST) do 
  s = session()
  GenieSession.set!(s, :currentCube, RubiksControls.mixCube(s.data[:currentCube], 35))
  ("response" => RubiksControls.labelCube(s.data[:currentCube])) |> json
end