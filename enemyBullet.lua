enemyBullet = 
{

	x = 25;
	y = 25;
	w = 0;
	h = 0;
	yvel = 100;
	sprite = love.graphics.newImage("enemyBullet.png");
	
}

function enemyBullet:new(x, y)

	self.x = x;
	self.y = y;

	local tbl = {};
	
	for key, value in pairs(enemyBullet) do
		tbl[key] = value;
	end
	
	tbl.w, tbl.h = tbl.sprite:getDimensions();
	return tbl;

end

function enemyBullet:draw()
	
	love.graphics.draw(self.sprite, self.x, self.y);
	
end

function enemyBullet:update(dt)
	
	self.y = self.y + (self.yvel * dt);
	
end

function enemyBullet:hitbox()

	local tbl = {x = self.x, y = self.y, w = self.w, h = self.h}
	return tbl;

end
