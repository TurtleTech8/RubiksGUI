(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using RubiksGUI
const UserApp = RubiksGUI
RubiksGUI.main()
