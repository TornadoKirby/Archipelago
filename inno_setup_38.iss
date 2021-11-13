#define sourcepath "build\exe.win-amd64-3.8"
#define MyAppName "Archipelago"
#define MyAppExeName "ArchipelagoServer.exe"
#define MyAppIcon "data/icon.ico"
#dim VersionTuple[4]
#define MyAppVersion ParseVersion('build\exe.win-amd64-3.8\ArchipelagoServer.exe', VersionTuple[0], VersionTuple[1], VersionTuple[2], VersionTuple[3])
#define MyAppVersionText Str(VersionTuple[0])+"."+Str(VersionTuple[1])+"."+Str(VersionTuple[2])


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
AppId={{918BA46A-FAB8-460C-9DFF-AE691E1C865B}}
AppName={#MyAppName}
AppCopyright=Distributed under MIT License
AppVerName={#MyAppName} {#MyAppVersionText}
VersionInfoVersion={#MyAppVersion}
DefaultDirName={commonappdata}\{#MyAppName}
DisableProgramGroupPage=yes
DefaultGroupName=Archipelago
OutputDir=setups
OutputBaseFilename=Setup {#MyAppName} {#MyAppVersionText}
Compression=lzma2
SolidCompression=yes
LZMANumBlockThreads=8
ArchitecturesInstallIn64BitMode=x64
ChangesAssociations=yes
ArchitecturesAllowed=x64
AllowNoIcons=yes
SetupIconFile={#MyAppIcon}
UninstallDisplayIcon={app}\{#MyAppExeName}
; you will likely have to remove the following signtool line when testing/debugging locally. Don't include that change in PRs.
SignTool= signtool
LicenseFile= LICENSE
WizardStyle= modern
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Types]
Name: "full"; Description: "Full installation"
Name: "hosting"; Description: "Installation for hosting purposes"
Name: "playing"; Description: "Installation for playing purposes"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "core"; Description: "Core Files"; Types: full hosting playing custom; Flags: fixed
Name: "generator"; Description: "Generator"; Types: full hosting
Name: "generator/sm"; Description: "Super Metroid ROM Setup"; Types: full hosting; ExtraDiskSpaceRequired: 3145728
Name: "generator/soe"; Description: "Secret of Evermore ROM Setup"; Types: full hosting; ExtraDiskSpaceRequired: 3145728
Name: "generator/lttp"; Description: "A Link to the Past ROM Setup and Enemizer"; Types: full hosting; ExtraDiskSpaceRequired: 5191680
Name: "generator/oot"; Description: "Ocarina of Time ROM Setup"; Types: full hosting; ExtraDiskSpaceRequired: 100663296
Name: "server"; Description: "Server"; Types: full hosting
Name: "client"; Description: "Clients"; Types: full playing
Name: "client/sni"; Description: "SNI Client"; Types: full playing
Name: "client/sni/lttp"; Description: "SNI Client - A Link to the Past Patch Setup"; Types: full playing
Name: "client/sni/sm"; Description: "SNI Client - Super Metroid Patch Setup"; Types: full playing
Name: "client/factorio"; Description: "Factorio"; Types: full playing
Name: "client/minecraft"; Description: "Minecraft"; Types: full playing; ExtraDiskSpaceRequired: 226894278
Name: "client/text"; Description: "Text, to !command and chat"; Types: full playing

[Dirs]
NAME: "{app}"; Flags: setntfscompression; Permissions: everyone-modify users-modify authusers-modify;

[Files]
Source: "{code:GetROMPath}"; DestDir: "{app}"; DestName: "Zelda no Densetsu - Kamigami no Triforce (Japan).sfc"; Flags: external; Components: client/sni/lttp or generator/lttp
Source: "{code:GetSMROMPath}"; DestDir: "{app}"; DestName: "Super Metroid (JU).sfc"; Flags: external; Components: client/sni/sm or generator/sm
Source: "{code:GetSoEROMPath}"; DestDir: "{app}"; DestName: "Secret of Evermore (USA).sfc"; Flags: external; Components: generator/soe
Source: "{code:GetOoTROMPath}"; DestDir: "{app}"; DestName: "The Legend of Zelda - Ocarina of Time.z64"; Flags: external; Components: generator/oot
Source: "{#sourcepath}\*"; Excludes: "*.sfc, *.log, data\sprites\alttpr, SNI, EnemizerCLI, Archipelago*.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#sourcepath}\SNI\*"; Excludes: "*.sfc, *.log"; DestDir: "{app}\SNI"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: client/sni
Source: "{#sourcepath}\EnemizerCLI\*"; Excludes: "*.sfc, *.log"; DestDir: "{app}\EnemizerCLI"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: generator/lttp

Source: "{#sourcepath}\ArchipelagoGenerate.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: generator
Source: "{#sourcepath}\ArchipelagoServer.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: server
Source: "{#sourcepath}\ArchipelagoFactorioClient.exe";  DestDir: "{app}"; Flags: ignoreversion; Components: client/factorio
Source: "{#sourcepath}\ArchipelagoTextClient.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: client/text
Source: "{#sourcepath}\ArchipelagoSNIClient.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: client/sni
Source: "{#sourcepath}\ArchipelagoLttPAdjuster.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: client/sni/lttp or generator/lttp
Source: "{#sourcepath}\ArchipelagoMinecraftClient.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: client/minecraft
Source: "vc_redist.x64.exe"; DestDir: {tmp}; Flags: deleteafterinstall

;minecraft temp files
Source: "{tmp}\forge-installer.jar"; DestDir: "{app}"; Flags: skipifsourcedoesntexist external deleteafterinstall; Components: client/minecraft

[Icons]
Name: "{group}\{#MyAppName} Folder"; Filename: "{app}";
Name: "{group}\{#MyAppName} Server"; Filename: "{app}\{#MyAppExeName}"; Components: server
Name: "{group}\{#MyAppName} Text Client"; Filename: "{app}\ArchipelagoTextClient.exe"; Components: client/text
Name: "{group}\{#MyAppName} SNI Client"; Filename: "{app}\ArchipelagoSNIClient.exe"; Components: client/sni
Name: "{group}\{#MyAppName} Factorio Client"; Filename: "{app}\ArchipelagoFactorioClient.exe"; Components: client/factorio
Name: "{group}\{#MyAppName} Minecraft Client"; Filename: "{app}\ArchipelagoMinecraftClient.exe"; Components: client/minecraft
Name: "{commondesktop}\{#MyAppName} Folder"; Filename: "{app}"; Tasks: desktopicon
Name: "{commondesktop}\{#MyAppName} Server"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Components: server
Name: "{commondesktop}\{#MyAppName} SNI Client"; Filename: "{app}\ArchipelagoSNIClient.exe"; Tasks: desktopicon; Components: client/sni
Name: "{commondesktop}\{#MyAppName} Factorio Client"; Filename: "{app}\ArchipelagoFactorioClient.exe"; Tasks: desktopicon; Components: client/factorio

[Run]

Filename: "{tmp}\vc_redist.x64.exe"; Parameters: "/passive /norestart"; Check: IsVCRedist64BitNeeded; StatusMsg: "Installing VC++ redistributable..."
Filename: "{app}\ArchipelagoLttPAdjuster"; Parameters: "--update_sprites"; StatusMsg: "Updating Sprite Library..."; Components: client/sni/lttp or generator/lttp
Filename: "{app}\jre8\bin\java.exe"; Parameters: "-jar ""{app}\forge-installer.jar"" --installServer ""{app}\Minecraft Forge server"""; Flags: runhidden; Check: IsForgeNeeded(); StatusMsg: "Installing Forge Server..."; Components: client/minecraft

[UninstallDelete]
Type: dirifempty; Name: "{app}"

[InstallDelete]
Type: files; Name: "{app}\ArchipelagoLttPClient.exe"

[Registry]

Root: HKCR; Subkey: ".apbp";                                 ValueData: "{#MyAppName}patch";        Flags: uninsdeletevalue; ValueType: string;  ValueName: ""; Components: client/sni
Root: HKCR; Subkey: "{#MyAppName}patch";                     ValueData: "Archipelago Binary Patch"; Flags: uninsdeletekey;   ValueType: string;  ValueName: ""; Components: client/sni
Root: HKCR; Subkey: "{#MyAppName}patch\DefaultIcon";         ValueData: "{app}\ArchipelagoSNIClient.exe,0";                           ValueType: string;  ValueName: ""; Components: client/sni
Root: HKCR; Subkey: "{#MyAppName}patch\shell\open\command";  ValueData: """{app}\ArchipelagoSNIClient.exe"" ""%1""";                  ValueType: string;  ValueName: ""; Components: client/sni

Root: HKCR; Subkey: ".apm3";                                 ValueData: "{#MyAppName}smpatch";        Flags: uninsdeletevalue; ValueType: string;  ValueName: ""; Components: client/sni
Root: HKCR; Subkey: "{#MyAppName}smpatch";                     ValueData: "Archipelago Super Metroid Patch"; Flags: uninsdeletekey;   ValueType: string;  ValueName: ""; Components: client/sni
Root: HKCR; Subkey: "{#MyAppName}smpatch\DefaultIcon";         ValueData: "{app}\ArchipelagoSNIClient.exe,0";                           ValueType: string;  ValueName: ""; Components: client/sni
Root: HKCR; Subkey: "{#MyAppName}smpatch\shell\open\command";  ValueData: """{app}\ArchipelagoSNIClient.exe"" ""%1""";                  ValueType: string;  ValueName: ""; Components: client/sni

Root: HKCR; Subkey: ".apmc";                                  ValueData: "{#MyAppName}mcdata";         Flags: uninsdeletevalue; ValueType: string;  ValueName: ""; Components: client/minecraft
Root: HKCR; Subkey: "{#MyAppName}mcdata";                     ValueData: "Archipelago Minecraft Data"; Flags: uninsdeletekey;   ValueType: string;  ValueName: ""; Components: client/minecraft
Root: HKCR; Subkey: "{#MyAppName}mcdata\DefaultIcon";         ValueData: "{app}\ArchipelagoMinecraftClient.exe,0";                           ValueType: string;  ValueName: ""; Components: client/minecraft
Root: HKCR; Subkey: "{#MyAppName}mcdata\shell\open\command";  ValueData: """{app}\ArchipelagoMinecraftClient.exe"" ""%1""";                  ValueType: string;  ValueName: ""; Components: client/minecraft

Root: HKCR; Subkey: ".archipelago";                              ValueData: "{#MyAppName}multidata";        Flags: uninsdeletevalue; ValueType: string;  ValueName: ""; Components: server
Root: HKCR; Subkey: "{#MyAppName}multidata";                     ValueData: "Archipelago Server Data";       Flags: uninsdeletekey;  ValueType: string;  ValueName: ""; Components: server
Root: HKCR; Subkey: "{#MyAppName}multidata\DefaultIcon";         ValueData: "{app}\ArchipelagoServer.exe,0";                         ValueType: string;  ValueName: ""; Components: server
Root: HKCR; Subkey: "{#MyAppName}multidata\shell\open\command";  ValueData: """{app}\ArchipelagoServer.exe"" ""%1""";                ValueType: string;  ValueName: ""; Components: server



[Code]
const
  SHCONTCH_NOPROGRESSBOX = 4;
  SHCONTCH_RESPONDYESTOALL = 16;
  FORGE_VERSION = '1.16.5-36.2.0';

// See: https://stackoverflow.com/a/51614652/2287576
function IsVCRedist64BitNeeded(): boolean;
var
  strVersion: string;
begin
  if (RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64', 'Version', strVersion)) then
  begin
    // Is the installed version at least the packaged one ?
    Log('VC Redist x64 Version : found ' + strVersion);
    Result := (CompareStr(strVersion, 'v14.29.30037') < 0);
  end
  else
  begin
    // Not even an old version installed
    Log('VC Redist x64 is not already installed');
    Result := True;
  end;
end;

function IsForgeNeeded(): boolean;
begin
  Result := True;
  if (FileExists(ExpandConstant('{app}')+'\Minecraft Forge Server\forge-'+FORGE_VERSION+'.jar')) then
    Result := False;
end;

function IsJavaNeeded(): boolean;
begin
  Result := True;
  if (FileExists(ExpandConstant('{app}')+'\jre8\bin\java.exe')) then
    Result := False;
end;

function OnDownloadMinecraftProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded Minecraft additional files to {tmp}: %s', [FileName]));
  Result := True;
end;

procedure UnZip(ZipPath, TargetPath: string);
var
  Shell: Variant;
  ZipFile: Variant;
  TargetFolder: Variant;
begin
  Shell := CreateOleObject('Shell.Application');

  ZipFile := Shell.NameSpace(ZipPath);
  if VarIsClear(ZipFile) then
    RaiseException(
      Format('ZIP file "%s" does not exist or cannot be opened', [ZipPath]));

  TargetFolder := Shell.NameSpace(TargetPath);
  if VarIsClear(TargetFolder) then
    RaiseException(Format('Target path "%s" does not exist', [TargetPath]));

  TargetFolder.CopyHere(
    ZipFile.Items, SHCONTCH_NOPROGRESSBOX or SHCONTCH_RESPONDYESTOALL);
end;

var R : longint;

var rom: string;
var ROMFilePage: TInputFileWizardPage;

var smrom: string;
var SMRomFilePage: TInputFileWizardPage;

var soerom: string;
var SoERomFilePage: TInputFileWizardPage;

var ootrom: string;
var OoTROMFilePage: TInputFileWizardPage;

var MinecraftDownloadPage: TDownloadWizardPage;

procedure AddRomPage();
begin
  rom := FileSearch('Zelda no Densetsu - Kamigami no Triforce (Japan).sfc', WizardDirValue());
  if Length(rom) > 0 then
    begin
      log('existing ROM found');
      log(IntToStr(CompareStr(GetMD5OfFile(rom), '03a63945398191337e896e5771f77173')));
      if CompareStr(GetMD5OfFile(rom), '03a63945398191337e896e5771f77173') = 0 then
        begin
        log('existing ROM verified');
        exit;
        end;
      log('existing ROM failed verification');
    end;
  rom := ''
  ROMFilePage :=
    CreateInputFilePage(
      wpSelectComponents,
      'Select ROM File',
      'Where is your Zelda no Densetsu - Kamigami no Triforce (Japan).sfc located?',
      'Select the file, then click Next.');

  ROMFilePage.Add(
    'Location of ROM file:',
    'SNES ROM files|*.sfc|All files|*.*',
    '.sfc');
end;

procedure AddSMRomPage();
begin
  smrom := FileSearch('Super Metroid (JU).sfc', WizardDirValue());
  if Length(smrom) > 0 then
    begin
      log('existing SM ROM found');
      log(IntToStr(CompareStr(GetMD5OfFile(smrom), '21f3e98df4780ee1c667b84e57d88675')));
      if CompareStr(GetMD5OfFile(smrom), '21f3e98df4780ee1c667b84e57d88675') = 0 then
        begin
        log('existing SM ROM verified');
        exit;
        end;
      log('existing SM ROM failed verification');
    end;
  smrom := ''
  SMROMFilePage :=
    CreateInputFilePage(
      wpSelectComponents,
      'Select ROM File',
      'Where is your Super Metroid located?',
      'Select the file, then click Next.');

  SMROMFilePage.Add(
    'Location of Super Metroid ROM file:',
    'SNES ROM files|*.sfc|All files|*.*',
    '.sfc');
end;

procedure AddSoERomPage();
begin
  soerom := FileSearch('Secret of Evermore (USA).sfc', WizardDirValue());
  if Length(soerom) > 0 then
    begin
      log('existing SoE ROM found');
      log(IntToStr(CompareStr(GetMD5OfFile(soerom), '6e9c94511d04fac6e0a1e582c170be3a')));
      if CompareStr(GetMD5OfFile(soerom), '6e9c94511d04fac6e0a1e582c170be3a') = 0 then
        begin
        log('existing SoE ROM verified');
        exit;
        end;
      log('existing SM ROM failed verification');
    end;
  soerom := ''
  SoEROMFilePage :=
    CreateInputFilePage(
      wpSelectComponents,
      'Select ROM File',
      'Where is your Secret of Evermore located?',
      'Select the file, then click Next.');

  SoEROMFilePage.Add(
    'Location of Secret of Evermore ROM file:',
    'SNES ROM files|*.sfc|All files|*.*',
    '.sfc');
end;

procedure AddMinecraftDownloads();
begin
  MinecraftDownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadMinecraftProgress);
end;

procedure AddOoTRomPage();
begin
  ootrom := FileSearch('The Legend of Zelda - Ocarina of Time.z64', WizardDirValue());
  if Length(ootrom) > 0 then
    begin
      log('existing ROM found');
      log(IntToStr(CompareStr(GetMD5OfFile(ootrom), '5bd1fe107bf8106b2ab6650abecd54d6'))); // normal
      log(IntToStr(CompareStr(GetMD5OfFile(ootrom), '6697768a7a7df2dd27a692a2638ea90b'))); // byteswapped
      log(IntToStr(CompareStr(GetMD5OfFile(ootrom), '05f0f3ebacbc8df9243b6148ffe4792f'))); // decompressed
      if (CompareStr(GetMD5OfFile(ootrom), '5bd1fe107bf8106b2ab6650abecd54d6') = 0) or (CompareStr(GetMD5OfFile(ootrom), '6697768a7a7df2dd27a692a2638ea90b') = 0) or (CompareStr(GetMD5OfFile(ootrom), '05f0f3ebacbc8df9243b6148ffe4792f') = 0) then
        begin
        log('existing ROM verified');
        exit;
        end;
      log('existing ROM failed verification');
    end;
  ootrom := ''
  OoTROMFilePage :=
    CreateInputFilePage(
      wpSelectComponents,
      'Select ROM File',
      'Where is your OoT 1.0 ROM located?',
      'Select the file, then click Next.');

  OoTROMFilePage.Add(
    'Location of ROM file:',
    'N64 ROM files (*.z64, *.n64)|*.z64;*.n64|All files|*.*',
    '.z64');
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if (CurPageID = wpReady) and (WizardIsComponentSelected('client/minecraft')) then begin
    MinecraftDownloadPage.Clear;
    if(IsForgeNeeded()) then
      MinecraftDownloadPage.Add('https://maven.minecraftforge.net/net/minecraftforge/forge/'+FORGE_VERSION+'/forge-'+FORGE_VERSION+'-installer.jar','forge-installer.jar','');
    if(IsJavaNeedeD()) then
      MinecraftDownloadPage.Add('https://corretto.aws/downloads/latest/amazon-corretto-8-x64-windows-jre.zip','java.zip','');
    MinecraftDownloadPage.Show;
    try
      try
        MinecraftDownloadPage.Download;
        Result := True;
      except
        if MinecraftDownloadPage.AbortedByUser then
          Log('Aborted by user.')
        else
          SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
        Result := False;
      end;
    finally
      if( isJavaNeeded() ) then
        if(ForceDirectories(ExpandConstant('{app}'))) then
          UnZip(ExpandConstant('{tmp}')+'\java.zip',ExpandConstant('{app}'));
      MinecraftDownloadPage.Hide;
    end;
    Result := True;
  end else
    Result := True;
end;

procedure InitializeWizard();
begin                    
  AddOoTRomPage();
  AddRomPage();
  AddSMRomPage();
  AddSoeRomPage;
  AddMinecraftDownloads();
end;


function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;
  if (assigned(ROMFilePage)) and (PageID = ROMFilePage.ID) then
    Result := not (WizardIsComponentSelected('client/sni/lttp') or WizardIsComponentSelected('generator/lttp'));
  if (assigned(SMROMFilePage)) and (PageID = SMROMFilePage.ID) then
    Result := not (WizardIsComponentSelected('client/sni/sm') or WizardIsComponentSelected('generator/sm'));
  if (assigned(SoEROMFilePage)) and (PageID = SoEROMFilePage.ID) then
    Result := not (WizardIsComponentSelected('generator/soe'));
  if (assigned(OoTROMFilePage)) and (PageID = OoTROMFilePage.ID) then
    Result := not (WizardIsComponentSelected('generator/oot'));
end;

function GetROMPath(Param: string): string;
begin
  if Length(rom) > 0 then
    Result := rom
  else if Assigned(RomFilePage) then
    begin
      R := CompareStr(GetMD5OfFile(ROMFilePage.Values[0]), '03a63945398191337e896e5771f77173')
      if R <> 0 then
        MsgBox('ALttP ROM validation failed. Very likely wrong file.', mbInformation, MB_OK);
  
      Result := ROMFilePage.Values[0]
    end
  else
    Result := '';
 end;

function GetSMROMPath(Param: string): string;
begin
  if Length(smrom) > 0 then
    Result := smrom
  else if Assigned(SMRomFilePage) then
    begin
      R := CompareStr(GetMD5OfFile(SMROMFilePage.Values[0]), '21f3e98df4780ee1c667b84e57d88675')
      if R <> 0 then
        MsgBox('Super Metroid ROM validation failed. Very likely wrong file.', mbInformation, MB_OK);

      Result := SMROMFilePage.Values[0]
    end
  else
    Result := '';
 end;

function GetSoEROMPath(Param: string): string;
begin
  if Length(soerom) > 0 then
    Result := soerom
  else if Assigned(SoERomFilePage) then
    begin
      R := CompareStr(GetMD5OfFile(SoEROMFilePage.Values[0]), '6e9c94511d04fac6e0a1e582c170be3a')
      log(GetMD5OfFile(SoEROMFilePage.Values[0]))
      if R <> 0 then
        MsgBox('Secret of Evermore ROM validation failed. Very likely wrong file.', mbInformation, MB_OK);

      Result := SoEROMFilePage.Values[0]
    end
  else
    Result := '';
 end;

function GetOoTROMPath(Param: string): string;
begin
  if Length(ootrom) > 0 then
    Result := ootrom
  else if Assigned(OoTROMFilePage) then
    begin
      R := CompareStr(GetMD5OfFile(OoTROMFilePage.Values[0]), '5bd1fe107bf8106b2ab6650abecd54d6') * CompareStr(GetMD5OfFile(OoTROMFilePage.Values[0]), '6697768a7a7df2dd27a692a2638ea90b') * CompareStr(GetMD5OfFile(OoTROMFilePage.Values[0]), '05f0f3ebacbc8df9243b6148ffe4792f');
      if R <> 0 then
        MsgBox('OoT ROM validation failed. Very likely wrong file.', mbInformation, MB_OK);
  
      Result := OoTROMFilePage.Values[0]
    end
  else
    Result := '';
end;
