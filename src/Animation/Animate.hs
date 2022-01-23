module Animation.Animate where

import Animation.State
import Animation.Draw
import Animation.Auxiliary (clearScreen, getInterval)

import Control.Monad.Trans.State.Lazy
import Control.Monad.Trans.Writer.CPS
import Control.Monad.Trans.Reader

import Control.Concurrent (threadDelay)
import Control.Monad.Trans.Class (lift)

-- Type for Monad Transformer
-- There are 4 monads: Writer, State, Reader and IO
type AppM a = WriterT String (StateT MyState (ReaderT Env IO )) a

--------------------------------------------------------------------------------
-- animateS to perform the animation 

-- The no. of iterations of (animation) need to be fixed (using countdown)
-- so that program can terminate and get the log out!

animateS :: Int -> AppM ()
animateS countdown = do
    
    -- create lift (lift2, lift 3) by composition for easy reading
    let 
      lift2 = lift . lift
      lift3 = lift . lift2

    lift3 clearScreen
    output <- lift drawState -- get the String (the enclosure and ball) out
    lift3 $ putStr output

    MyState {velocity = currentSpeed} <- lift get -- get current speed to calculate threadDelay
    lift3 $ threadDelay (round (getInterval currentSpeed))
    
    next -- update the next State

    if countdown > 0
      then animateS (countdown -1) -- if countdown is greater than 0 keep animating 
      else return () -- but if it's not, end the animation :( 

--------------------------------------------------------------------------------

