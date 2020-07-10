local class = require('lib/middleclass')
local Particle = require('particle')

local PSpawner = class('PSpawner')


function PSpawner:init(x, y, w, h, vx, vy, vr, t)
	self.x, self.y = x, y
	self.w, self.h = w, h
	
	assert(type(x) == 'number' and type(y) == 'number',
		 'expected number as particle spawner location')
	assert(type(w) == 'number' and type(h) == 'number',
		 'expected number as particle spawner dimension')
	
	self.vx, self.vy = vx or 0, vy or 0
	self.angular_speed = vr or 0
	self.particle_timer = t or 0.1
	self.spread = 0
	self.angle = 0
end


function PSpawner:_get_pos()
	local x = (self.x - self.w / 2) + math.random() * self.w 
	local y = (self.y - self.h / 2) + math.random() * self.h 
	return x, y
end


function PSpawner:spawn()
	local x, y = self:_get_pos()
	print(self.angular_speed, self.angle)
	local p = Particle(x, y, self.angle, 1, 1, self.particle_timer)
	return p
end


function PSpawner:update(dt)
	self.x = self.x + self.vx
	self.y = self.y + self.vy
	self.angle = self.angle + self.angular_speed
end


return PSpawner