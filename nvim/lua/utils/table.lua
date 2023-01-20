function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end

  return dest
end

function table.extend(dest, src)
  for _, v in pairs(src) do
    table.insert(dest, v)
  end

  return dest
end
