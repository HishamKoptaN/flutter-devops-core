#define MyAppName "APP_NAME_PLACEHOLDER"
#define MyAppVersion "APP_VERSION_PLACEHOLDER"
#define MyAppPublisher "APP_PUBLISHER_PLACEHOLDER"
#define MyAppExeName "APP_EXE_PLACEHOLDER"

[Setup]
; معرف فريد للتطبيق لضمان التحديث فوق النسخة القديمة
AppId={{APP_GUID_PLACEHOLDER}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes

; --- إعدادات التحديث الصامت والسلس (لإخفاء النوافذ التي ظهرت في صورك) ---
ShowLanguageDialog=no
DisableWelcomePage=yes
DisableDirPage=yes
DisableReadyPage=yes
DisableFinishedPage=yes
UsePreviousAppDir=yes
CloseApplications=yes

; --- إعدادات ملف المخرج ---
OutputDir={#SourcePath}
OutputBaseFilename=setup_v{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
; العربية هي الأولى لتكون الافتراضية
Name: "arabic"; MessagesFile: "compiler:Languages\Arabic.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Main executable
Source: "{#SourcePath}\..\build\windows\x64\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; All DLL files and data folder (includes flutter_windows.dll)
Source: "{#SourcePath}\..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "{#MyAppExeName}"

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent