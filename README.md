# Unit Test Creator Tool - UTCTOOL

Ferramenta para fazer a captura de ações do usuario em tempo real em qualquer rotina MVC.

A Unit Test Creator Tool foi desenvolvida para facilitar a criação de casos de testes apenas utilizando a rotina alvo pelo SmartClient o caso de teste é gerado automaticamente de acordo com as ações efetuadas!

### Novas Functionalidades
+ Geração automática do Caso de Teste de Interface em Python para utilizar o TIR (https://github.com/totvs/tir)
+ Geração automática do Caso de Teste em texto para inclusão no Kanoah
+ Geração do arquivo .PRW (casos de testes utilizados no Brasil)

### Em desenvolvimento
+ Perceutal de cobertuda do fonte ao finalizar a criação do teste (Coverage)

### Tipos de teste
+ Inclusão de registro
+ Alteração de registro
+ Exclusão de registro
+ Testes negativos (validação de campo, modelo e submodelo)

### Utilização
1 - Atualizar a LIB RC23 (http://arte.engpro.totvs.com.br/totvstec_framework/lib/lib/versao12/lobo-guara/RC23/)

2 - Aplicar tttp120_V3_00_x64.prw

3 - executar o smartclient com os seguintes parametros de atalho


`...\SmartClient.exe -m -p=SIGABPM -c=[conexão] -e=[ambiente] -a=[NUMERO DO MODULO] -a=UTCTOOL`



Inserir o codigo fonte desejado (rotina)

![Rotina!](/docs/im1.png "Rotina")

#### Iniciar o teste

![Teste!](/docs/im2.png "Teste")

![Continuação!](/docs/im3.png "Teste")

#### Teste negativo

![Negativo!](/docs/im4.png "Negativo")

#### Escolher os arquivos que deseja gerar

![files!](/docs/im9.png "Files")

#### Nomear o arquivo após finalizar o teste clicando em confirmar ou fechar (fechar apenas em caso de teste negativo)

![Name!](/docs/im5.png "Name")


#### Verificar a geração dos arquivos na pasta system
TestCase (PRW), Kanoah (Texto) e TIR (python)

![Template!](/docs/im6.png "Geração")
![python!](/docs/im7.png "Geração")
![Kanoah!](/docs/im8.png "Geração")

Video de exemplo: 
![Video!](/docs/UTCTOOL.mp4 "Video")

Video Coffe & Code UTCTOOL: 
https://drive.google.com/open?id=11uhiKFwW-fio2XUYivpy-0qaifMpEVPE

### Funcionalidades possiveis (colaboradores?)
+ Inclusão automática do Kanoah
+ Verificação de tempo/performance das rotinas sem a necessidade de alterar as rotinas padrões
+ Inclusão de parametro automatico (MV_)
+ Inclusão de parametro automatico F12
+ mais

### Conhecimentos necessários
FwModelEvent (http://tdn.totvs.com/pages/viewpage.action?pageId=269552294)

em caso da geração CSV (Russia)
Casos de teste por template (http://tdn.totvs.com/pages/viewpage.action?pageId=273302121)
