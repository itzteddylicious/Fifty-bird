--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

-- Minimum score required for earning each trophy
BRONZE = 1
SILVER = 3
GOLD = 5
PLATINUM = 10

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:init()
    self.images = {
        ['bronze'] = love.graphics.newImage('bronze.png'),
        ['silver'] = love.graphics.newImage('silver.png'),
        ['gold'] = love.graphics.newImage('gold.png'),
        ['platinum'] = love.graphics.newImage('platinum.png')
    }
    self.award = ''
end

function ScoreState:enter(params)
    self.score = params.score

    if self.score >= BRONZE and self.score < SILVER then
        self.award = 'bronze'
    elseif self.score >= SILVER and self.score < GOLD then
        self.award = 'silver'
    elseif self.score >= GOLD and self.score < PLATINUM then
        self.award = 'gold'
    elseif self.score >= PLATINUM then
        self.award = 'platinum'
    end

end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.award ~= '' then
        love.graphics.draw(self.images[self.award], (VIRTUAL_WIDTH / 2) - (self.images[self.award]:getWidth() / 2), 118)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end