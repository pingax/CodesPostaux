!include "MUI2.nsh"


OutFile "CodesPostaux_setup.exe"

Name "Recherche de codes postaux"

InstallDir $PROGRAMFILES"\CDE56\CodesPostaux"

RequestExecutionLevel admin

!define MUI_WELCOMEFINISHPAGE_BITMAP side.bmp
!define MUI_UNWELCOMEFINISHPAGE_BITMAP side.bmp
!define MUI_ICON annuaire.ico
!define MUI_UNICON remove.ico
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\win.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis-r.bmp"
!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME 
!insertmacro MUI_PAGE_COMPONENTS
!define MUI_INSTFILESPAGE_PROGRESSBAR "colored"


!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH


!insertmacro MUI_LANGUAGE "French"

;Language strings
LangString DESC_Section1 ${LANG_FRENCH} "L'application en elle-m�me"
LangString DESC_Section2 ${LANG_FRENCH} "Cr�ation d'un raccourci dans le menu D�marrer"
LangString DESC_Section3 ${LANG_FRENCH} "Cr�ation d'un raccourci sur le bureau"




;!insertmacro MUI_FINISHPAGE_RUN

LangString MUI_TEXT_WELCOME_INFO_TITLE ${LANG_FRENCH} "Bienvenue"
LangString MUI_TEXT_WELCOME_INFO_TEXT ${LANG_FRENCH} "Cet assistant va vous permettre d'installer l'application permettant d'effectuer les op�rations sur les dossiers des usagers."
LangString MUI_TEXT_FINISH_TITLE ${LANG_FRENCH} "Installation termin�e !"
LangString MUI_TEXT_FINISH_SUBTITLE ${LANG_FRENCH} "L'installation de l'application s'est correctement d�roul�e."
LangString MUI_BUTTONTEXT_FINISH ${LANG_FRENCH} "Fermer"
LangString MUI_TEXT_FINISH_INFO_TITLE ${LANG_FRENCH} "Installation termin�e"
LangString MUI_TEXT_FINISH_INFO_TEXT ${LANG_FRENCH} "L'installation de l'application est maintenant termin�e.$\r$\nUn raccourci a �t� cr�e sur votre bureau.$\r$\nL'application est �galement accessible depuis le menu D�marrer (dossier CDE56)"

LangString MUI_INNERTEXT_COMPONENTS_DESCRIPTION_TITLE ${LANG_FRENCH} "Description du composant"
LangString MUI_UNTEXT_WELCOME_INFO_TITLE ${LANG_FRENCH} "D�sinstallation"
LangString MUI_UNTEXT_WELCOME_INFO_TEXT ${LANG_FRENCH} "Ce programme va supprimer l'application de votre ordinateur"
LangString MUI_UNTEXT_CONFIRM_TITLE ${LANG_FRENCH} "Confirmez-vous la suppression ?"
LangString MUI_UNTEXT_UNINSTALLING_TITLE ${LANG_FRENCH} "D�installation en cours"
LangString MUI_UNTEXT_FINISH_TITLE ${LANG_FRENCH} "La d�sinstallation de l'application est termin�e."
LangString MUI_UNTEXT_FINISH_INFO_TITLE ${LANG_FRENCH} "L'application a �t� correctement supprim� de votre ordinateur."

LangString DESC_app ${LANG_FRENCH} "L'application en elle-m�me (obligatoire)"
LangString DESC_link_menu ${LANG_FRENCH} "Ajouter les raccourcis dans le menu D�marrer"
LangString DESC_desktop_link ${LANG_FRENCH} "Ajouter un raccourci sur le bureau"


Section "Application" Section1
SectionIn RO
	
	SetOutPath $INSTDIR
	
	nsExec::Exec "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe install bin\x64\Release\CodesPostaux.exe"

	File bin\x64\Release\CodesPostaux.exe
	File /nonfatal /a /r bin\x64\Release\data\ data\


	

	WriteUninstaller uninstall.exe
SectionEnd

Section "Raccourci du Menu D�marrer" Section2
	CreateDirectory "$SMPROGRAMS\CDE56\CodesPostaux"
	
	CreateShortCut "$SMPROGRAMS\CDE56\CodesPostaux\CodesPostaux.lnk" "$INSTDIR\CodesPostaux.exe" "$INSTDIR\CodesPostaux.exe"
	
	CreateShortCut "$SMPROGRAMS\CDE56\CodesPostaux\D�sinstaller l'application.lnk" "$INSTDIR\uninstall.exe"
SectionEnd

Section "Raccourci sur le bureau" Section3
	CreateShortCut "$DESKTOP\CodesPostaux.lnk" "$INSTDIR\CodesPostaux.exe" "$INSTDIR\CodesPostaux.exe"
SectionEnd



Section "uninstall"

	Delete $INSTDIR\*
	RMDir /r $INSTDIR
	Delete "$SMPROGRAMS\CDE56\CodesPostaux\CodesPostaux.lnk"
	Delete "$DESKTOP\CodesPostaux.lnk"
	RMDir /r "$SMPROGRAMS\CDE56\CodesPostaux"
SectionEnd

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${Section1} $(DESC_app)
!insertmacro MUI_DESCRIPTION_TEXT ${Section2} $(DESC_link_menu)
!insertmacro MUI_DESCRIPTION_TEXT ${Section3} $(DESC_desktop_link)
!insertmacro MUI_FUNCTION_DESCRIPTION_END