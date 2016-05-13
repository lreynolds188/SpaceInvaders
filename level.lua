level =
{

	currentLevel = "Level 1";

}

function level:new(input)

	local tbl = {};
	
	for key, value in pairs(level) do
		tbl[key] = value;
	end
	
	self.currentLevel = input;
	
	tbl.currentLevel = self.currentLevel;
	
	return tbl;

end	

function level:draw()

	love.graphics.setColor(0, 255, 0);
	love.graphics.print(self.currentLevel, 180, 5, 0, 2);
	love.graphics.setColor(255, 255, 255);

end

function level:input(level)

	self.currentLevel = level;

end
