local utils = require("utils")
local menu = require("menu")
-- TODO
-- criar uma nova configuração para que o programa seja aberto em uma nova janela
-- os.execute("kitty -- bash -c 'lua hello.lua; exec bash'")
-- 
--
utils.showSpinner()
print("\a")
print(os.date("%A, %d in %b"))
-- Definição da lista de tarefas
Tarefas = {}
Tarefa = {}
Tarefa.__index = Tarefa
-- Criar uma nova tarefa
-- Permite cadastrar uma nova tarefa no gerenciador de tarefas
--
function Tarefa:new(descricao, prazo)
  local novaTarefa = {}
  setmetatable(novaTarefa, self)
  novaTarefa.prazo = prazo
  novaTarefa.descricao = descricao
  novaTarefa.status = utils.yellow("PENDENTE")
  print(utils.typingEffect(utils.bold(utils.green("\nNova tarefa criada:\n"))))
  print(utils.typingEffect(utils.bold(utils.green("+ " .. novaTarefa.descricao .. ": " .. novaTarefa.status .. " | " .. tostring(novaTarefa.prazo)))))
  print("\a")
  table.insert(Tarefas, novaTarefa)
  return novaTarefa
end

-- Marcar uma tarefa como concluida
--
function Tarefa:concluirTarefa()
  self.status = "CONCLUIDA"
  print(utils.typingEffect(utils.bold(utils.green("Tarefa concluida!"))))
  print(self.descricao .. ": " .. self.status)
end

-- Listar todas as tarefas
function ListarTarefas()
  if (table.maxn(Tarefas) == 0) then
    print(utils.typingEffect(utils.bold(utils.yellow("\nNão existem tarefas criadas!"))))
  else
    for i, tarefa in pairs(Tarefas) do
      if (tarefa.status == "PENDENTE") then
        print(utils.typingEffect("\n" .. i .. " - " .. tarefa.descricao .. ": " .. utils.bold(utils.yellow(tarefa.status) .. "\n")))
      else if (tarefa.status == "CONCLUIDA") then
        print(utils.typingEffect("\n" .. i .. " - " .. tarefa.descricao .. ": " .. utils.bold(utils.green(tarefa.status) .. "\n")))
        end
      end
    end
  end
end

-- Menu
while true do
  menu.exibir()
  local option = tonumber(io.read())
    if (option == 1) then
        print(utils.typingEffect(utils.bold("\nInforme a descricao da tarefa:")))
        local descricao = io.read()
        local prazo = utils.requestDate()
        Tarefa:new(descricao, prazo)
  --
    elseif (option == 2) then
      print(utils.typingEffect(utils.bold("\nSelecione a tarefa desejada: \n")))
      ListarTarefas()
      local opcao = tonumber(io.read())
      if Tarefas[opcao] then
        Tarefas[opcao]:concluirTarefa()
      end
    elseif (option == 3) then
      ListarTarefas()
  --
      elseif (option == 4) then
        os.execute("clear")
        os.exit()
  --
    else
      print(utils.typingEffect(utils.bold("Opcao invalida. Tente novamente")))
    end
end
