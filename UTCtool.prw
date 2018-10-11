#Include 'Protheus.ch'
#INCLUDE 'FWMVCDEF.CH' 

static cRoutine as Character
static lLocaliza
//-------------------------------------------------------------------
/*/{Protheus.doc} UTCTool
Unite Test Creator Tool
Creation of TestCases, Group, Suite and CSV files for unit
test
@author andrews.egas
@since 05/04/2018
@version 1.0
/*/
//-------------------------------------------------------------------
Function UTCTool()
Local oBrowse as Object
Local nRepeat as numeric

cRoutine := "code"
nRepeat := 1
While nRepeat == 1 .AND. !Empty(cRoutine)
	//source code
	cRoutine := Alltrim(GetRoutine("Routine"))

	cRoutine := alltrim(cRoutine)
	If !Empty(cRoutine)
		if !Empty( cPaisLoc ) .AND. FindFunction( cRoutine + cPaisLoc )
			lLocaliza := .T.	
		EndIf

		//IF MVC
		oBrowse := ToolBrowseDef()
		If ValType(oBrowse) <> "L"
			oBrowse:Activate()
			nRepeat := 0
		Elseif !oBrowse
			nRepeat := 1
			Alert("It's not MVC routine or there is no BrowseDef")
		EndIf
	EndIf

EndDo

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} BrowseDef
Browse definition

@author Andrews Egas
@since 05/04/2018
@version MA3 - Russia
/*/
//-------------------------------------------------------------------
Static Function ToolBrowseDef() //the name must be different 
Local oBrowse 

oBrowse := FWLoadBrw(cRoutine)

If ValType(oBrowse) <> "U"
	oBrowse:CMENUDEF := "UTCTOOL" //Change menudef to call UTCTOLL in stead of cRoutine menudef
Else
	oBrowse := .F.
EndIf

Return oBrowse 

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
Menu definition

@author Andrews Egas
@since 05/04/2018
@version MA3 - Russia
/*/
//-------------------------------------------------------------------
Static Function MenuDef()
Local aRotina as array

If lLocaliza //here we need to call in a different way
	aRotina :=  FWLoadMenuDef(cRoutine + cPaisLoc)
Else
	aRotina :=  FWLoadMenuDef(cRoutine)
EndIf

ADD OPTION aRotina TITLE "Parameters" ACTION 'UTCParam()' OPERATION 9 ACCESS 0
ADD OPTION aRotina TITLE "Create Source Code" ACTION 'UTCSources()' OPERATION 9 ACCESS 0

Return aRotina

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef
Interface
@author Andrews Egas
@since 05/04/2018
@version 1.0
@project MA3
/*/
//-------------------------------------------------------------------
Static Function ViewDef()
Local oView	as object
Local oModel as Object
Local oUTCTool   := UTCClass():New()

Conout("UTCViewDef")
If lLocaliza
	oView	:= FWLoadView(cRoutine + cPaisLoc)
Else
	oView	:= FWLoadView(cRoutine)
EndIf
oModel := oView:GetModel()
oModel:InstallEvent("UTCClass",,oUTCTool) //install events to work UTCTOOL while user is "creating the test"

oView:SetModel(oModel)

oUTCTool:SetProgram(cRoutine)

oView:AddUserButton("Negative Test",'TEST',{|| oUTCTool:SetNegative()}) //Negative Test

Return oView

//-------------------------------------------------------------------
/*/{Protheus.doc} GetRoutine
User Interface Function to get the routine
@author Andrews Egas
@since 05/04/2018
@version 1.0
@project MA3
/*/
//-------------------------------------------------------------------
Function GetRoutine(cTitulo)
Local oDlg, oButton, oCombo, cCombo, cGet1:= space(15)
DEFINE MSDIALOG oDlg FROM 0,0 TO 150,250 PIXEL TITLE cTitulo
oGet1:= TGet():New(10,10,{|u| if(PCount()>0,cGet1:=u,cGet1)}, oDlg,;
100,15,'@!',;
,,,,,,.T.,,,,,,,,,,'cGet1')
oButton:=tButton():New(30,10,'Ok',oDlg,{||oDlg:End()},100,15,,,,.T.)
ACTIVATE MSDIALOG oDlg CENTERED
Return cGet1

//-------------------------------------------------------------------
/*/{Protheus.doc} UTCParam
Open parameters (pergunte) for routine
@author Andrews Egas
@since 05/04/2018
@version 1.0
@project MA3
/*/
//-------------------------------------------------------------------
Function UTCParam()
Local cPerg as Character
cPerg := Alltrim(GetRoutine("Pergunte Code"))

Pergunte(cPerg,.T.)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} UTCSources
Creation of TestCase, Group and Suite
@author Andrews Egas
@since 05/04/2018
@version 1.0
@project MA3
/*/
//-------------------------------------------------------------------
Function UTCSources()
Local nBFile as numeric
Local cFileName as Character
Local cContFile as Character
Local n as numeric
Local lRet as Logical
lRet := .F.
For n:= 1 to 3
	If n == 1
		cFileName := cRoutine + "TestCase" + IIF(lLocaliza,"_" + cPaisLoc,"")
		cContFile := UTCCase(cRoutine,cFileName) //take testcase code to create
	Elseif n == 2
		cFileName := cRoutine + "TestGroup"
		cContFile := UTCGroup(cRoutine,cFileName) //take testgroup code to create
	Else
		cFileName := cRoutine + "TestSuite"
		cContFile := UTCSuite(cRoutine,cFileName) //take testSuite code to create
	EndIf

	If !File(cFileName + ".PRW") //check if the file already exist
		nBFile := FCREATE(cFileName + ".PRW")

		FWRITE(nBFile,cContFile)
		FCLOSE(nBFile)
		lRet := .T.
	Else
		Alert("Already exist " + cFileName + ".PRW")
	EndIf
Next

If lRet
	MsgInfo("files have been successfully generated"," Source Codes ")
EndIf

Return


/*/{Protheus.doc} UTCCase
Content of TestCase source code
@author Andrews Egas
@since 31/05/2018
@version 1.0
@project MA3
/*/
Function UTCCase(cRoutine,cFileName)
Local cRet as Character
cRet := ""

cRet += "#INCLUDE 'PROTHEUS.CH'" + CRLF
cRet += "#INCLUDE 'PARMTYPE.CH'" + CRLF
cRet += "#INCLUDE 'FWMVCDEF.CH'" + CRLF + CRLF


cRet += "/*/{Protheus.doc} " + cFileName 	+ CRLF
cRet += "Automated tests" 					+ CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "@see        FWDefaultTestSuit , FWDefaultTestCase"	+ CRLF
cRet += "/*/"+ CRLF

cRet += "CLASS " + cFileName + " from FWDefaultTestCase" + CRLF + CRLF
cRet += "DATA oHelper" + CRLF + CRLF

cRet += "METHOD " + cFileName + "() CONSTRUCTOR" + CRLF
cRet += "METHOD SetUpClass()" + CRLF
cRet += "METHOD " + cRoutine + "_01()" + CRLF + CRLF

cRet += "ENDCLASS" + CRLF + CRLF

cRet += "/*/{Protheus.doc} " + cFileName + ":" + cFileName + "()" + CRLF

cRet += cFileName + " constructor method" 	+ CRLF
cRet += "Instantiation of test cases" 		+ CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF
cRet += "METHOD " + cFileName + "() CLASS " + cFileName + CRLF + CRLF

cRet += "//--------------------------------------"	+ CRLF
cRet += "// Inherit parent object characteristics"	+ CRLF
cRet += "//--------------------------------------"	+ CRLF
cRet += "_Super:FWDefaultTestSuite()"				+ CRLF + CRLF

cRet += "//--------------------------------------------" 	+ CRLF
cRet += "// Add test methods to the queue"					+ CRLF
cRet += "//--------------------------------------------"	+ CRLF
cRet += "::AddTestMethod('" + cRoutine + "_01',, 'auto creation utctool')" + CRLF + CRLF

cRet += "Return"  + CRLF + CRLF

cRet += "/*/{Protheus.doc} " + cFileName + ":SetUpClass()"  + CRLF
cRet += "Instantiation of FWTestHelper class"  + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" 								+ CRLF
cRet += "METHOD SetUpClass() CLASS " + cFileName + CRLF + CRLF

cRet += "Local oHelper   := FWTestHelper():New()" + CRLF + CRLF

cRet += "Return oHelper" + CRLF + CRLF


cRet += "/*/{Protheus.doc} " + cFileName + ":" + cRoutine + "_01()" + CRLF
cRet += "auto creation" + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF
cRet += "METHOD " + cRoutine + "_01() CLASS " + cFileName + CRLF + CRLF
If cPaisLoc == 'RUS'
	cRet += "Return " + cRoutine + "TC('" + cRoutine + "_01','" + cRoutine + "')" + CRLF + CRLF


	cRet += "/*/{Protheus.doc} " + cRoutine + "TC" + CRLF
	cRet += "Static function to encapsulate MVC tests with CSV files " + CRLF
	cRet += "@param		cCase = Identifier string for the test case" + CRLF
	cRet += "			cModel = MVC Model" + CRLF
	cRet += "@return		FWTestHelper" + CRLF
	cRet += "@author 	UTCTOOL"				+ CRLF
	cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
	cRet += "@version 	1.0"					+ CRLF
	cRet += "/*/" 								+ CRLF
	cRet += "Static Function " + cRoutine + "TC( cCase, cModel)" + CRLF
	cRet += "Local oModel		:= FWLoadModel( cModel )" + CRLF
	cRet += "Local oHelper	:= FWScriptAuto():New()" + CRLF + CRLF

	cRet += "oHelper:LoadCSV( cCase )" + CRLF
	cRet += "If oHelper:IsOk()" + CRLF
	cRet += "	oModel:SetOperation( oHelper:nOper )" + CRLF
	cRet += "	oModel:Activate()" + CRLF + CRLF
	cRet += "	oHelper:SetModel( oModel )" + CRLF
	cRet += "	oHelper:SetCommit()" + CRLF
	cRet += "	oHelper:Activate()" + CRLF
	cRet += "Endif" + CRLF + CRLF

	cRet += "Return oHelper:GetOHelper()" + CRLF
Else
	cRet += "Return oHelper"
EndIf

Return cRet

/*/{Protheus.doc} UTCGroup
Content of TestCase source code
@author Andrews Egas
@since 31/05/2018
@version 1.0
@project MA3
/*/
Function UTCGroup(cRoutine,cFileName)
Local cRet as Character
Local cCase as Character
cRet := ""

cRet += "#INCLUDE 'PROTHEUS.CH'" + CRLF
cRet += "#INCLUDE 'PARMTYPE.CH'" + CRLF + CRLF


cRet += "/*/{Protheus.doc} " + cFileName + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF

cRet += "CLASS " + cFileName + " FROM FWDefaultTestSuite" + CRLF + CRLF

cRet += "METHOD " + cFileName + "() CONSTRUCTOR" + CRLF + CRLF

cRet += "ENDCLASS" + CRLF + CRLF

cRet += "/*/{Protheus.doc} " + cFileName + ":" + cFileName + "()" + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF

cRet += "METHOD " + cFileName + "() CLASS " + cFileName + CRLF  + CRLF
 
cRet += "//--------------------------------------" + CRLF
cRet += "// Inherit parent object characteristics" + CRLF
cRet += "//--------------------------------------" + CRLF
cRet += "_Super:FWDefaultTestSuite()" + CRLF + CRLF

cRet += "//---------------------------------------------------" + CRLF
cRet += "// Add the test cases to the group" + CRLF
cRet += "//---------------------------------------------------" + CRLF

cCase := cRoutine + "TestCase" + IIF(lLocaliza,"_"+cPaisLoc,"") //take the testcase name
cRet += "Self:AddTestCase(" + cCase + "():" + cCase + "())" + CRLF + CRLF

cRet += "Return" + CRLF

Return cRet

/*/{Protheus.doc} UTCGroup
Content of TestCase source code
@author Andrews Egas
@since 31/05/2018
@version 1.0
@project MA3
/*/
Function UTCSuite(cRoutine,cFileName)
Local cRet as Character
Local cCompany as Character
Local cBranch as Character
Local cUser as Character
Local cPass as Character
cRet := ""
//values, it must be changed for some parameter
cCompany 	:= "T1"
cBranch 	:= "D MG 01"
cUser 		:= "admin"
cPass		:= "1234"
//-------------------------

cRet += "#INCLUDE 'PROTHEUS.CH'" + CRLF
cRet += "#INCLUDE 'PARMTYPE.CH'" + CRLF + CRLF


cRet += "/*/{Protheus.doc} " + cFileName + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF
cRet += "CLASS " + cFileName + " FROM FWDefaultTestSuite" + CRLF + CRLF

cRet += "DATA aParam" + CRLF
    
cRet += "METHOD " + cFileName + "() CONSTRUCTOR" + CRLF
cRet += "METHOD SetUpSuite()" + CRLF
cRet += "METHOD TearDownSuite()" + CRLF + CRLF

cRet += "ENDCLASS" + CRLF

cRet += "/*/{Protheus.doc} " + cFileName + ":" + cFileName + "()" + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF
cRet += "METHOD "+ cFileName + "() CLASS " + cFileName + CRLF + CRLF

cRet += "//--------------------------------------"+ CRLF
cRet += "// Inherit parent object characteristics"+ CRLF
cRet += "//--------------------------------------"+ CRLF
cRet += "_Super:FWDefaultTestSuite()"+ CRLF + CRLF

cRet += "//------------------------------------------------------"+ CRLF
cRet += "// List used TestGroups"+ CRLF
cRet += "//------------------------------------------------------"+ CRLF

cRet += "Self:AddTestSuite(" + cRoutine + "TestGroup():" + cRoutine + "TestGroup()) " + CRLF + CRLF

cRet += "Return" + CRLF + CRLF

cRet += "/*/{Protheus.doc} " + cFileName + ":SetUpSuite()" + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF
cRet += "METHOD SetUpSuite() CLASS " + cFileName + CRLF
cRet += "Local oHelper	:= FWTestHelper():New()" + CRLF
cRet += "Local cIniEmp	:= GetSrvProfString('ADVPR_EMP','"+ cCompany +"') //company" + CRLF
cRet += "Local cIniFil	:= GetSrvProfString('ADVPR_FIL','" + cBranch + "') //branch" + CRLF
cRet += "Local cIniUser	:= GetSrvProfString('ADVPR_USER','"+ cUser +"') //user" + CRLF
cRet += "Local cIniPass	:= GetSrvProfString('ADVPR_PASSWORD','" + cPass + "') //password" + CRLF + CRLF

cRet += "//-------------------------------------" + CRLF
cRet += "// Prepare testing environment" + CRLF
cRet += "//-------------------------------------" + CRLF
cRet += "oHelper:UTOpenFilial(cIniEmp,cIniFil,Nil,Nil,cIniUser,cIniPass)" + CRLF
cRet += "//-----------------------------------------" + CRLF
cRet += "// Parametrization setup" + CRLF
cRet += "//-----------------------------------------" + CRLF
cRet += "//oHelper:UTSetParam('MV_CTBCUBE' , '1', .T.)" + CRLF + CRLF

cRet += "//-------------------------------------" + CRLF
cRet += "// Activate auxiliary class" + CRLF
cRet += "//-------------------------------------" + CRLF
cRet += "oHelper:Activate()" + CRLF

cRet += "oHelper:UTLoadData( .T., ::aParam )" + CRLF

cRet += "Return oHelper" + CRLF + CRLF


cRet += "/*/{Protheus.doc} " + cFileName + ":TearDownSuite()" + CRLF
cRet += "@author 	UTCTOOL"				+ CRLF
cRet += "@since 		" + dtoc(dDatabase)	+ CRLF
cRet += "@version 	1.0"					+ CRLF
cRet += "/*/" + CRLF
cRet += "METHOD TearDownSuite() CLASS " + cFileName + CRLF
cRet += "Local oHelper   := FWTestHelper():New()" + CRLF + CRLF

cRet += "//----------------------------------------" + CRLF
cRet += "// Restore system default parameterization" + CRLF
cRet += "//----------------------------------------" + CRLF
cRet += "oHelper:UTRestParam(::aParam)" + CRLF

cRet += "//----------------------" + CRLF
cRet += "// Close the environment" + CRLF
cRet += "//----------------------" + CRLF
cRet += "oHelper:UTCloseFilial()" + CRLF

cRet += "Return oHelper" + CRLF

Return cRet
// Russia_R5
