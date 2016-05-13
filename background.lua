background = 
{

	x = 0;
	y = -600;
	yvel = 50;
	sprite = love.graphics.newImage("background.png");
	
}

function background:new()

	tbl = {};
	
	for key, value in pairs(background) do
		tbl[key] = value;
	end
	
	tbl.x = self.x;
	tbl.y = self.y;
	tbl.yvel = self.yvel;
	tbl.sprite = self.sprite;
	
	return tbl;

end	

function background:draw()

	love.graphics.draw(self.sprite, self.x, self.y)

end

function background:update(dt)

	if(self.y >= 0) then
		self.y = -600;
	end

	self.y = self.y + (self.yvel * dt);

end
