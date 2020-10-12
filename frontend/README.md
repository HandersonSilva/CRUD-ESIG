# CRUD-ESIG FRONTEND

## Sobre o projeto

Frontend da aplicação desenvolvido em angular

## Requesitos

- @angular/cli": "~9.1.6",
- typescript": "~3.8.3
- @ng-bootstrap/ng-bootstrap": "^6.2.0",
- bootstrap": "^4.5.2",
- node v10.19.0
- npm 6.14.8

## Funcionalidades

- Cadastro de tarefa;
- Edição de tarefa;
- Listagem de tarefa por filtro;

### Instalando as dependencias;

- npm install

## Configurando o host

Altere o arquivo CRUD-ESIG/frontend/src/environments/environment.ts com o seu ip.

```js
export const environment = {
  production: false,
  hmr: false,
  urlApi: "http://seu_ip:4200/api",
};
```

Ajuste o arquivo do proxy CRUD-ESIG/frontend/proxy.config.json com o host do backend.

```js
{
  "/api/": {
    "target": "http://seu_ip:8000/api",
    "pathRewrite": {
      "^/api": ""
    }
  }
}
```

Altere o comando start no arquivo CRUD-ESIG/frontend/package.json com o seu ip.

```js
 "start": "ng serve --host seu_ip --port 4200 --proxy-config proxy.config.json --base-href /app/",
```

## Iniciando o projeto

Para rodar o projeto angular execute o comando "npm run start"

Se tudo ocorreu bem você poderá acessar a aplicação no endereço http://seu_ip:4200/app
