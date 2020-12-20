# escape= `
FROM mcr.microsoft.com/windows/servercore:1909 AS miniconda

WORKDIR /tmp

ADD https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe miniconda3.exe
# RUN powershell (New-Object System.Net.WebClient).DownloadFile('https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe', 'miniconda3.exe')
# RUN powershell Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'miniconda3.exe'

RUN powershell Unblock-File miniconda3.exe

RUN miniconda3.exe /InstallationType=JustMe /RegisterPython=1 /S /D=C:\miniconda3

FROM mcr.microsoft.com/windows/nanoserver:1909

COPY --from=miniconda C:\miniconda3 C:\Tools\miniconda

RUN setx /M PATH "%PATH%;C:\Tools\miniconda;C:\Tools\miniconda\Scripts;C:\Tools\miniconda\Library\bin"

CMD ["conda", "info"]