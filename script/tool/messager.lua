local proto = require 'tool.protocol'
local report = {}
local function push_report(type, level, value, tip)
    local name = level .. type
    if not report[name] then
        report[name] = {}
    end
    table.insert(report[name], {value, tip})
end

messager = {}
function messager.text(text)
    proto.send('text', ('%q'):format(text))
end
function messager.raw(text)
    proto.send('raw', ('%q'):format(text))
end
function messager.title(title)
    proto.send('title', ('%q'):format(title))
end
function messager.progress(value)
    proto.send('progress', ('%.3f'):format(value))
end
function messager.report(type, level, content, tip)
    push_report(type, level, content, tip)
    proto.send('report', ('{type=%q,level=%d,content=%q,tip=%q}'):format(type, level, content, tip))
end

if io.type(io.stdout) == 'file' then
    local ext = require 'process.ext'
    ext.set_filemode(io.stdout, 'b')
    io.stdout:setvbuf 'no'
end

return messager
