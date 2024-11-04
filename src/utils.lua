-- Define as funções que serão utilizadas ao longo da aplicação para fins de decoração, organização e efeitos visuais

local utils = {}

-- Modificação do texto e efeitos visuais
function utils.green(text)
 return "\27[32m" .. text .. "\27[0m"
end

function utils.yellow(text)
  return "\27[33m" .. text .. "\27[0m"
end

function utils.bold(text)
  return "\27[1m" .. text .. "\27[0m"
end

local spinner = { "|", "/", "-", "\\" }
local delay = 0.1
-- Função para mostrar o cursor giratório
function utils.showSpinner()
    for i = 1, 10 do
        local idx = (i % #spinner) + 1
        io.write("\r" .. spinner[idx])
        io.flush()
        os.execute("sleep " .. delay)
    end
    io.write("\r\27[K")
end

  function utils.typingEffect(text)
    for char in text:gmatch"." do
        io.write(char)
        io.flush()
        os.execute("sleep 0.1")
    end
end

-- Utilitários para manipular data
function utils.checkDate(data)
  local year, month, day = data:match("(%d+)/(%d+)/(%d+)")
 -- local currentYear, currentMonth, currentDay = os.time(%d%m%Y)
  if year and month and day then
    year, month, day = tonumber(year), tonumber(month), tonumber(day)
    if (month < 1) or (month > 12) then
      return false
    end
    if day < 1 or day > 31 then
      return false
    end
    if (month == 2 and day > (year % 4 == 0 and 29 or 28) or
      ((month == 4 or month == 6 or month == 9 or month == 11) and day > 30)) then
      return false
    end
    return true
  end
  return false
end

function utils.requestDate()
  local input
  while true do
    print(utils.typingEffect(utils.bold("Informe o prazo final (YYYY/MM/DD):")))
    input = io.read()
    if utils.checkDate(os.date(input)) then
      break
    else
      print(utils.typingEffect(utils.bold("Data invalida. Tente novamente.")))
    end
  end
  return input
end

return utils

