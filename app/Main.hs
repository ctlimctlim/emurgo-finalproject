module Main where
    
import Control.Monad.Trans.State.Lazy
import Control.Monad.Trans.Writer.CPS
import Control.Monad.Trans.Reader

import Control.Monad.Trans.Class (lift)
import Animation.Animate (animateS)
import Animation.CLI (cli)
import Animation.State

--------------------------------------------------------------------------------
-- main

main :: IO ()
main = do
    (env@(Env{numofmoves = nmoves}), mstate) <- cli -- cli :: IO (Env, MyState)
    

    putStrLn ("\nYour current enivronment is " ++ show (env))
    putStrLn ("\nYour current state is " ++ show (mstate))
    putStrLn "\nHello! Press [Enter] to start \n" -- press key to start animation!
    getChar
    
    let
        -- Initally -
        -- WriterT String StateT MyState (ReaderT Env IO ) ()
        
        unwrapWriter = runWriterT (animateS nmoves)
        -- StateT MyState (ReaderT Env IO ) ((),String)
        
        unwrapState  = evalStateT unwrapWriter mstate
        --  stateOut :: ReaderT Env IO  ((),String)
        
        unwrapReader = runReaderT unwrapState env
        --  readerOut :: IO  ((),String)
        

    (_,log) <- unwrapReader -- get the String out (log)
    writeFile "log.txt" log

    putStrLn "\nAnimation Ended!\n" 

    return ()