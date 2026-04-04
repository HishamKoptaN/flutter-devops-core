#define MyAppName "abujena_dawajen"
#define MyAppVersion "APP_VERSION_PLACEHOLDER"
#define MyAppPublisher "abujena_dawajen"
#define MyAppExeName "abujena_dawajen.exe"

[Setup]
; معرف فريد للتطبيق لضمان التحديث فوق النسخة القديمة
AppId={{D3B3A5E1-72C1-4B5D-9A9A-123456789ABC}
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
OutputBaseFilename=abujena_setup_v{#MyAppVersion}
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
; باستخدام {#SourcePath} سيعمل السكربت في أي مكان (محلي أو ريموت)
; 1. ملف التشغيل الأساسي
Source: "{#SourcePath}\..\build\windows\x64\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; 2. كافة ملفات الـ DLL ومجلد الـ data (ضروري للأيقونات والخطوط)
Source: "{#SourcePath}\..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "{#MyAppExeName}"

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; تشغيل البرنامج بعد انتهاء التثبيت (يتم تخطيه في الوضع الصامت)
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent