noclipsus = {}
local nodes = {["default:stone"] = true, ["default:desert_stone"] = true, ["default:sand"] = true, ["default:dirt"] = true}
local stop = false
local function report(name,ppos,node,vel)
    local text = "[noclipdetect] "..name.." was sus noclipping in "..node.name.." at "..core.pos_to_string(vector.round(ppos))..", velocity: "..core.pos_to_string(vector.round(vel,""))
    core.log("action",text)
end
core.register_globalstep(function(dtime)
    for _,player in ipairs(core.get_connected_players()) do
        local name = player:get_player_name()
        if name then
            if not core.check_player_privs(name,{noclip = true}) then
                local ppos = player:get_pos()
                local node = core.get_node_or_nil(ppos)
                if node then
                    if nodes[node.name] then
                        local vel = player:get_velocity()
                        if vel.x >= 10 or vel.z >= 10 then
                            if noclipsus[name] then
                                report(name,ppos,node,speed)
                                noclipsus[name] = nil
                            else
                                core.after(2, function()
                                    noclipsus[name] = true
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)
