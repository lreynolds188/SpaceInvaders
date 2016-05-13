player = 
{

x = 390;
y = 560;
w = 0;
h = 0;
xvel = 0;
sprite = love.graphics.newImage("player.png");

}

function player:new()

	local tbl = {};
	
	for key, value in pairs(player) do
		tbl[key] = value;
	end
	
	tbl.w, tbl.h = tbl.sprite:getDimensions();
	return tbl;
	
end

function player:draw()

	love.graphics.draw(self.sprite, self.x, self.y);

end

function player:update(dt)
	
	self.x = self.x + (self.xvel * dt);
	
end

function player:input(direction)

	self.xvel = direction;
	
end

function player:hitbox()

	local tbl = {x = self.x, y = self.y, w = self.w, h = self.h}
	return tbl;

end

