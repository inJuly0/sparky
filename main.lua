local PSystem = require('psystem')

g = love.graphics
mx = love.mouse.getX
my = love.mouse.getY
log = love.graphics.print

local sys = PSystem(200, 200, 1, 0, 0, 0, 40, 40)
sys:set_particle_velocity(-1, 1)
sys:set_particle_randomness(2)
sys:set_angular_speed(0.2)
sys:set_spawn_rate(0.01)
-- sys:set_max_particles(4)
-- sys:set_velocity(1, 0)
sys:set_particle_draw(function(x, y, r, sx, sy)
    g.setColor(0.2, 0.5, 1)
    g.rectangle('fill', x, y, 10, 10, r, sx, sy)
end)

function love.load()
    g.setBackgroundColor(0.133333, 0.1843137254901961, 0.24313725490196078)

    -- shader code
    shader = g.newShader([[
		vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc) {
			if (sc.x > 400)	return vec4(1.0 - color.x, 1.0 - color.y, 1.0 - color.z, 1.0);
			return color;			
		}
	]])
end

function love.draw() 
	g.setShader(shader)
	sys:draw() 
end

function love.update(dt)
    sys:update(dt)
    sys:move_to(mx(), my())
end
