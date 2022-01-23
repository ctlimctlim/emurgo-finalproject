module Animation.Draw where

import Animation.State

import Control.Monad.Trans.State.Lazy
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Class (lift)

--------------------------------------------------------------------------------
-- drawState - to 'paint' the enclosure and positionof the ball

drawState :: Monad m => StateT MyState (ReaderT Env m) String 
drawState = do 
    
    env@Env {frame=(_,height)} <- lift ask -- depth 1 (reader under state)
    mstate <- get -- depth 0 (no lift required)
    
    return $ unlines $ reverse $ map (\row -> drawRow env mstate row) [-1..height+1]

drawRow :: Env -> MyState -> Int -> String
drawRow env@(Env (width, _) _ _ _) mstate row = map (\col -> charAt env mstate (col, row)) [-1..width+1]

charAt :: Env -> MyState -> Vector -> Char
charAt (Env (width, height) _ _ _) (MyState (posX, posY) _ _) (x, y)
  | (posX, posY) == (x, y) = 'o'
  | y < 0 || y > height = '-'
  | x < 0 || x > width = '|'
  | otherwise = ' '
