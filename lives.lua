lives = 
{
	
	currentLives = 3;
	sprite = love.graphics.newImage("player.png");
	x = 510;
	y = 5;
	
}

function lives:new()
	
	local tbl = {}
	
	for key, value in pairs(lives) do
		tbl[key] = value;
	end
	
	tbl.currentLives = self.currentLives;
	
	return tbl;
	
end

function lives:draw()

	love.graphics.setColor(0, 255, 0);
	love.graphics.print("Lives: ", 500, 10, 0, 2);
	love.graphics.setColor(255,255,255);
	for i = 1, self.currentLives do
		love.graphics.draw(self.sprite, self.x + (70 * i), self.y);
	end

end

function lives:input(lives)

	self.currentLives = self.currentLives + lives;
	
end
