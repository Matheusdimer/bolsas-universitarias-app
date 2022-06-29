# Projeto Bolsas Universitárias

## API Rest NodeJs

* Link do repositório: https://github.com/Matheusdimer/bolsas_universitarias_api

### Stack utilizada
* NodeJs
* Typescript
* Express
* TypeORM

### Execução

Para executar, será necessário configurar a conexão com um banco de dados postgres, 
e as propriedades de autenticação através das variáveis de ambiente:

```dotenv
# Variáveis do banco de dados
DB_HOST='URL do banco'
DB_USER='Usuário do banco'
DB_PASSWORD='Senha'
DB_NAME='Nome do banco de dados'

# Propriedades de autenticação 
ENCRYPT_KEY='Chave que será usada na assinatura do token JWT'
TOKEN_EXPIRATION='Tempo de expiração do token JWT (padrão 1d)'
```

Essas variáveis podem ser colocadas em um arquivo `.env` na raiz do projeto.
Para produção, são utilizadas as mesmas, configuradas no ambiente de deploy utilizado.

Após devidamente configurado, executar `npm install` e logo após `npm start`. 
A estrutura do banco de dados será criada automaticamente pela aplicação.

## Painel administrativo

* Link do repositório: https://github.com/Matheusdimer/bolsas-universitarias-admin

### Stack utilizada
* Angular 13
* MDBootstrap

Os arquivos com a URL da API para desenvolvimento local e produção então em `src/environments` 
sendo eles `environment.ts` e `environment.prod.ts` respectivamente. A variável `apiUrl` define 
qual a URL do servidor de backend.


## Aplicativo

* Link do repositório: https://github.com/Matheusdimer/bolsas-universitarias-app

### Stack utilizada

* Flutter 2
* Linguagem Dart

### Configuração
A variável `apiUrl` define qual a URL do servidor de backend, no arquivo `lib/config/constants.dart`.

### Execução
Para rodar o aplicativo, será necessário ter o Android SDK instalado, o SDK do Flutter versão 2,
e um emulador de android devidamente configurado. No VsCode, há uma extensão oficial do flutter
para rodar o projeto.
