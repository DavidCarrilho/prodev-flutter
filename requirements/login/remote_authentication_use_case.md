# Remote  Authentication Use Case

> ## Caso de sucesso

1. OK - Sistema valida os dados
2. OK - Sistema faz uma requisição para a URL da API de login
3. Sistema valida os dados recebidos da API
4. Sistema entrega os dados da conta do usuário

> ## Exceção - URL inválida

1. OK - Sistema retorna uma mensagem de erro inesperado

> ## Exeção - Dados inválida

1. OK - Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Falha no servidor

1. OK - Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Credenciais inválidas

1. Sistema retorna uma mensagem de erro informando que as crendenciais estão erradas
