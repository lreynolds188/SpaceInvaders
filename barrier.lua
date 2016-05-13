barrier = 
{
	
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	sprite = love.graphics.newImage("barrier.png");
	
}

function barrier:new()

	local tbl = {};
	
	for key, value in pairs(barrier) do
		tbl[key] = value;
	end
	
	tbl.x = self.x;
	tbl.y = self.y;
	tbl.w, tbl.h = tbl.sprite:getDimensions();
	return tbl;

end

function barrier:draw()

	love.graphics.draw(self.sprite, self.x, self.y);

end

function barrier:hitbox()

	local tbl = {x = self.x, y = self.y, w = self.w, h = self.h};
	return tbl;

end
