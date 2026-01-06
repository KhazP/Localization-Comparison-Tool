; Localization Comparison Tool - Inno Setup Script
; Version: 2.0.0
; Author: Alp Yalay

#define MyAppName "Localization Comparison Tool"
#define MyAppVersion "2.0.0"
#define MyAppPublisher "Alp Yalay"
#define MyAppURL "https://github.com/KhazP/Localization-Comparison-Tool"
#define MyAppExeName "localizer_app_main.exe"

[Setup]
; App identity
AppId={{8E7F3A5C-4B2D-4E9A-8F1C-3D6E7A8B9C0D}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/issues
AppUpdatesURL={#MyAppURL}/releases

; Paths
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=..\LICENSE
InfoBeforeFile=README.txt
InfoAfterFile=README.txt
OutputDir=..\dist
OutputBaseFilename=LocalizationComparisonTool-{#MyAppVersion}-setup
SetupIconFile=..\assets\logo\localizerapp.ico

; Installer settings
Compression=lzma2/ultra64
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
WizardStyle=modern
DisableProgramGroupPage=yes
AllowNoIcons=yes

; Disk space
DiskSpanning=no
ReserveBytes=104857600

; Version info for exe
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany={#MyAppPublisher}
VersionInfoCopyright=Copyright (C) 2026 {#MyAppPublisher}
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}

; Uninstaller
UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppName}

[Languages]
; Matching app's supported languages from settings_constants.dart
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "korean"; MessagesFile: "compiler:Languages\Korean.isl"

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "main"; Description: "Core Application"; Types: full custom; Flags: fixed
Name: "fileassoc"; Description: "File Associations (.arb, .xliff, .tmx)"; Types: full
Name: "protocol"; Description: "Protocol Handler (localizer://)"; Types: full
Name: "autostart"; Description: "Start with Windows"; Types: full

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "firewall"; Description: "Add Windows Firewall exception"; GroupDescription: "System Integration:"

[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: main
Source: "README.txt"; DestDir: "{app}"; Flags: ignoreversion; Components: main

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\README"; Filename: "{app}\README.txt"
Name: "{group}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
; File associations - ARB
Root: HKCR; Subkey: ".arb"; ValueType: string; ValueName: ""; ValueData: "LocalizerApp.ARB"; Flags: uninsdeletevalue; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.ARB"; ValueType: string; ValueName: ""; ValueData: "Flutter ARB Localization File"; Flags: uninsdeletekey; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.ARB\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.ARB\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Components: fileassoc

; File associations - XLIFF
Root: HKCR; Subkey: ".xliff"; ValueType: string; ValueName: ""; ValueData: "LocalizerApp.XLIFF"; Flags: uninsdeletevalue; Components: fileassoc
Root: HKCR; Subkey: ".xlf"; ValueType: string; ValueName: ""; ValueData: "LocalizerApp.XLIFF"; Flags: uninsdeletevalue; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.XLIFF"; ValueType: string; ValueName: ""; ValueData: "XLIFF Localization File"; Flags: uninsdeletekey; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.XLIFF\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.XLIFF\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Components: fileassoc

; File associations - TMX
Root: HKCR; Subkey: ".tmx"; ValueType: string; ValueName: ""; ValueData: "LocalizerApp.TMX"; Flags: uninsdeletevalue; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.TMX"; ValueType: string; ValueName: ""; ValueData: "Translation Memory eXchange File"; Flags: uninsdeletekey; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.TMX\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Components: fileassoc
Root: HKCR; Subkey: "LocalizerApp.TMX\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Components: fileassoc

; Protocol handler
Root: HKCR; Subkey: "localizer"; ValueType: string; ValueName: ""; ValueData: "URL:Localizer Protocol"; Flags: uninsdeletekey; Components: protocol
Root: HKCR; Subkey: "localizer"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Components: protocol
Root: HKCR; Subkey: "localizer\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Components: protocol
Root: HKCR; Subkey: "localizer\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Components: protocol

; Auto-start with Windows
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "{#MyAppName}"; ValueData: """{app}\{#MyAppExeName}"" --minimized"; Flags: uninsdeletevalue; Components: autostart

[Run]
; Add firewall exception
Filename: "netsh"; Parameters: "advfirewall firewall add rule name=""{#MyAppName}"" dir=in action=allow program=""{app}\{#MyAppExeName}"" enable=yes"; Flags: runhidden; Tasks: firewall
Filename: "netsh"; Parameters: "advfirewall firewall add rule name=""{#MyAppName}"" dir=out action=allow program=""{app}\{#MyAppExeName}"" enable=yes"; Flags: runhidden; Tasks: firewall

; Launch app after install
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
; Remove firewall exception on uninstall
Filename: "netsh"; Parameters: "advfirewall firewall delete rule name=""{#MyAppName}"""; Flags: runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{localappdata}\{#MyAppName}"
Type: filesandordirs; Name: "{userappdata}\{#MyAppName}"

[Code]
// Check for Visual C++ Redistributable (required by Flutter)
function VCRedistInstalled: Boolean;
var
  RegKey: String;
begin
  // Check for VC++ 2015-2022 Redistributable (x64)
  RegKey := 'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64';
  Result := RegKeyExists(HKLM, RegKey);

  if not Result then
  begin
    // Alternative registry path
    RegKey := 'SOFTWARE\WOW6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x64';
    Result := RegKeyExists(HKLM, RegKey);
  end;

  if not Result then
  begin
    // Check via installed programs
    Result := RegKeyExists(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A0EE78F6-9912-4C2C-97C0-98BC1F05AD17}');
  end;
end;

function InitializeSetup(): Boolean;
var
  ErrorCode: Integer;
begin
  Result := True;

  // Check for VC++ Redistributable
  if not VCRedistInstalled then
  begin
    if MsgBox('Visual C++ Redistributable 2015-2022 is required but not installed.' + #13#10 + #13#10 +
              'Would you like to download it now?' + #13#10 + #13#10 +
              'Click Yes to open the download page, then run the installer and restart this setup.',
              mbConfirmation, MB_YESNO) = IDYES then
    begin
      ShellExec('open', 'https://aka.ms/vs/17/release/vc_redist.x64.exe', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
    end;
    Result := MsgBox('Continue installation anyway?' + #13#10 + #13#10 +
                     'Note: The application may not work correctly without Visual C++ Redistributable.',
                     mbConfirmation, MB_YESNO) = IDYES;
  end;
end;

// Show disk space requirement
function NextButtonClick(CurPageID: Integer): Boolean;
var
  FreeMB, TotalMB: Cardinal;
  RequiredMB: Cardinal;
begin
  Result := True;

  if CurPageID = wpSelectDir then
  begin
    RequiredMB := 100; // 100 MB required
    GetSpaceOnDisk(ExpandConstant('{app}'), True, FreeMB, TotalMB);
    FreeMB := FreeMB div 1024; // Convert KB to MB

    if FreeMB < RequiredMB then
    begin
      MsgBox('Not enough disk space!' + #13#10 + #13#10 +
             'Required: ' + IntToStr(RequiredMB) + ' MB' + #13#10 +
             'Available: ' + IntToStr(FreeMB) + ' MB' + #13#10 + #13#10 +
             'Please select a different installation folder or free up some disk space.',
             mbError, MB_OK);
      Result := False;
    end;
  end;
end;
