noclipsus = {}
local stop = false
local function report(name,ppos,node,speed)
    local text = "[antinoclip] "..name.." was sus noclipping in "..node.name.." at "..core.pos_to_string(vector.round(ppos))..", speed: "..core.pos_to_string(vector.round(speed,""))
core.log("action",text)
sendWebhook({content = '`'..text..'`'})
end
core.register_globalstep(function()
 for _,player in ipairs(core.get_connected_players()) do
    local name = player:get_player_name()
    if not name then return end
    if core.check_player_privs(name,{noclip = true}) then return end
    local ppos = player:get_pos()
    local node = core.get_node_or_nil(ppos)
    if not node then return end
    if node.name == "default:stone" or node.name == "default:desert_stone" or node.name == "default:sand" or node.name == "default:dirt" or node.name == "default:sandstone" then
    local speed = player:get_velocity()
    if speed.x >= 10 or speed.z >= 10 then
    if noclipsus[name] == true then
    report(name,ppos,node,speed)
    noclipsus[name] = false
    elseif stop == false then
    core.after(2,function()
    noclipsus[name] = true
    stop = false
    end)
    stop = true
    end
    end
    
 end
 end
end)
