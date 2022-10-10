local u = {}

function u.forEach(array, func)
    for i, e in ipairs(array) do
        local res = func(e, i)
        if res ~= nil then
            return res
        end
    end
end

function u.withId(array, id)
    return u.where(array, u.hasId(id))
end

function u.where(array, func)
    for i, e in ipairs(array) do
        if func(e) then
            return i, e
        end
    end
end

function u.filter(array, func)
    local ret = {}
    for i, e in ipairs(array) do
        if func(e) then
            table.insert(ret, e)
        end
    end
    return ret
end

function u.shallowCopy(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end

return u
