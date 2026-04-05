[Setup]
AppId={{APP_GUID_PLACEHOLDER}}
AppName=APP_NAME_PLACEHOLDERAPP_SUFFIX_PLACEHOLDER
AppVersion=APP_VERSION_PLACEHOLDER
AppPublisher=APP_PUBLISHER_PLACEHOLDER
DefaultDirName={autopf}\APP_NAME_PLACEHOLDERAPP_SUFFIX_PLACEHOLDER
DisableProgramGroupPage=yes
ShowLanguageDialog=no
DisableWelcomePage=yes
DisableDirPage=yes
DisableReadyPage=yes
DisableFinishedPage=yes
UsePreviousAppDir=yes
CloseApplications=yes
OutputDir=..\Output
OutputBaseFilename=setup_vAPP_VERSION_PLACEHOLDERAPP_SUFFIX_PLACEHOLDER
Compression=lzma
SolidCompression=yes
WizardStyle=modern
[Languages]
Name: "arabic"; MessagesFile: "compiler:Languages\Arabic.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"
[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
[Files]
Source: "..\build\windows\x64\runner\Release\APP_EXE_PLACEHOLDER"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "APP_EXE_PLACEHOLDER"
[Icons]
Name: "{autoprograms}\APP_NAME_PLACEHOLDERAPP_SUFFIX_PLACEHOLDER"; Filename: "{app}\APP_EXE_PLACEHOLDER"
Name: "{autodesktop}\APP_NAME_PLACEHOLDERAPP_SUFFIX_PLACEHOLDER"; Filename: "{app}\APP_EXE_PLACEHOLDER"; Tasks: desktopicon
[Run]
Filename: "{app}\APP_EXE_PLACEHOLDER"; Description: "{cm:LaunchProgram,APP_NAME_PLACEHOLDERAPP_SUFFIX_PLACEHOLDER}"; Flags: nowait postinstall skipifsilent