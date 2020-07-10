local class = require('lib/middleclass')
local PSpawner = require('pspawner')
local Particle = require('particle')

local PSystem = class('PSystem')

math.randomseed(os.time())

function PSystem:init(x, y, t, vx, vy, vr, w, h)
	assert(x or y, 'expected number as Particle system coordinate.')
	self.spawner = PSpawner(x, y, w or 0.5, h or 0.5, vx, vy, vr, t)
	self.pvx, self.pvy = 0, 0
	self.p_angular_speed = 0
	self.particles = {}
	self.time_elapsed = 0
	self.max_particles = false
	self.spawn_rate = t or 0.1
end


function PSystem:set_spawn_rate(t)
	self.spawn_rate = t
end


function PSystem:set_max_particles(n)
	self.max_particles = n
end


function PSystem:set_particle_draw(f)
	assert(type(f) == 'function', 'expected function as particle draw')
	self.draw_particle = f
end


function PSystem:set_sys_velocity(vx, vy)
	self.spawner.vx = vx
	self.spawner.vy = vy
end


function PSystem:set_angular_speed(vr)
	self.spawner.angular_speed = vr
end


function PSystem:set_particle_life(t)
	self.spawner.particle_timer = t
end


function PSystem:set_particle_velocity(x, y)
 	self.pvx = x
 	self.pvy = y
 end


function PSystem:set_particle_angular_speed(wr)
	self.p_angular_speed = wr
end


function PSystem:update(dt)
	self.time_elapsed = self.time_elapsed + dt
	if self.time_elapsed >= self.spawn_rate then 
		self.time_elapsed = 0
		
		if not (self.max_particles and #self.particles > self.max_particles) then 
			table.insert(self.particles, self.spawner:spawn())
		end
	end

	for i = #self.particles, 1, -1 do
		local p = self.particles[i]
		p:update(dt, self.pvx, self.pvy, self.p_angular_speed)
		if not p.alive then 
			table.remove(self.particles, i)
		end
	end

	self.spawner:update(dt)

end


function PSystem:draw()
	for i = 1, #self.particles do 
		p = self.particles[i]
		self.draw_particle(p.x, p.y, p.angle, p.sx, p.sy)
	end
end


return PSystem