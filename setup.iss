; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���
;#define OUTPUTDIR   "��������"
;#define PRINTTYPE   "0"
;#define MerchantId  "888051053110001"
;#define Print       "COM3"
;#define DSHH        "000301"
;#define GunPort     "USB"
;��װ������1����װ�ļ���C�� ע����� ����ini�ļ�;
;1.��װ��C
[Setup]
PrivilegesRequired=admin
AppName=OK��Ǯ��
AppVersion=1.0
DefaultDirName=C:\p_reg
VersionInfoVersion=1.0.0.0
OutputDir={#OUTPUTDIR}
OutputBaseFilename=OKPay
DefaultGroupName=OKPay
;������ж�س���
Uninstallable=no
DisableDirPage=yes
DisableFinishedPage=yes
DisableStartupPrompt=yes
;DisableReadyMemo=yes
;DisableReadyPage=yes
;��������
[Files]
Source: "p_reg\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "p_reg\OKPay2.ini"; DestDir: "{tmp}" ;Flags: noencryption dontcopy
Source: "p_reg\COMDLG32.OCX"; DestDir: "{app}"; Flags: ignoreversion regserver noregerror    
Source: "p_reg\MSCOMM32.OCX"; DestDir: "{app}"; Flags: ignoreversion regserver  noregerror
Source: "p_reg\MSWINSCK.OCX"; DestDir: "{app}"; Flags: ignoreversion regserver   noregerror
Source: "p_reg\msxml3.dll"; DestDir: "{app}"; Flags: ignoreversion regserver noregerror
Source: "p_reg\P_LhTransProject.dll"; DestDir: "{app}"; Flags: ignoreversion regserver
Source: "p_reg\SCRRUN.DLL"; DestDir: "{app}"; Flags: ignoreversion regserver    noregerror
Source: "p_reg\trans.ocx"; DestDir: "{app}"; Flags: ignoreversion regserver     noregerror
 
;��Ҫ���õ�����  
[INI]
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"ClientNo";String:"{code:GetUser|4.0}"
Filename: "{app}\OKPay2.ini"; Section: "TRADE";Key:"POSID";String:"{code:GetUser|3.0}"
Filename: "{app}\OKPay2.ini"; Section: "Merchant";Key:"MerchantName";String:{#OUTPUTDIR}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"PrintType";String:{#PRINTTYPE}
Filename: "{app}\OKPay2.ini"; Section: "Merchant";Key:"MerchantId";String:{#MerchantId}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"Print";String:{#Print}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"GunPort";String:{#GunPort}
Filename: "{app}\OKPay2.ini"; Section: "TRADE";Key:"DSHH";String:{#DSHH}
;��װ�������
[Run]
Filename: "{app}\reg.bat" ;StatusMsg: "����ע�����"
Filename: "{app}\�����ļ��޸���.exe" ; StatusMsg: "�������ļ��޸���";   Flags: skipifsilent shellexec runhidden nowait postinstall

;�Զ������
[Code]
var
  UserPage: TInputQueryWizardPage; 
  clientNo:String;
  PosId:String;
  //key:String;
procedure CreateAddonPage;
begin
UserPage := CreateInputQueryPage(wpSelectDir,
    '�ն˺���Ϣ', '',
    '������4.0��3.0 �ն˺�');
  UserPage.Add('4.0�ն˺�:', False);
  UserPage.Add('3.0�ն˺�:', False);
  UserPage.Values[0]:=clientNo;
  UserPage.Values[1]:=PosId;
end;

procedure InitializeWizard();
begin
      //���� �����ն˺�
       CreateAddonPage   ;
end;
//�õ��Զ������ UserPage�е�����
function GetUser(Param: String): String;
begin
  if Param = '4.0' then
    Result := UserPage.Values[0]
  else if Param = '3.0' then
    Result := UserPage.Values[1];
end;

//function GetKey(Param: String): String;
//var tmp:Text;
//var s:TArrayOfString;
//begin
//     LoadStringsFromFile(Param,s)
//end;


function killhsic_pos(Param: String):Boolean;
var appWnd: HWND;
begin
  Result := true;
  appWnd := FindWindowByWindowName('HSIC_POS');
  if (appWnd <> 0) then
     //���̴��ڣ��ر�
     begin
        PostMessage(appWnd, 18, 0, 0);       // quit
     end else
     //���̲����� 
     begin 
        //Log('Not Runing...');
     end;
end;


//function killprocess(Param: String):Boolean;
//var
//RCode: Integer;
//begin
//Exec('C:\Users\lenovo\Desktop\OKPay2Test.exe','','', SW_SHOW, ewNoWait, RCode);// ===�Լ�����\
//Result:=True;
//end;

//��ȡ��ʱ�ļ��е���������
function InitializeSetup: Boolean;
//var filename:String;
//var MerchantId:String;
begin
  //��ȡ�����ļ�
  ExtractTemporaryFile('OKPay2.ini');
  killhsic_pos('�ޱ��� - ���±�');
  clientNo:=ExpandConstant('{ini:{tmp}\OKPay2.ini,CashRegister,ClientNo}');
  //MerchantId:=ExpandConstant('{ini:{tmp}\OKPay2.ini,Merchant,MerchantId}');
  //filename:=MerchantId+'_'+clientNo+'_.properties';
  PosId:=ExpandConstant('{ini:{tmp}\OKPay2.ini,TRADE,POSID}');
  Result := True;
end;

