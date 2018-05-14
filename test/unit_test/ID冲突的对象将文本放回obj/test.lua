local w2l = w3x2lni()
w2l.config.mode = 'slk'
w2l.config.remove_unused_object =false

function w2l:map_load(filename)
    return read(filename)
end

local ok
function w2l:backend_obj(type, data)
    if type == 'ability' then
        assert(data.A00a.name == 'A00a')
        ok = true
    end
end

local slk = {}
w2l:frontend(slk)
w2l:backend(slk)
assert(ok)
