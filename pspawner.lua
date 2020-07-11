local class = require('lib/middleclass')
local Particle = require('particle')
local Vec2 = require('lib/vector2')

local PSpawner = class('PSpawner')


function PSpawner:init(x, y, w, h, vx, vy, vr, t)
	self.pos = Vec2:new(x, y)
	self.w, self.h = w, h
	
	assert(type(x) == 'number' and type(y) == 'number',
		 'expected number as particle spawner location')
	assert(type(w) == 'number' and type(h) == 'number',
		 'expected number as particle spawner dimension')
	self.particle_vel = Vec2:new(0, 0)
	self.vel = Vec2:new(vx or 0, vy or 0)
	self.angular_speed = vr or 0
	self.particle_timer = t or 0.1
	self.p_rand_factor = 0
	self.spread = 0
	self.angle = 0
end


function PSpawner:_get_pos()
	local x = (self.pos.x - self.w / 2) + math.random() * self.w 
	local y = (self.pos.y - self.h / 2) + math.random() * self.h 
	return Vec2:new(x, y)
end


function PSpawner:_get_vel()
	local dx = -self.p_rand_factor * self.pvx + math.random() * self.p_rand_factor * self.pvx * 2
	local dy = -self.p_rand_factor * self.pvy + math.random() * self.p_rand_factor * self.pvy * 2
	return Vec2:new(self.pvx + dx, self.pvy + dy)
end


function PSpawner:spawn()
	local pos = self:_get_pos()
	local vel = self:_get_vel()
	-- print(self.angular_speed, self.angle)
	local p = Particle(pos.x, pos.y, self.angle, vel.x, vel.y, 1, 1, self.particle_timer)
	return p
end


function PSpawner:update(dt)
	self.pos = self.pos + self.vel
	self.angle = self.angle + self.angular_speed
end


return PSpawner