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
  novaTarefa.status = "PENDENTE"
  table.insert(Tarefas, novaTarefa)
  return novaTarefa
end

-- Marcar uma tarefa como concluida
--
function Tarefa:concluirTarefa()
  self.status = "CONCLUIDA"
  print("Tarefa concluida!")
  print(self.descricao .. ": " .. self.status)
end

-- Listar todas as tarefas
function ListarTarefas()
  for i, tarefa in pairs(Tarefas) do
    print(i .. " - " .. tarefa.descricao .. ": " .. tarefa.status)
  end
end

-- Menu
while true do
  print("### MENU ###")
  print("Selecione a opcao desejada:")
  print("1 - Criar uma nova tarefa")
  print("2 - Marcar uma tarefa como concluida")
  print("3 - Listar todas as tarefas criadas")
  print("4 - Sair")
  --
  local option = tonumber(io.read())
    if (option == 1) then
        print("Informe a descricao da tarefa:\n")
        local descricao = io.read()
        io.write("Informe o prazo final da tarefa:\n")
        local prazo = io.read()
        Tarefa:new(descricao, prazo)
  --
    elseif (option == 2) then
      print("Selecione a tarefa desejada: ")
      ListarTarefas()
      local opcao = tonumber(io.read())
      if Tarefas[opcao] then
        Tarefas[opcao]:concluirTarefa()
      end
    elseif (option == 3) then
      ListarTarefas()
  --
      elseif (option == 4) then
        break
  --
    else
      print("Opcao invalida. Tente novamente")
    end
end
