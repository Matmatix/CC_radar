os.loadAPI("ocs/apis/sensor")

mon = peripheral.wrap("top")
mon.clear()
mon.setBackgroundColor(colors.black)
local mWidth, mHeight = mon.getSize()

local scale = 0.5
local x0 = mWidth/2
local y0 = mHeight/2
local xPos, yPos
local scanner = sensor.wrap("right")

mon.setTextScale(scale)
mon.setCursorPos(x0,y0)

local function ping(sc)

  position = {}
  name = {}
  
  local rawData = sc.getTargets()
    if rawData then
      for k, v in pairs(rawData) do
        if v["IsPlayer"] == true then
          mon.setTextColor(colors.green)
        else
          mon.setTextColor(colors.brown)
        end
        local details = sc.getTargetDetails(k)
          if details then
            name[#name + 1] = k
            position[#position + 1] = details.Position
          end
        end
    end
end

while true do
  ping(scanner)
  mon.clear()
  for i = 1, #name do
    xPos = x0 - position[i]["X"]
    yPos = y0 - position[i]["Z"]
    mon.setCursorPos(xPos, yPos)
    mon.write("[]")
    mon.setCursorPos(xPos-5,yPos-1)
    mon.write(name[i])
  end
  sleep(.1)  
end