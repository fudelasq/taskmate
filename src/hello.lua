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
  print(utils.typingEffect(
    utils.bold(utils.green("- Tarefa concluida: ")) ..
    utils.bold(self.descricao) .. "\n"))
end

-- Listar todas as tarefas
function ListarTarefas()
  if (table.maxn(Tarefas) == 0) then
    print(utils.typingEffect(utils.bold(utils.yellow("\nNão existem tarefas criadas!\n"))))
  else
    for i, tarefa in pairs(Tarefas) do
      if (tarefa.status == "PENDENTE") then
        print(utils.typingEffect(i .. " - " .. utils.bold(tarefa.descricao) .. ": " .. utils.bold(tarefa.status)))
      else
        print(utils.typingEffect(i .. " - " .. utils.bold(tarefa.descricao) .. ": " .. utils.bold(utils.green(tarefa.status))))
      end
    end
  end
end
-- Interface que lê os dados de entrada do usuário e chama a função de instanciar uma nova tarefa
function CadastrarTarefa()
  local descricao
  repeat
    print(utils.typingEffect(utils.bold("\nInforme a descricao da tarefa:")))
    descricao = io.read()
    if (descricao == nil or descricao == "" or descricao == " ") then
      print(utils.typingEffect(utils.bold("\nA descricao da tarefa nao pode estar em branco.")))
    end
  until (descricao ~= nil and descricao ~= " " and descricao ~= "")
  local prazo = utils.requestDate()
  Tarefa:new(descricao, prazo)
end
--
-- Função que recebe os dados da data e verifica o status da tarefa
--

while true do
-- Menu
  menu.exibir()
  local option = tonumber(io.read())
    if (option == 1) then
      CadastrarTarefa()
      --
    elseif (option == 2) then
      print(utils.typingEffect(utils.bold("\nSelecione a tarefa desejada: \n")))
      ListarTarefas()
      local opcao = tonumber(io.read())
      if Tarefas[opcao] then
        Tarefas[opcao]:concluirTarefa()
      else
        print(utils.typingEffect(utils.bold("Opcao invalida.")))
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

