module Animation.Auxiliary where

-- clearScreen - clear the screen before each drawing of the state

clearScreen :: IO ()
clearScreen = putStr "\ESC[3J\ESC[1;1H"

-- changeSpeed - calculate new speed at each bounce

changeSpeed :: Float -> Float -> Float -> Float
changeSpeed maxspeed nowspeed changefactor = do
    
    if (nowspeed < maxspeed) 
        then do 
            let interimspeed = nowspeed + (nowspeed * (changefactor * 0.1))
            if interimspeed > maxspeed 
                 then maxspeed
            else interimspeed
    else nowspeed

-- getInterval - translate speed in threadDelay interval        

getInterval :: Float -> Float
getInterval currentSpeed = 
    currentSpeed * 100.0
