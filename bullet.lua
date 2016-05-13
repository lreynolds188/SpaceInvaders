bullet = 
{

	x = 0;
	y = 550;
	w = 0;
	h = 0;
	yvel = -100;
	sprite = love.graphics.newImage("bullet.png");
	
}

function bullet:new(x, y)

	self.x = x;
	self.y = y;

	local tbl = {};
	
	for key, value in pairs(bullet) do
		tbl[key] = value;
	end
	
	tbl.w, tbl.h = tbl.sprite:getDimensions();
	return tbl;

end

function bullet:draw()
	
	love.graphics.draw(self.sprite, self.x, self.y);
	
end

function bullet:update(dt)
	
	self.y = self.y + (self.yvel * dt);
	
end

function bullet:hitbox()

	local tbl = {x = self.x, y = self.y, w = self.w, h = self.h}
	return tbl;

end
