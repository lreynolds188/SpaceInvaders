require("barrier");
require("barrierBottomLeft");
require("barrierBottomRight");
require("barrierTopLeft");
require("barrierTopRight");
require("bullet");
require("enemyBullet");
require("enemy1");
require("enemy2");
require("enemy3");
require("player");
require("score");
require("lives");
require("level");
require("background");

-- @author Luke Aaron Reynolds - lreynolds188@gmail.com

function love.load()

	-- gameStates: menu, highScores, help, settings, game, gameover
	gameState = "menu";
	w, h = love.window.getDimensions();
	love.graphics.setBackgroundColor(0,0,0);
	newLives = lives:new();
	newScore = score:new();
	newBackground = background:new();
	newLevel = level:new("Level 1");
	
	shootSound = love.audio.newSource("SoundEffects/shoot.wav");
	gameoverSound = love.audio.newSource("SoundEffects/explosion.wav");
	invaderDeathSound = love.audio.newSource("SoundEffects/invaderkilled.wav")
	sound = true;
	laser = false;
		
end

function love.draw()

	default = love.graphics.newFont(12);
	menuFont = love.graphics.newFont(55);
	titleFont = love.graphics.newFont(70);
	highScoreTitleFont = love.graphics.newFont(60);
	highScoreFont = love.graphics.newFont(45);
	smallFont = love.graphics.newFont(30);	
	
	if(gameState == "game") then
		
			newBackground:draw();
			newPlayer:draw();
			newScore:draw();
			newLives:draw();
			newLevel:draw();
			
			for key, value in pairs(enemies1) do
				value:draw();
			end
			
			for key, value in pairs(enemies2) do
				value:draw();
			end
			
			for key, value in pairs(enemies3) do
				value:draw();
			end
			
			for key, value in pairs(bullets) do
				value:draw();
			end
			
			for key, value in pairs(enemyBullets) do
				value:draw();
			end
			
			for key, value in pairs(barriers) do
				value:draw();
			end
			
		
	elseif (gameState == "menu") then
		
		love.graphics.setFont(titleFont);
		love.graphics.setColor(0, 255, 0);
		
		love.graphics.printf("SPACE INVADERS", w / 2 - 355, 25, 700, "center", 0);
		
		love.graphics.setFont(smallFont);
		love.graphics.setColor(255, 0, 0);
		
		love.graphics.printf("Press the corresponding number to select an action", w / 2 - 265, 125, 500, "center", 0);
		
		love.graphics.setFont(menuFont);
		love.graphics.printf("1: NEW GAME", w / 2 - 265, 200, 500, "center", 0);
		
		love.graphics.printf("2: HIGH SCORES", w / 2 - 265, 280, 500, "center", 0);
		
		love.graphics.printf("3: HELP", w / 2 - 265, 360, 500, "center", 0);
		
		love.graphics.printf("4: SETTINGS", w / 2 - 265, 440, 500, "center", 0);
		
		love.graphics.setColor(255, 255, 255);
		love.graphics.setFont(default);
		
	elseif (gameState == "highScores") then

		love.graphics.setFont(highScoreTitleFont);
		love.graphics.setColor(0, 255, 0);
		
		love.graphics.printf("HIGH SCORES", w / 2 - 355, 25, 700, "center", 0);
		
		love.graphics.setFont(highScoreFont);
		love.graphics.setColor(255, 0, 0);
		
		local highScores = io.open("highScores.txt", "r");
		
		for i = 1, 10 do
			tempHighScore = tostring(highScores:read("*line"));
			love.graphics.printf(tempHighScore, w / 2 - 265, 40 + 50 * i, 500, "center", 0);
		end
		
		highScores:close();
		love.graphics.setColor(255, 255, 255);
		love.graphics.setFont(default);
		
	elseif (gameState == "help") then

		love.graphics.setFont(titleFont);
		love.graphics.setColor(0, 255, 0);
		
		love.graphics.printf("HELP", w / 2 - 355, 25, 700, "center", 0);
		
		love.graphics.setFont(highScoreFont);
		love.graphics.setColor(255, 0, 0);
		
		love.graphics.printf("Left Arrow: Move Left", w / 2 - 265, 125, 800, "left", 0);
		
		love.graphics.printf("Right Arrow: Move Right", w / 2 - 265, 205, 800, "left", 0);
		
		love.graphics.printf("Spacebar: Shoot", w / 2 - 265, 285, 800, "left", 0);
		
		love.graphics.printf("Escape: Menu / Quit", w / 2 - 265, 365, 800, "left", 0);
		
		love.graphics.printf("Enter: New Game", w / 2 - 265, 445, 800, "left", 0);
		
		love.graphics.printf("S: Toggle Sound", w / 2 - 265, 525, 800, "left", 0);
		
		love.graphics.setColor(255, 255, 255);
		love.graphics.setFont(default);

	elseif (gameState == "settings") then

		love.graphics.setFont(titleFont);
		love.graphics.setColor(0, 255, 0);
		love.graphics.printf("SETTINGS", w / 2 - 355, 25, 700, "center", 0);

		love.graphics.setFont(smallFont);
		love.graphics.setColor(255, 0, 0);
		love.graphics.printf("Select the colour you would like for the game's colour scheme", w / 2 - 265, 125, 500, "center", 0);
		
		love.graphics.setColor(255, 255, 255);
		love.graphics.setFont(default);

		love.graphics.setColor(255, 0, 0);
		love.graphics.rectangle("fill", 170, 250, 120, 60 );
		love.graphics.setColor(0, 255, 0);
		love.graphics.rectangle("fill", 330, 250, 120, 60 );
		love.graphics.setColor(0, 0, 255);
		love.graphics.rectangle("fill", 170, 350, 120, 60 );
		love.graphics.setColor(255, 0, 255);
		love.graphics.rectangle("fill", 330, 350, 120, 60 );
		love.graphics.setColor(0, 255, 255);
		love.graphics.rectangle("fill", 490, 250, 120, 60 );
		love.graphics.setColor(177, 177, 177);
		love.graphics.rectangle("fill", 490, 350, 120, 60 );
		love.graphics.setColor(255, 255, 255);

	elseif (gameState == "gameover") then

		love.graphics.setFont(titleFont);
		love.graphics.setColor(255, 0, 0);
		love.graphics.printf("Game Over!\nPress Enter To Play Again", w / 2 - 265, h / 2 - 100, 500, "center", 0);
		
		love.graphics.setFont(smallFont);
		love.graphics.setColor(0, 255, 0);
		love.graphics.printf("Your score was: " .. newScore.currentScore, w / 2 - 265, 125, 500, "center", 0);
		
		love.graphics.setColor(255, 255, 255);
		love.graphics.setFont(default);	
	
	elseif (gameState == "win") then
		
		love.graphics.setFont(titleFont);
		love.graphics.setColor(0, 255, 0);
		love.graphics.printf("You Win!\nPress Enter To Play Again", w / 2 - 265, h / 2 - 100, 500, "center", 0);
		
		love.graphics.setFont(smallFont);
		love.graphics.setColor(0, 255, 0);
		love.graphics.printf("Your score was: " .. newScore.currentScore, w / 2 - 265, 125, 500, "center", 0);

		love.graphics.setColor(255, 255, 255);
		love.graphics.setFont(default);	

	end	
end

function love.update(dt)

	if(gameState == "game") then					
			totalTime = totalTime + dt;		
						
			if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
				newPlayer:input(0);
			elseif love.keyboard.isDown("left") and newPlayer.x > 0 then
				newPlayer:input(-200);
			elseif love.keyboard.isDown("right") and newPlayer.x < w - newPlayer.w then
				newPlayer:input(200);
			else
				newPlayer:input(0);
			end
			
			newBackground:update(dt);
			newPlayer:update(dt);
			
			for key, value in pairs(bullets) do
				value:update(dt);
			end
			
			for key, value in pairs(enemyBullets) do
				value:update(dt);
			end
			
			if (newLives.currentLives == 0) then
				gameState = "gameover";
			end
			
			if (totalTime >= 0.5) then
				totalTime = 0;
				randomBulletChance = math.random(10);
			end
			
			if (randomBulletChance >= 5) then
				randomBulletChance = 0;
				if(#enemies1 == 0 and #enemies2 == 0 and #enemies3 == 0) then
					randomShipType = 0;
				elseif(#enemies1 == 0 and #enemies2 == 0) then
					randomShipType = 3;
				elseif(#enemies1 == 0 and #enemies3 == 0) then
					randomShipType = 2;
				elseif(#enemies2 == 0 and #enemies3 == 0) then
					randomShipType = 1;
				elseif(#enemies1 == 0) then
					temp = math.random(2);
					if(temp == 1) then
						randomShipType = 2;
					else 
						randomShipType = 3;
					end
				elseif(#enemies2 == 0) then
					temp = math.random(2);
					if(temp == 1) then
						randomShipType = 1;
					else 
						randomShipType = 3;
					end
				elseif(#enemies3 == 0) then
					randomShipType = math.random(2);
				else
					randomShipType = math.random(3);
				end
				
				if (randomShipType == 1) then
					selectedEnemy = enemies1[math.random(#enemies1)];
				elseif (randomShipType == 2) then
					selectedEnemy = enemies2[math.random(#enemies2)];
				elseif (randomShipType == 3) then
					selectedEnemy = enemies3[math.random(#enemies3)];
				end
				
				table.insert(enemyBullets, enemyBullet:new(selectedEnemy.x + ((selectedEnemy.w / 2) - 3), selectedEnemy.y + selectedEnemy.h - 10));
			end
					
			for keyEnemy, valueEnemy in pairs(enemies1) do
				valueEnemy:update(dt);
				if valueEnemy.y + valueEnemy.h >= h then
					gameState = "gameover";
				end
				if(collide(valueEnemy:hitbox(), newPlayer:hitbox())) then
					gameState = "gameover";
				end
				for keyBullet, valueBullet in pairs(bullets) do
					if(collide(valueBullet:hitbox(), valueEnemy:hitbox())) then
						table.remove(enemies1, keyEnemy);
						table.remove(bullets, keyBullet);
						if(sound) then
							love.audio.play(invaderDeathSound);
						end
						newScore:input(5);
					end
				end
			end
			
			for keyEnemy, valueEnemy in pairs(enemies2) do
				valueEnemy:update(dt);
				if valueEnemy.y + valueEnemy.h >= h then
					gameState = "gameover";
				end
				if(collide(valueEnemy:hitbox(), newPlayer:hitbox())) then
					gameState = "gameover";
				end
				for keyBullet, valueBullet in pairs(bullets) do
					if(collide(valueBullet:hitbox(), valueEnemy:hitbox())) then
						table.remove(enemies2, keyEnemy);
						table.remove(bullets, keyBullet);
						if(sound) then
							love.audio.play(invaderDeathSound);
						end
						newScore:input(10);
					end
				end
			end
			
			for keyEnemy, valueEnemy in pairs(enemies3) do
				valueEnemy:update(dt);
				if valueEnemy.y + valueEnemy.h >= h then
					gameState = "gameover";
				end
				if(collide(valueEnemy:hitbox(), newPlayer:hitbox())) then
					gameState = "gameover";
				end
				for keyBullet, valueBullet in pairs(bullets) do
					if(collide(valueBullet:hitbox(), valueEnemy:hitbox())) then
						table.remove(enemies3, keyEnemy);
						table.remove(bullets, keyBullet);
						if(sound) then
							love.audio.play(invaderDeathSound);
						end
						newScore:input(20);
					end
				end
			end
			
			for keyBarrier, valueBarrier in pairs(barriers) do
				for keyBullet, valueBullet in pairs(bullets) do
					if(collide(valueBullet:hitbox(), valueBarrier:hitbox())) then
						table.remove(barriers, keyBarrier);
						table.remove(bullets, keyBullet);
					end
				end
				for keyBullet, valueBullet in pairs(enemyBullets) do
					if(collide(valueBullet:hitbox(), valueBarrier:hitbox())) then
						table.remove(barriers, keyBarrier);
						table.remove(enemyBullets, keyBullet);
					end
				end				
			end
			
			for keyBullet, valueBullet in pairs(enemyBullets) do
					if(collide(valueBullet:hitbox(), newPlayer:hitbox())) then
						table.remove(enemyBullets, keyBullet);
						if(sound) then
							love.audio.play(gameoverSound);
						end
						newLives:input(-1);
					end
			end	
			
			for keyBarrier, valueBarrier in pairs(barriers) do
				for keyEnemy1, valueEnemy1 in pairs(enemies1) do
					if(collide(valueBarrier:hitbox(), valueEnemy1:hitbox())) then
						gameState = "gameover";
					end
				end
				for keyEnemy2, valueEnemy2 in pairs(enemies2) do
					if(collide(valueBarrier:hitbox(), valueEnemy2:hitbox())) then
						gameState = "gameover";
					end
				end
				for keyEnemy3, valueEnemy3 in pairs(enemies3) do
					if(collide(valueBarrier:hitbox(), valueEnemy3:hitbox())) then
						gameState = "gameover";
					end
				end
			end
		
			if #enemies1 == 0 and #enemies2 == 0 and #enemies3 == 0 then
				if (newLevel.currentLevel == "Level 1") then
					newLevel:input("Level 2");
					newLives = lives:new();
					newGame();
				elseif (newLevel.currentLevel == "Level 2") then
					newLevel:input("Level 3");
					newLives = lives:new();
					newGame();
				elseif (newLevel.currentLevel == "Level 3") then
					newLevel:input("Level 4");
					newLives = lives:new();
					newGame();
				elseif (newLevel.currentLevel == "Level 4") then
					newLevel:input("Level 5");
					newLives = lives:new();
					newGame();
				elseif (newLevel.currentLevel == "Level 5") then
					newLevel:input("Level 1");
					gameState = "win";
				end
			end
	end
end

function love.keypressed(key)
	
	if(gameState == "game") then
		if(key == " ") then
			
			if(sound) then
			love.audio.stop(shootSound);
			love.audio.play(shootSound);
			end

			if(laser) then
				for i = 0, 550, 10 do
					table.insert(bullets, bullet:new(newPlayer.x + (newPlayer.w / 2) - 3, i));
				end
			else
				table.insert(bullets, bullet:new(newPlayer.x + (newPlayer.w / 2) - 3, 550));
			end
		
		elseif(key == "l") then
			laser = not laser;
		elseif(key == "return") then
			newLevel:input("Level 1");
			newLives = lives:new();
			newScore = score:new();
			newGame();
		elseif(key == "escape") then
			gameState = "menu";
		elseif(key == "s") then
			sound = not sound;
		end		
	elseif (gameState == "menu") then
		if(key == "1") then
			gameState = "game";
			newGame();
		elseif(key == "2") then
			gameState = "highScores";
		elseif(key == "3") then
			gameState = "help";
		elseif(key == "4") then
			gameState = "settings";
		elseif(key == "escape") then
			os.exit();
		end		
	elseif (gameState == "highScores") then
		if(key == "escape") then
			gameState = "menu";
		end
	elseif (gameState == "help") then
		if(key == "escape") then
			gameState = "menu";
		end
	elseif (gameState == "settings") then
		if(key == "escape") then
			gameState = "menu";
		end
	elseif (gameState == "gameover") then
		if(key == "return") then
			newLevel:input("Level 1");
			newLives = lives:new();
			newScore = score:new();
			newGame();
			gameState = "game";
		elseif(key == "escape") then
			gameState = "menu";
		end
	elseif (gameState == "win") then
		if(key == "return") then
			newLevel:input("Level 1");
			newLives = lives:new();
			newScore = score:new();
			newGame();
			gameState = "game";
		elseif(key == "escape") then
			gameState = "menu";
		end
	end
end

function newGame()

	enemies1 = {};
	enemies2 = {};
	enemies3 = {};
	selectedEnemy = {};
	bullets = {};
	enemyBullets = {};
	barriers = {};
	
	newPlayer = player:new();
	
	randomShip = 0;
	randomShipType = 0;
	randomBulletChance = 0;
	totalTime = 0;
		
	for i = 1, 20 do
			if(newLevel.currentLevel == "Level 1") then
				enemy1.xvel = 50;
				enemy1.yvel = 50;
				enemy1.startTimeRight = 3;
				enemy1.startTimeDown = 3.5;
				enemy1.startTimeLeft = 6.5;
				enemy1.startTimeDown2 = 7;
			elseif(newLevel.currentLevel == "Level 2") then
				enemy1.xvel = 62.5;
				enemy1.yvel = 62.5;
				enemy1.startTimeRight = 2.625;
				enemy1.startTimeDown = 3.0625;
				enemy1.startTimeLeft = 5.6875;
				enemy1.startTimeDown2 = 6.125;
			elseif(newLevel.currentLevel == "Level 3") then
				enemy1.xvel = 75;
				enemy1.yvel = 75;
				enemy1.startTimeRight = 2.25;
				enemy1.startTimeDown = 2.625;
				enemy1.startTimeLeft = 4.875;
				enemy1.startTimeDown2 = 5.25;
			elseif(newLevel.currentLevel == "Level 4") then
				enemy1.xvel = 87.5;
				enemy1.yvel = 87.5;
				enemy1.startTimeRight = 2.0625;
				enemy1.startTimeDown = 2.1875;
				enemy1.startTimeLeft = 4.0625;
				enemy1.startTimeDown2 = 4.375;
			elseif(newLevel.currentLevel == "Level 5") then
				enemy1.xvel = 100;
				enemy1.yvel = 100;
				enemy1.startTimeRight = 1.5;
				enemy1.startTimeDown = 1.75;
				enemy1.startTimeLeft = 3.25;
				enemy1.startTimeDown2 = 3.5;
			end
			
			if(#enemies1 < 10) then
				enemy1.x = 30 + (60 * #enemies1);
				enemy1.y = 200;
			else
				enemy1.x = 30 + (60 * (#enemies1 - 10));
				enemy1.y = 250;
			end
			table.insert(enemies1, enemy1:new());
	end
	
	for i = 1, 20 do
			if(newLevel.currentLevel == "Level 1") then
				enemy2.xvel = 50;
				enemy2.yvel = 50;
				enemy2.startTimeRight = 3;
				enemy2.startTimeDown = 3.5;
				enemy2.startTimeLeft = 6.5;
				enemy2.startTimeDown2 = 7;
			elseif(newLevel.currentLevel == "Level 2") then
				enemy2.xvel = 62.5;
				enemy2.yvel = 62.5;
				enemy2.startTimeRight = 2.625;
				enemy2.startTimeDown = 3.0625;
				enemy2.startTimeLeft = 5.6875;
				enemy2.startTimeDown2 = 6.125;
			elseif(newLevel.currentLevel == "Level 3") then
				enemy2.xvel = 75;
				enemy2.yvel = 75;
				enemy2.startTimeRight = 2.25;
				enemy2.startTimeDown = 2.625;
				enemy2.startTimeLeft = 4.875;
				enemy2.startTimeDown2 = 5.25;
			elseif(newLevel.currentLevel == "Level 4") then
				enemy2.xvel = 87.5;
				enemy2.yvel = 87.5;
				enemy2.startTimeRight = 2.0625;
				enemy2.startTimeDown = 2.1875;
				enemy2.startTimeLeft = 4.0625;
				enemy2.startTimeDown2 = 4.375;
			elseif(newLevel.currentLevel == "Level 5") then
				enemy2.xvel = 100;
				enemy2.yvel = 100;
				enemy2.startTimeRight = 1.5;
				enemy2.startTimeDown = 1.75;
				enemy2.startTimeLeft = 3.25;
				enemy2.startTimeDown2 = 3.5;
			end
			
			if(#enemies2 < 10) then
				enemy2.x = 30 + (60 * #enemies2);
				enemy2.y = 100
			else
				enemy2.x = 30 + (60 * (#enemies2 - 10));
				enemy2.y = 150;
			end
			table.insert(enemies2, enemy2:new());
	end
	
	for i = 1, 10 do
			if(newLevel.currentLevel == "Level 1") then
				enemy3.xvel = 50;
				enemy3.yvel = 50;
				enemy3.startTimeRight = 3;
				enemy3.startTimeDown = 3.5;
				enemy3.startTimeLeft = 6.5;
				enemy3.startTimeDown2 = 7;
			elseif(newLevel.currentLevel == "Level 2") then
				enemy3.xvel = 62.5;
				enemy3.yvel = 62.5;
				enemy3.startTimeRight = 2.625;
				enemy3.startTimeDown = 3.0625;
				enemy3.startTimeLeft = 5.6875;
				enemy3.startTimeDown2 = 6.125;
			elseif(newLevel.currentLevel == "Level 3") then
				enemy3.xvel = 75;
				enemy3.yvel = 75;
				enemy3.startTimeRight = 2.25;
				enemy3.startTimeDown = 2.625;
				enemy3.startTimeLeft = 4.875;
				enemy3.startTimeDown2 = 5.25;
			elseif(newLevel.currentLevel == "Level 4") then
				enemy3.xvel = 87.5;
				enemy3.yvel = 87.5;
				enemy3.startTimeRight = 2.0625;
				enemy3.startTimeDown = 2.1875;
				enemy3.startTimeLeft = 4.0625;
				enemy3.startTimeDown2 = 4.375;
			elseif(newLevel.currentLevel == "Level 5") then
				enemy3.xvel = 100;
				enemy3.yvel = 100;
				enemy3.startTimeRight = 1.5;
				enemy3.startTimeDown = 1.75;
				enemy3.startTimeLeft = 3.25;
				enemy3.startTimeDown2 = 3.5;
			end
			enemy3.x = 35 + (60 * #enemies3);
			enemy3.y = 50;
			table.insert(enemies3, enemy3:new());
	end
	
	for i = 1, 4 do
		barrierTopLeft.x = 100 + (170 * #barriers);
		barrierTopLeft.y = 500;
		table.insert(barriers, barrierTopLeft:new());
	end
	
	for i = 1, 4 do
		barrierTopRight.x = 148 + (170 * (#barriers - 4));
		barrierTopRight.y = 500;
		table.insert(barriers, barrierTopRight:new());
	end
	
	for i = 1, 4 do
		barrierBottomLeft.x = 100 + (170 * (#barriers - 8));
		barrierBottomLeft.y = 532;
		table.insert(barriers, barrierBottomLeft:new());
	end
	
	for i = 1, 4 do
		barrierBottomRight.x = 148 + (170 * (#barriers - 12));
		barrierBottomRight.y = 532;
		table.insert(barriers, barrierBottomRight:new());
	end
	
	for i = 1, 24 do
		-- top 1
		if #barriers - 16 < 4 then
			barrier.x = 116 + (170 * (#barriers - 16));
			barrier.y = 500;
		-- top 2
		elseif #barriers - 20 < 4 then
			barrier.x = 132 + (170 * (#barriers - 20));
			barrier.y = 500;
		-- bottom 1
		elseif #barriers - 24 < 4 then
			barrier.x = 100 + (170 * (#barriers - 24));
			barrier.y = 516;
		-- bottom 2
		elseif #barriers - 28 < 4 then
			barrier.x = 116 + (170 * (#barriers - 28));
			barrier.y = 516;
		-- bottom 3
		elseif #barriers - 32 < 4 then
			barrier.x = 132 + (170 * (#barriers - 32));
			barrier.y = 516;
		-- bottom 4
		elseif #barriers - 36 < 4 then
			barrier.x = 148 + (170 * (#barriers - 36));
			barrier.y = 516;
		end
		table.insert(barriers, barrier:new());
	end		
		
end

function collide(box1, box2)
	
	return 	box1.x < box2.x + box2.w and
			box1.x + box1.w > box2.x and
			box1.y < box2.y + box2.h and
			box2.y < box1.y + box1.h
	
end
