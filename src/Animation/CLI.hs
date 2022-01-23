module Animation.CLI where

import Animation.State

import System.Environment (getArgs)

--------------------------------------------------------------------------------
-- cli to obtain parameters for initial state, environment and other prarameters

-- (>>=) :: IO a -> (a -> IO b) -> IO b
-- return :: a -> IO a

cli :: IO (Env, MyState)
-- cli = getArgs >>= (\unparsedArgs -> return (parseArgs unparsedArgs))
cli = fmap parseArgs getArgs

parseArgs :: [String] -> (Env, MyState)
parseArgs [frameX, frameY, maxSpeed, accelerate, numMoves, posX, posY, dirX, dirY, nowSpeed] = 
    ((Env (read frameX, read frameY) (read maxSpeed) (read accelerate) (read numMoves)), 
    (MyState (read posX, read posY) (read dirX, read dirY) (read nowSpeed)))
parseArgs _ = error "Format is frameX frameY maxSpeed accelerate numofMoves posX posY dirX dirY nowSpeed"

