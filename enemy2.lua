enemy2 = 
{

x = 0;
y = 0;
sprite = love.graphics.newImage("enemy2.png");
w = 0;
h = 0;
xvel = 50;
yvel = 50;
totalDt = 0;

startTimeRight = 3;
startTimeDown = 3.5;
startTimeLeft = 6.5;
startTimeDown2 = 7;

}

function enemy2:new()

	local tbl = {};
	
	for key, value in pairs (enemy2) do
		tbl[key] = value;
	end
	
	tbl.w, tbl.h = tbl.sprite:getDimensions();
	
	tbl.x = self.x;
	tbl.y = self.y;
	
	return tbl;

end

function enemy2:draw()

	love.graphics.draw(self.sprite, self.x, self.y);
	
end

function enemy2:update(dt)

	self.totalDt = self.totalDt + dt;
	if self.totalDt <= self.startTimeRight then
		self.x = self.x + (self.xvel * dt);
	elseif self.totalDt <= self.startTimeDown then
		self.y = self.y + (self.yvel * dt);
	elseif self.totalDt <= self.startTimeLeft then
		self.x = self.x - (self.xvel * dt);
	elseif self.totalDt <= self.startTimeDown2 then
		self.y = self.y + (self.yvel * dt);
	else
		self.totalDt = 0;
	end
	
end

function enemy2:hitbox()

	local tbl = {x = self.x, y = self.y, w = self.w, h = self.h}
	return tbl;

end
