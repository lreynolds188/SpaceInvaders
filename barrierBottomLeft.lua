barrierBottomLeft = 
{
	
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	sprite = love.graphics.newImage("barrierBottomLeft.png");
	
}

function barrierBottomLeft:new()

	local tbl = {};
	
	for key, value in pairs(barrierBottomLeft) do
		tbl[key] = value;
	end
	
	tbl.x = self.x;
	tbl.y = self.y;
	tbl.w, tbl.h = tbl.sprite:getDimensions();
	return tbl;

end

function barrierBottomLeft:draw()

	love.graphics.draw(self.sprite, self.x, self.y);

end

function barrierBottomLeft:hitbox()

	local tbl = {x = self.x, y = self.y, w = self.w, h = self.h};
	return tbl;

end
