import Quantities
import Quantities.SIBaseUnits
import Quantities.Screen

ScreenSpeed : Quantity
ScreenSpeed = ScreenLength </> Time

pxs : Unit ScreenSpeed
pxs = pixel <//> second

record PlayerState : Type where
  MkPlayerState : (xSpeed : F pxs) ->
                  (ySpeed : F pxs) ->
                  (xPos   : F px) ->
                  (yPos   : F px) -> PlayerState

gravity : F (pxs <//> second)
gravity = -800 =| (pxs <//> second)

-- Update player position and speed after a given duration
updatePlayerState : F second -> PlayerState -> PlayerState
updatePlayerState dt (MkPlayerState xs ys xp yp) =
  let newYPos = yp <+> convert (ys |*| dt)
  in if newYPos <= (0 =| px)
       then MkPlayerState (0 =| pxs) (0 =| pxs) xp (0 =| px)
       else MkPlayerState xs (ys <+> convert (gravity |*| dt))
                          (xp <+> convert (xs |*| dt)) newYPos
