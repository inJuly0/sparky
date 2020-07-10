local PSystem = require('psystem')

g = love.graphics
log = love.graphics.print


local sys = PSystem(200, 200, 1, 0, 0, 0, 10, 10)
sys:set_particle_velocity(1, 1)
sys:set_angular_speed(0.2)
sys:set_spawn_rate(0.1)
sys:set_particle_draw(function(x, y, r, sx, sy)
	g.setColor(0.4, 0.2, 1)
	g.rectangle('fill', x, y, 10, 10, r, sx, sy)
end)

function love.load()
	
end


function love.draw()
	sys:draw()
end


function love.update(dt)
	sys:update(dt)
end