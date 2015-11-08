module Game

import Quantities
import Quantities.Screen

ScreenSpeed : Quantity
ScreenSpeed = ScreenLength </> Time

Pxs : Unit ScreenSpeed
Pxs = Pixel <//> Second

record PlayerState where
  constructor MkPlayerState
  xSpeed : F Pxs
  ySpeed : F Pxs
  xPos   : F Px
  yPos   : F Px

gravity : Quantities.Core.F (Pxs <//> Second)
gravity = -800 =| (Pxs <//> Second)

-- Update player position and speed after a given duration
updatePlayerState : F Second -> PlayerState -> PlayerState
updatePlayerState dt (MkPlayerState xs ys xp yp) =
  let newYPos = yp <+> ys |*| dt
  in if newYPos <= (0 =| Px)
       then MkPlayerState (0 =| Pxs) (0 =| Pxs) xp (0 =| Px)
       else MkPlayerState xs (ys <+> gravity |*| dt)
                          (xp <+> xs |*| dt) newYPos
