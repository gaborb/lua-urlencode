local lib = {}

local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

local hex_to_char = function(x)
    return string.char(tonumber(x, 16))
end

function lib.urlencode(url)
    if url == nil then
        return nil
    end
    url = url:gsub("([^%w%-%.%_%~ ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

function lib.urldecode(url)
    if url == nil then
        return nil
    end
    url = url:gsub("+", " ")
    url = url:gsub("%%(%x%x)", hex_to_char)
    return url
end

return lib