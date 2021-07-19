# Sobre o projeto

## Iniciando Sistema:
O sistema deve ser executado iniciando o servidor local.

``` bash
iex -S mix phx.server
```

##  Rotas de acesso á sonda espacial:

Rota responsável por alterar a posição da sonda, sendo possível passar uma sequência de movimentação de vez.
``` http
POST http://localhost:4000/api/move
```
``` json
Content-Type: application/json
{
    "movimentos": ["GE", "M", "M", "M", "GD", "M", "M"]
}
```

Rota responsável por resetar a posição da sonda.
``` http
GET  http://localhost:4000/api/reset
```

Rota responsável por retornar status da posição da sonda.
``` http
GET  http://localhost:4000/api/status
```

## Rotas podem ser facilmente testadas em:
``` http
sample.http
```


## Testes podem ser executados com:
``` bash
mix test
```
