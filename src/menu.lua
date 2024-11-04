-- Menu
local utils = require("utils")
local menu = {}

function menu.exibir()
  print(utils.bold("\27[34m========================="))
  print(utils.bold("\27[34m        TASKMATE"))
  print(utils.bold("\27[34m=========================\27[0m\n\n"))
  print(utils.bold("Selecione a opcao desejada:"))
  print(utils.typingEffect(utils.bold("[1] Criar uma nova tarefa")))
  print(utils.typingEffect(utils.bold("[2] Marcar uma tarefa como concluida")))
  print(utils.typingEffect(utils.bold("[3] Listar todas as tarefas criadas")))
  print(utils.typingEffect(utils.bold("[4] Sair\n")))
end

return menu
