Class = require 'class'
scaleinator = require("scaleinator")
scale = scaleinator.create()
require 'Player'
require 'Enemy'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
MOVEMENT_SPEED = 1100
ENEM_MOVEMENT_SPEED = 800

function love.load()
    love.window.setTitle('Dodge')
    math.randomseed(os.time())

    sounds = {
        ['explosion'] = love.audio.newSource('Explosion.wav', 'static'),
        ['gameover'] = love.audio.newSource('GameOver.wav', 'static')
    }

    smallFont = love.graphics.newFont('Road_Rage.otf', 20)
    largeFont = love.graphics.newFont('Road_Rage.otf', 32)
    love.graphics.setFont(smallFont)

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    enemy = Enemy(math.random(1,1120),-150,150,150,ENEM_MOVEMENT_SPEED)
    player = Player(WINDOW_WIDTH/2-30, 450, 50, 200)
    playerHealth = 5

    gameState = 'start'
end

local score = 0
function love.update(dt)
    if gameState == 'play' then
        updateScore()
        if love.keyboard.isDown('left') then
            player.dx = -MOVEMENT_SPEED
        elseif love.keyboard.isDown('right') then
            player.dx = MOVEMENT_SPEED
        else 
            player.dx = 0
        end
        player.dx = player.dx +dt * 40
        player:update(dt)
        enemy.dy = enemy.dy + dt * 10
        enemy:update(dt)

        if enemy:collides(player) then
            playerHealth = playerHealth - 1
            if playerHealth > 0 then
                sounds['explosion']:play()
            end
            if playerHealth == 0 then 
                gameState = 'dead'
                sounds['gameover']:play()
            end
        end

    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if gameState == 'dead' then 
        if key == 'enter' or key == 'return' then
            playerHealth = 5
            player.x = WINDOW_WIDTH/2-30
            player.dx = 1100
            enemy.dy = 800
            score = 0
            gameState = 'start'
        end
    end
    if key == 'enter' or key == 'return' then
        gameState = 'play'
    end


end

function love.draw()
    love.graphics.clear(40/255,45/255,52/255,0)

    if gameState == 'start' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Welcome to Dodge! Press enter to start!', 0, (love.graphics.getWidth()/2)-300, (love.graphics.getHeight()/2)+900, 'center')
    elseif gameState =='play' then
        love.graphics.setFont(largeFont)
        enemy:render()
        if score < 1.5 then
            love.graphics.printf('Enjoy!', 0, (love.graphics.getWidth()/2)-300, (love.graphics.getHeight()/2)+900, 'center')
        else

        end
    elseif gameState == 'dead' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('YOU DIED! PRESS ENTER TO PLAY AGAIN', 0, (love.graphics.getWidth()/2)-300, (love.graphics.getHeight()/2)+900, 'center')
    end
    displayHP()
    displayScore()
    player:render()

end

function displayHP()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('HP: '..tostring(playerHealth), 1200, 10)
    love.graphics.setColor(255,255,255,255)
end
function updateScore()
    score = score + 1
end
function displayScore()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print('Score:'..tostring(math.floor(score+0.5)), 10, 10)
    
end
