require "keybow"

local layer = 0
local last_key = nil
local shift_key = false

function setup()
    keybow.auto_lights(false)
    keybow.clear_lights()
end

template = {
    {},
    {"e", "_", "f", "j", "3", ".", ")", "@"}, -- 01
    {"i", "c", "p", "z", "6", "_", "#", ":"}, -- 02
    {},
    {"t", "r", "_", "x", "4", ",", "(", "&"}, -- 04
    {"n", "u", "b", "0", "7", "=", "_", ";"}, -- 05
    {},
    {"a", "d", "g", "_", "5", "-", "]", ">"}, -- 07
    {"s", "m", "v", "1", "8", "/", "}", "_"}, -- 08
    {},
    {"o", "l", "y", "q", "_", "+", "[", "<"}, -- 10
    {"h", "w", "k", "2", "9", "*", "{", "%"},  -- 11
    {}
}


function input(key,mod,pressed)
    if pressed == true then
        key_down(key,mod)
    else
        key_up(key,mod)
    end
    update_lights()
end

function key_down(key,mod)
    push_layer(mod)
    last_key = key
end

function key_up(key,mod)
    pop_layer(mod)
    if key == last_key then
        ch = get_char(key,layer)
        if shift_key == true then
            send(string.upper(ch))
        else
            send(ch)
        end
    end
end

function get_char(key,layer)
    return template[key+1][layer+1]
end

function push_layer(id)
    if layer > 0 then return end
    if layer == id then return end
    layer = id
    
end

function pop_layer(id)
    if id ~= layer then return end
    layer = 0
end

function send(ch)
    -- print("output:",ch)
    keybow.tap_key(ch)
end

function update_lights()
    keybow.clear_lights()
    if layer > 0 then
        keybow.set_pixel(layer, 255, 255, 255)
    end
    if shift_key == true then
        keybow.set_pixel(9, 255, 0, 0)
    end
end

-- Map --

-- TOP 11 08 05 02 --
-- MID 10 07 04 01 --
-- LOW 09 06 03 00 --

-- Top --

function handle_key_11(pressed)
    input(11, 8, pressed)
end

function handle_key_08(pressed)
    input(8, 7, pressed)
end

function handle_key_05(pressed)
    input(5, 6, pressed)
end

function handle_key_02(pressed)
    input(2, 5, pressed)
end

-- Mid --

function handle_key_10(pressed)
    input(10, 4, pressed)
end

function handle_key_07(pressed)
    input(7, 3, pressed)
end

function handle_key_04(pressed)
    input(4, 2, pressed)
end

function handle_key_01(pressed)
    input(1, 1, pressed)
end

-- Low --

function handle_key_09(pressed)
    shift_key = pressed

end

function handle_key_06(pressed)
    keybow.set_key(keybow.BACKSPACE, pressed)
end

function handle_key_03(pressed)
    keybow.set_key(keybow.ENTER, pressed)
end

function handle_key_00(pressed)
    keybow.set_key(keybow.SPACE, pressed)
end