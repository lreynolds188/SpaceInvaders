score = 
{
	currentScore = 0;
}

function score:new()
	
	local tbl = {};
	
	for key, value in pairs(score) do
		tbl[key] = value;
	end
	
	tbl.currentScore = self.currentScore;
	
	return tbl;
	
end

function score:draw()

	love.graphics.setColor(0, 255, 0);
	love.graphics.print("Score: " .. self.currentScore, 10, 5, 0, 2);
	love.graphics.setColor(255,255,255);

end

function score:input(points)

	self.currentScore = self.currentScore + points;

end
