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
OutputDir=ͨ�ð�
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
Source: "p_reg\*"; DestDir: "{app}"; Flags: ignoreversion  createallsubdirs     recursesubdirs
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
Filename: "{app}\OKPay2.ini"; Section: "Merchant";Key:"MerchantName";String:{code:getKey|MerchantName}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"PrintType";String:{code:getKey|PrintType}
Filename: "{app}\OKPay2.ini"; Section: "Merchant";Key:"MerchantId";String:{code:getKey|MerchantId}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"Print";String:{code:getKey|Print}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"GunPort";String:{code:getKey|GunPort}
Filename: "{app}\OKPay2.ini"; Section: "TRADE";Key:"DSHH";String:{code:getKey|DSHH}
Filename: "{app}\OKPay2.ini"; Section: "CashRegister";Key:"PrintBaud";String:{code:getKey|PrintBaud}

;��װ�������
[Run]
;Filename: "{src}\copykey.bat";StatusMsg: "������Կ"
Filename: "{app}\reg.bat" ;StatusMsg: "����ע�����";
Filename: "{app}\�����ļ��޸���.exe" ; StatusMsg: "�������ļ��޸���";   Flags: skipifsilent shellexec runhidden nowait postinstall

;�Զ������
[Code]
var
  UserPage: TInputQueryWizardPage; 
  clientNo:String;
  PosId:String;
  MerchantName:String;
  MerchantId:String;
  PrintType:String;
  Print:String;
  PrintBaud:String;
  GunPort:String;
  DSHH:String;
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
       CreateAddonPage;
end;
//�õ��Զ������ UserPage�е�����
function GetUser(Param: String): String;
begin
  if Param = '4.0' then
    Result := UserPage.Values[0]
  else if Param = '3.0' then
    Result := UserPage.Values[1];
end;

function getKey(param:String):String;
begin
  if param= 'MerchantName' then
    Result := MerchantName
   else if param='MerchantId' then
    Result := MerchantId
  else if param = 'PrintType' then
     Result := PrintType
  else if param ='Print' then
    Result := Print
  else if param ='PrintBaud' then
    Result := PrintBaud
  else if param ='GunPort' then
    Result := GunPort
  else if param ='DSHH' then
    Result := DSHH;
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
 var
 rcode:Integer;
 path:String;
 printport:String;
 leng:Integer;
 i:Integer;
 tmp2:String;
begin
  //��ȡ�����ļ�
  ExtractTemporaryFile('OKPay2.ini');
  //ɱ����
  killhsic_pos('HSIC_POS');
  
  clientNo:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,ClientNo}');
  MerchantName:=ExpandConstant('{ini:{src}\OKPay2.ini,Merchant,MerchantName}');
  MerchantId:=ExpandConstant('{ini:{src}\OKPay2.ini,Merchant,MerchantId}');
  PrintType:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,PrintType}');
  
  //Print:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,Print}');
  //�ɴ�pos.ini��ȡ�Ĳ���
  PosId:=ExpandConstant('{ini:{pf}\HSIC_POS\POS.ini,NAMECODE,RegisterNo}');
  
  //Print:=ExpandConstant('{ini:{pf}\HSIC_POS\POS.ini,DEV,PrintPort}');
  //leng:=length(Print);
  //i := pos(':',Print);
  
  //if i = leng then
  //begin
  // Print:=Copy(Print,0,i-1)
  // log(Print);
  // end
  //else
   Print:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,Print}');
  
  //GunPort:=ExpandConstant('{ini:{pf}\HSIC_POS\POS.ini,ComToKey,Port}');
  //if GunPort = '' then
  //  begin
    GunPort:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,GunPort}');
  //  end
  //else
  //  begin
  //    leng:=length(GunPort);
  //    i:= pos(':',GunPort);
  //    GunPort:=Copy(GunPort,4,i-4) ;
  //  end
    
  
  
  PrintBaud:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,PrintBaud}');
 // GunPort:=ExpandConstant('{ini:{src}\OKPay2.ini,CashRegister,GunPort}');
  DSHH:=ExpandConstant('{ini:{src}\OKPay2.ini,TRADE,DSHH}');
  //filename:=MerchantId+'_'+clientNo+'_.properties';


    //������Կ�ļ���
    path:='/c xcopy ' + ExpandConstant('{src}') + '\��Կ\*.* ' +   'c:\p_reg\��Կ\ /R /S /Y';

  Exec('cmd.exe',path,'',  SW_HIDE, ewNoWait, rcode);

  
  
  tmp2:=   InttoStr(rcode);

  Result := True;
end;

