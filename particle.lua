local class = require("lib/middleclass")
local Vec2 = require('lib/vector2')

local Particle = class('Particle')

function Particle:init(x, y, angle, vx, vy, sx, sy, t)
  self.pos = Vec2(x, y)
  self.angle = angle
  self.vel = Vec2(vx or 0 , vy or 0)
  self.alive = true
  self.life_span = t or 0.5
  self.sx, self.sy = sx or 1, sy or 1
end


function Particle:update(dt, vr)
  self.pos = self.pos + self.vel
  self.angle = self.angle + vr
  self.life_span = self.life_span - dt
  if self.life_span <= 0 then 
    self.alive = false 
  end
end

return Particle