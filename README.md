# To-do List

Este é um trabalho simples de uma lista de tarefas com autenticação e banco de dados.

## Desculpa, Thomaz

Atrasamos em 1 mês o trabalho, e metade do código já havia sido feito pelo professor. Pedimos desculpas e, se serve de algo, compensamos publicando em um repositório do GitHub.

## Como foi feito

Usamos Flutter como FrameWork, Dart para programar e FireBase para o sistema de autenticação e armazenamento de dados.

### Flutter

Usamos diversos Widgets, mas um deles merece mais atenção: `CheckBoxListTile`, que é uma `CheckBox` com texto nativa do Flutter que usamos para fazer as tarefas, definindo o `title` como o nome da tarefa e o `value` para caso ela esteja pendente ou não. A lista em si é composta por uma `ListView` com as tarefas, gerada com o mesmo `StreamBuilder` do projeto feito pelo professor.

### FireBase

Por meio do FireBase, guardamos as tarefas. Cada collection recebe o nome equivalente ao ID único do usuário cadastrado, o que garante uma lista diferente para cada pessoa. Dentro dessa collection exclusiva, há um document para cada tarefa, que inclui uma variável de texto para o nome e outra booleana para o cumprimento da tarefa.

### GitHub

Por meio deste repósitório, armazenamos o projeto. Infelizmente, só fui aprender a usar Git no fim do projeto, então não salvei todas as versões e o histórico de mudanças desde o começo, mas pelo menos a versão final está publicada.