module Animation.State where

import Control.Monad.Trans.State.Lazy
import Control.Monad.Trans.Writer.CPS
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Class (lift)

import Animation.Auxiliary (changeSpeed)

-- Types and Data constructors for Environment (Env) and State (State)

type Vector = (Int, Int)

data MyState = MyState { position :: Vector, direction :: Vector, velocity :: Float }
  deriving (Show) 

data Env = Env { frame :: Vector, maxspeed :: Float, acceleration :: Float, numofmoves :: Int} --, chargeSpeedF :: Int } -- chargeSpeed :: Int (for later)}
  deriving (Show)

-- next to calculate the next position and direction of the ball

next :: (Monad m) => WriterT String (StateT MyState (ReaderT Env m)) ()
next = do 
    MyState {position=(posX,posY), direction=(dirX,dirY), velocity = currentSpeed} <- lift get -- get is now on depth 1 (so a single lift)
    Env {frame=(width, height), maxspeed = maxSpeed, acceleration = accelerateFactor} <- lift $ lift ask -- ask is on depth 2 (two lifts)

    -- some variables definitions for easier reading

    let posX' = posX + dirX
        posY' = posY + dirY
        hasCrossedTopEdge = posY' > height
        hasCrossedBottomEdge = posY' < 0
        hasCrossedLeftEdge = posX' < 0
        hasCrossedRightEdge = posX' > width
        
        dirXFinal = if hasCrossedLeftEdge || hasCrossedRightEdge then (-dirX) else dirX
        dirYFinal = if hasCrossedTopEdge || hasCrossedBottomEdge then (-dirY) else dirY
        posXFinal = if hasCrossedLeftEdge || hasCrossedRightEdge
                        then posX + dirXFinal
                        else posX'
        posYFinal = if hasCrossedTopEdge || hasCrossedBottomEdge
                        then posY + dirYFinal
                        else posY'
        newSpeed  = if hasCrossedLeftEdge || hasCrossedRightEdge ||
                         hasCrossedTopEdge || hasCrossedBottomEdge 
                          then changeSpeed maxSpeed currentSpeed accelerateFactor -- changeSpeed if bounce
                          else currentSpeed

        -- create a new updated state
        newState = MyState {position=(posXFinal,posYFinal), direction=(dirXFinal,dirYFinal), velocity = newSpeed }
    
    -- update the newState
    lift $ put newState -- depth 1 (state under writer)

    -- concatenates the new log to the previous one
    tell $ show newState ++ "\n"