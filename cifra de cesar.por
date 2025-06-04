programa {
  inclua biblioteca Texto // Para manipulacao de cadeias de caracteres (strings)

  funcao inicio() {
    cadeia mensagemOriginal // Mensagem que o usuario ira digitar
    inteiro chaveDeslocamento // Valor da chave de deslocamento
    cadeia operacaoEscolhida // Tipo de operacao: "criptografar" ou "descriptografar"
    cadeia mensagemResultante = "" // A mensagem apos a operacao
    
    // Nossos "alfabetos" para lookup, ja que nao podemos manipular ASCII diretamente
    cadeia alfabetoMaiusculo = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    cadeia alfabetoMinusculo = "abcdefghijklmnopqrstuvwxyz"
    
    // 1. Coleta de dados do usuario
    escreva("Digite a mensagem: ")
    leia(mensagemOriginal)

    escreva("Digite a chave de deslocamento (valor inteiro): ")
    leia(chaveDeslocamento)
    
    // Normaliza a chave para estar entre 0 e 25 (tamanho do alfabeto)
    chaveDeslocamento = chaveDeslocamento % 26 
    
    // Ajusta a chave para valores negativos (ex: -1 vira 25)
    se (chaveDeslocamento < 0) {
      chaveDeslocamento = chaveDeslocamento + 26
    }

    escreva("Escolha a operação (criptografar/descriptografar): ")
    leia(operacaoEscolhida)

    // Converte a escolha do usuario para minúsculas para facilitar a comparacao
    operacaoEscolhida = Texto.caixa_baixa(operacaoEscolhida) 

    // 2. Processamento da mensagem caractere por caractere
    para (inteiro i = 0; i < Texto.numero_caracteres(mensagemOriginal); i++) {
      caracter charAtual = Texto.obter_caracter(mensagemOriginal, i)
      inteiro indiceNoAlfabeto = -1 // Vai armazenar a posicao da letra (0-25). -1 se nao for letra.

      // --- Tentar encontrar o caractere no alfabeto MAIUSCULO ---
      para (inteiro j = 0; j < Texto.numero_caracteres(alfabetoMaiusculo); j++) {
        se (charAtual == Texto.obter_caracter(alfabetoMaiusculo, j)) {
          indiceNoAlfabeto = j
          pare // Achou, sai do loop interno
        }
      }

      // Se encontrou no alfabeto maiusculo
      se (indiceNoAlfabeto != -1) {
        inteiro novoIndice = 0
        se (operacaoEscolhida == "criptografar") {
          novoIndice = (indiceNoAlfabeto + chaveDeslocamento) % 26
        } senao se (operacaoEscolhida == "descriptografar") {
          // --- MUDANÇA AQUI PARA GARANTIR INDICE POSITIVO ---
          novoIndice = (indiceNoAlfabeto - chaveDeslocamento) % 26
          // Se o resultado do módulo for negativo, adicione 26 para torná-lo positivo.
          se (novoIndice < 0) {
              novoIndice = novoIndice + 26
          }
        }
        mensagemResultante = mensagemResultante + Texto.obter_caracter(alfabetoMaiusculo, novoIndice)
      }
      // --- Senao, tentar encontrar no alfabeto MINUSCULO ---
      senao { // Se nao foi encontrado no maiusculo, verificar o minusculo
        indiceNoAlfabeto = -1 // Resetar para procurar no minusculo
        para (inteiro j = 0; j < Texto.numero_caracteres(alfabetoMinusculo); j++) {
          se (charAtual == Texto.obter_caracter(alfabetoMinusculo, j)) {
            indiceNoAlfabeto = j
            pare // Achou, sai do loop interno
          }
        }

        // Se encontrou no alfabeto minusculo
        se (indiceNoAlfabeto != -1) {
          inteiro novoIndice = 0
          se (operacaoEscolhida == "criptografar") {
            novoIndice = (indiceNoAlfabeto + chaveDeslocamento) % 26
          } senao se (operacaoEscolhida == "descriptografar") {
            // --- MUDANÇA AQUI PARA GARANTIR INDICE POSITIVO ---
            novoIndice = (indiceNoAlfabeto - chaveDeslocamento) % 26
            // Se o resultado do módulo for negativo, adicione 26 para torná-lo positivo.
            se (novoIndice < 0) {
                novoIndice = novoIndice + 26
            }
          }
          mensagemResultante = mensagemResultante + Texto.obter_caracter(alfabetoMinusculo, novoIndice)
        }
        // Se nao eh letra (nem maiuscula nem minuscula)
        senao {
          mensagemResultante = mensagemResultante + charAtual // Mantem o caractere original
        }
      }
    } // Fim do loop 'para' principal

    // 3. Exibicao do resultado final
    se (operacaoEscolhida == "criptografar") {
      escreva("Mensagem criptografada: ", mensagemResultante, "\n")
    } senao se (operacaoEscolhida == "descriptografar") {
      escreva("Mensagem descriptografada: ", mensagemResultante, "\n")
    } senao {
      escreva("Operação inválida. Por favor, escolha 'criptografar' ou 'descriptografar'.\n")
    }
  }
}