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
-- Função que recebe a data no formato de string e a transforma em uma table em formato de data que poderá ser manipulada posteriormente
-- Retorna nil se a data for inválida
function utils.parseDate(data)
  local year, month, day = data:match("(%d+)/(%d+)/(%d+)")
  if year and month and day then
    return {year = tonumber(year), month = tonumber(month), day = tonumber(day)}
  else
    return nil
  end
end
-- Função que checa se a data informada é válida considerando: se o formato de ano, mês e dia está valido
-- Retorna um boolean
function utils.checkDate(data)
  local dateUser = utils.parseDate(data)
  if dateUser ~= nil then
    if (dateUser.month < 1) or (dateUser.month > 12) then
      return false
    end
    if (dateUser.day < 1 or dateUser.day > 31) then
      return false
    end
    if (dateUser.month == 2 and dateUser.day > (dateUser.year % 4 == 0 and 29 or 28) or
      ((dateUser.month == 4 or dateUser.month == 6 or dateUser.month == 9 or dateUser.month == 11) and dateUser.day > 30)) then
      return false
    end
    return true
  end
  return false
end
--
-- Função para solicitar a data ao usuário
function utils.requestDate()
  local input
  while true do
    print(utils.typingEffect(utils.bold("Informe o prazo final (YYYY/MM/DD):")))
    input = io.read()
    local dataTable = utils.parseDate(input)
    if utils.checkDate(input) and
       utils.verifyDate(dataTable) == 1 or utils.verifyDate(dataTable) == 2 and dataTable then
      break
    elseif dataTable == nil then
      print(utils.typingEffect(utils.bold("Data invalida. A data nao esta no formato especificado, ou e uma data passada. \nTente novamente.")))
    else
      print(utils.typingEffect(utils.bold("Formato de data invalido. Tente novamente.")))
    end
  end
  return input
end
-- Função que verifica se a data compara a data informada pelo usuário em relação à data do sistema
function utils.verifyDate(dataUser)
  local timestampUser = os.time({year = dataUser.year, month = dataUser.month, day = dataUser.day})
  local currentDate = os.date("*t")
  local timestampSystem = os.time({year = currentDate.year, month = currentDate.month, day = currentDate.day})

  if timestampUser then
    if timestampUser > timestampSystem then -- Se a data informada pelo usuário for após a data do sistema
      return 1
    elseif timestampUser < timestampSystem then -- Se a data informada pelo usuário for antes da data do sistema
      return 0
    else
      return 2
    end
  end
end

return utils

