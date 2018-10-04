# Unit Test Creator Tool - UTCTOOL

Ferramenta para fazer a captura de ações do usuario em tempo real em qualquer rotina MVC (Inclusive com BrowseDef).

A Unit Test Creator Tool foi desenvolvida para facilitar a criação de casos de testes apenas utilizando a rotina alvo pelo SmartClient o caso de teste é gerado automaticamente de acordo com as ações efetuadas!

### Novas Functionalidades
+ Geração automática do Caso de Teste em texto para inclusão no Kanoah
+ Geração do arquivo .PRW (casos de testes utilizados no Brasil)
+ Geração do arquivo CSV (template) para casos de teste (http://tdn.totvs.com/pages/viewpage.action?pageId=273302121)
+ Geração dos arquivos TestSuite e TestGroup (ações relacionadas do Browse)

### Em desenvolvimento
+ Perceutal de cobertuda do fonte ao finalizar a criação do teste (Coverage)

### Tipos de teste
+ Inclusão de registro
+ Alteração de registro
+ Exclusão de registro
+ Testes negativos (validação de campo, modelo e submodelo)

### Utilização
1 - Aplicar tttp120_UTCTOOL.prw
2 - executar o smartclient com os seguintes parametros de atalho


`...\SmartClient.exe -m -p=sigabpm -c=[conexão] -e=[ambiente] -a=2 -a=UTCTOOL`



Inserir o codigo fonte desejado (rotina)

![Rotina!](/docs/im1.png "Rotina")

####Iniciar o teste

![Teste!](/docs/im2.png "Teste")

![Continuação!](/docs/im3.png "Teste")

####Teste negativo

![Negativo!](/docs/im4.png "Negativo")


####Nomear o arquivo após finalizar o teste clicando em confirmar ou fechar (fechar apenas em caso de teste negativo)

![Name!](/docs/im5.png "Name")

####Verificar a geração do arquivo na pasta system
PRW ou CSV

![Template!](/docs/im6.png "Geração")

Video de exemplo: 
![Video!](/docs/UTCTOOL.mp4 "Video")

### Funcionalidades possiveis (colaboradores?)
+ Inclusão automática do Kanoah
+ Verificação de tempo/performance das rotinas sem a necessidade de alterar as rotinas padrões
+ mais

### Conhecimentos necessários
FwModelEvent (http://tdn.totvs.com/pages/viewpage.action?pageId=269552294)

em caso da geração CSV (Russia)
Casos de teste por template (http://tdn.totvs.com/pages/viewpage.action?pageId=273302121)