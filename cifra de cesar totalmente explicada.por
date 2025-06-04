programa {
  // A palavra-chave 'programa' marca o início do seu programa em Portugol Studio.
  // Tudo o que o programa faz está contido dentro deste bloco.

  inclua biblioteca Texto // Esta linha inclui a biblioteca 'Texto', que oferece funções para manipular cadeias de caracteres (strings),
                         // como obter o número de caracteres em uma string, pegar um caractere específico por índice e converter para minúsculas/maiúsculas.

  // Note: A biblioteca 'Tipos' não é mais necessária, pois não estamos usando Tipos.inteiro_para_caracter() ou Tipos.caracter_para_inteiro().
  // O Portugol Studio consegue converter um número ASCII em caractere automaticamente quando você o adiciona a uma string.
  // Por exemplo, "minha_string" + 65 (ASCII de 'A') pode resultar em "minha_stringA".

  funcao inicio() {
    // A 'funcao inicio()' é a função principal do programa. É o ponto de entrada, onde a execução do seu código começa.
    // Todo o código executável do seu programa deve estar dentro desta função.

    cadeia mensagemOriginal // Declara uma variável do tipo 'cadeia' (string) para armazenar a mensagem que o usuário deseja criptografar ou descriptografar.
    inteiro chaveDeslocamento // Declara uma variável do tipo 'inteiro' para armazenar o valor numérico da chave (o quanto as letras serão deslocadas).
    cadeia operacaoEscolhida // Declara uma variável do tipo 'cadeia' para armazenar a escolha do usuário: "criptografar" ou "descriptografar".
    cadeia mensagemResultante = "" // Declara e inicializa uma variável 'cadeia' vazia. Esta string será construída caractere por caractere
                                 // com o resultado da operação (criptografia ou descriptografia).

    // Nossos "alfabetos" para lookup (consulta), ja que nao podemos manipular ASCII diretamente
    // Estas duas linhas criam as "tabelas" de referência para as letras.
    // Usamos strings porque seu ambiente Portugol Studio não permite a manipulação direta de caracteres como valores ASCII numéricos.
    cadeia alfabetoMaiusculo = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" // String contendo todas as letras maiúsculas em ordem.
    cadeia alfabetoMinusculo = "abcdefghijklmnopqrstuvwxyz" // String contendo todas as letras minúsculas em ordem.
    
    // 1. Coleta de dados do usuario
    // Esta seção é responsável por interagir com o usuário para obter a mensagem, a chave e a operação.
    escreva("Digite a mensagem: ") // Exibe uma mensagem para o usuário no console, pedindo a mensagem.
    leia(mensagemOriginal) // Lê a entrada do usuário do console e armazena na variável 'mensagemOriginal'.

    escreva("Digite a chave de deslocamento (valor inteiro): ") // Pede ao usuário para digitar a chave.
    leia(chaveDeslocamento) // Lê a chave digitada pelo usuário e armazena em 'chaveDeslocamento'.
    
    // Normaliza a chave para estar entre 0 e 25 (tamanho do alfabeto)
    // O operador '%' (módulo) garante que a chave fique dentro do intervalo de 0 a 25.
    // Ex: Se a chave for 27, 27 % 26 = 1. Se for 52, 52 % 26 = 0.
    chaveDeslocamento = chaveDeslocamento % 26 
    
    // Ajusta a chave para valores negativos (ex: -1 vira 25)
    // Se o usuário digitar uma chave negativa (ex: -1), o módulo pode resultar em -1.
    // Para garantir que a chave seja sempre um valor positivo entre 0 e 25, adicionamos 26 se ela for negativa.
    // Ex: -1 + 26 = 25. Isso faz com que a chave -1 seja equivalente a 25.
    se (chaveDeslocamento < 0) {
      chaveDeslocamento = chaveDeslocamento + 26
    }

    escreva("Escolha a operação (criptografar/descriptografar): ") // Pede ao usuário para escolher a operação.
    leia(operacaoEscolhida) // Lê a operação escolhida pelo usuário.

    // Converte a escolha do usuario para minúsculas para facilitar a comparacao
    // 'Texto.caixa_baixa()' converte a string para minúsculas. Isso torna a comparação mais fácil,
    // pois 'Criptografar', 'criptografar' e 'CRIPTOGRAFAR' serão todos tratados como "criptografar".
    operacaoEscolhida = Texto.caixa_baixa(operacaoEscolhida) 

    // 2. Processamento da mensagem caractere por caractere
    // Este loop 'para' percorre cada caractere da 'mensagemOriginal'.
    // 'i' começa em 0 (o primeiro caractere) e vai até o último caractere da mensagem.
    // 'Texto.numero_caracteres(mensagemOriginal)' retorna o comprimento da string.
    para (inteiro i = 0; i < Texto.numero_caracteres(mensagemOriginal); i++) {
      // 'Texto.obter_caracter(mensagemOriginal, i)' pega o caractere na posição 'i' da mensagem.
      caracter charAtual = Texto.obter_caracter(mensagemOriginal, i)
      // 'indiceNoAlfabeto' é inicializado como -1. Se o caractere for uma letra, ele guardará sua posição (0-25).
      // Se ele permanecer -1, significa que o caractere não é uma letra.
      inteiro indiceNoAlfabeto = -1 

      // --- Tentar encontrar o caractere no alfabeto MAIUSCULO ---
      // Este loop interno tenta encontrar o 'charAtual' (caractere da mensagem) no 'alfabetoMaiusculo'.
      para (inteiro j = 0; j < Texto.numero_caracteres(alfabetoMaiusculo); j++) {
        // Compara 'charAtual' com cada caractere do 'alfabetoMaiusculo'.
        se (charAtual == Texto.obter_caracter(alfabetoMaiusculo, j)) {
          indiceNoAlfabeto = j // Se encontrou, 'j' é a posição (0-25) da letra. Armazena esse índice.
          pare // A palavra-chave 'pare' sai imediatamente do loop 'para' mais interno (o loop 'j').
               // Não precisamos procurar mais, já encontramos a letra.
        }
      }

      // Se encontrou no alfabeto maiusculo (indiceNoAlfabeto será diferente de -1)
      se (indiceNoAlfabeto != -1) {
        inteiro novoIndice = 0 // Variável para armazenar a nova posição da letra no alfabeto após o deslocamento.
        
        // Lógica para CRIPTOGRAFAR letras maiúsculas
        se (operacaoEscolhida == "criptografar") {
          // Soma o índice original da letra com a chave de deslocamento.
          // O '% 26' garante que o resultado "volte" ao início do alfabeto se ultrapassar 'Z' (índice 25).
          // Ex: 'X' (23) + chave 5 = 28. 28 % 26 = 2, que é 'C'.
          novoIndice = (indiceNoAlfabeto + chaveDeslocamento) % 26
        } 
        // Lógica para DESCRIPTOGRAFAR letras maiúsculas
        senao se (operacaoEscolhida == "descriptografar") {
          // Para descriptografar, subtraímos a chave.
          // O resultado da subtração pode ser negativo (ex: 'A' (0) - chave 5 = -5).
          novoIndice = (indiceNoAlfabeto - chaveDeslocamento) % 26
          // Esta verificação é CRÍTICA para Portugol Studio. Se o resultado do módulo for negativo (ex: -5 % 26 pode ser -5),
          // adicionamos 26 para transformá-lo em um índice positivo e válido para o alfabeto (ex: -5 + 26 = 21, que é 'V').
          se (novoIndice < 0) {
              novoIndice = novoIndice + 26
          }
        }
        // Depois de calcular o 'novoIndice', pegamos o caractere correspondente no 'alfabetoMaiusculo'
        // e o adicionamos à 'mensagemResultante'.
        mensagemResultante = mensagemResultante + Texto.obter_caracter(alfabetoMaiusculo, novoIndice)
      }
      // --- Senao, tentar encontrar no alfabeto MINUSCULO ---
      // Este bloco 'senao' é executado SE o caractere não foi encontrado no alfabeto maiúsculo.
      senao { 
        indiceNoAlfabeto = -1 // Reinicia 'indiceNoAlfabeto' para -1, para que possamos procurar no alfabeto minúsculo.
        // Este loop interno é similar ao de maiúsculas, mas agora procura no 'alfabetoMinusculo'.
        para (inteiro j = 0; j < Texto.numero_caracteres(alfabetoMinusculo); j++) {
          se (charAtual == Texto.obter_caracter(alfabetoMinusculo, j)) {
            indiceNoAlfabeto = j
            pare // Achou, sai do loop interno.
          }
        }

        // Se encontrou no alfabeto minusculo (indiceNoAlfabeto será diferente de -1)
        se (indiceNoAlfabeto != -1) {
          inteiro novoIndice = 0 // Variável para a nova posição da letra minúscula.
          // Lógica para CRIPTOGRAFAR letras minúsculas (similar à maiúscula)
          se (operacaoEscolhida == "criptografar") {
            novoIndice = (indiceNoAlfabeto + chaveDeslocamento) % 26
          } 
          // Lógica para DESCRIPTOGRAFAR letras minúsculas (similar à maiúscula, com correção para negativos)
          senao se (operacaoEscolhida == "descriptografar") {
            novoIndice = (indiceNoAlfabeto - chaveDeslocamento) % 26
            se (novoIndice < 0) {
                novoIndice = novoIndice + 26
            }
          }
          // Adiciona o novo caractere (minúsculo) à 'mensagemResultante'.
          mensagemResultante = mensagemResultante + Texto.obter_caracter(alfabetoMinusculo, novoIndice)
        }
        // Se nao eh letra (nem maiuscula nem minuscula)
        senao {
          // Se o caractere 'charAtual' não foi encontrado em nenhum dos alfabetos (maiúsculo ou minúsculo),
          // significa que ele é um número, símbolo, espaço, etc.
          // Nesses casos, o caractere é adicionado à 'mensagemResultante' sem nenhuma alteração.
          mensagemResultante = mensagemResultante + charAtual 
        }
      }
    } // Fim do loop 'para' principal: todos os caracteres da mensagem original foram processados.

    // 3. Exibicao do resultado final
    // Esta seção verifica qual operação foi escolhida e exibe a mensagem resultante ao usuário.
    se (operacaoEscolhida == "criptografar") {
      escreva("Mensagem criptografada: ", mensagemResultante, "\n") // Exibe a mensagem criptografada.
    } senao se (operacaoEscolhida == "descriptografar") {
      escreva("Mensagem descriptografada: ", mensagemResultante, "\n") // Exibe a mensagem descriptografada.
    } senao {
      // Se a operação escolhida não foi "criptografar" nem "descriptografar", informa ao usuário.
      escreva("Operação inválida. Por favor, escolha 'criptografar' ou 'descriptografar'.\n")
    }
  } // Fim da funcao 'inicio'
} // Fim do programa