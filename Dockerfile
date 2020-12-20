# escape= `
FROM microsoft/windowsservercore:1909 AS miniconda

WORKDIR /tmp

RUN powershell (New-Object System.Net.WebClient).DownloadFile('https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe', 'Miniconda3.exe')

RUN powershell Unblock-File Miniconda3.exe

RUN Miniconda3.exe /InstallationType=JustMe /RegisterPython=1 /S /D=C:\Miniconda3

FROM microsoft/nanoserver:1909

COPY --from=miniconda C:\Miniconda3 C:\Tools\miniconda

RUN setx /M PATH "%PATH%;C:\Tools\miniconda;C:\Tools\miniconda\Scripts;C:\Tools\miniconda\Library\bin"

CMD ["conda", "info"]