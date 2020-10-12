# CRUD-ESIG BACKEND

## Sobre o projeto

Api rest desolvida com o framework laravel.

## Requesitos

-   php = "^7.1.3".
-   laravel = "5.8.\*".
-   postgres.
-   composer.

## Funcionalidades

-   Cadastro de tarefa;
-   Edição de tarefa;
-   Listagem de tarefa por filtro;

## Instalação

Realize o clone do projeto (https://github.com/HandersonSilva/CRUD-ESIG.git).

Crie um banco de dados no postgres e utilize o arquivo .env.example para configura-lo no projeto;

## Instalando dependencias;

Dentro da pasta backend rode o seguinte comando:

-   composer install

## Criando as tabelas no banco

Após ter configurado o banco rode o comando:

-   php artisan migrate

## Executando o projeto

Execute o comando "php artisan serve" ou "php -S meu_ip:8000" no diretorio anterior a pasta backend.

Se tudo ocorreu bem seu servidor estará online.

## Detalhamento das rotas

### Cadatrando uma tarefa

Envie uma requisição para a rota passando os dados as serem cadastrados.

```http

POST http://crud-esig.herokuapp.com/task
content-type: application/json

{
    "description":"Minha primeira tarefa",
    "done":false,
    "filter":"all"
}
```

### Listando as tarefas

As tarefas serão listada de acordo com o filtro passado.
Filtos disponiveis "all", "done" e "unrealized".

```http
GET http://crud-esig.herokuapp.com/api/task/{filtro}
```

### Alterando uma tarefa

Envie uma requisição para a rota passadno o id da tarefa e os dados a serem atualizados.

```http
PUT http://crud-esig.herokuapp.com/task/{id_tarefa}
content-type: application/json

{
    "description":"Minha primeira tarefa",
    "done":true,
    "filtro":"all"
}

```

### Excluíndo uma tarefas

Envie uma requisição para a rota passando o id da tarefa

```http
DELETE http://crud-esig.herokuapp.com/task/{id_tarefa}
```

### Excluíndo as tarefas completadas

Envie uma requisição para a rota

```http
DELETE http://crud-esig.herokuapp.com/task-done
```
