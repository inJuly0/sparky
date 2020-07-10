local class = require("lib/middleclass")

local Particle = class('Particle')

function Particle:init(x, y, angle, sx, sy, t)
  self.x, self.y = x, y
  self.angle = angle
  self.alive = true
  self.life_span = t or 0.5
  self.sx, self.sy = sx or 1, sy or 1
end

function Particle:update(dt, vx, vy, vr)
  self.x = self.x + vx
  self.y = self.y + vx
  self.angle = self.angle + vr
  self.life_span = self.life_span - dt
  if self.life_span <= 0 then 
    self.alive = false 
  end
end

return Particle