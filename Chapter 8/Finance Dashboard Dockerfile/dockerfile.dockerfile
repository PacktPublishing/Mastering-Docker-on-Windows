# Use the official ASP.NET 4.8 IIS image (Windows Server Core LTSC 2019)
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Set the working directory to the IIS web root
WORKDIR /inetpub/wwwroot

# Copy the application files into the container
COPY ./publish/ .

# Optional: ensure the App Pool starts cleanly and serves the site
SHELL ["powershell", "-Command"]
RUN Import-Module WebAdministration; \
    Set-ItemProperty 'IIS:\AppPools\DefaultAppPool' -Name processModel.identityType -Value ApplicationPoolIdentity; \
    Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name bindings -Value @{protocol='http';bindingInformation='*:80:'}

# Expose port 80 for the web app
EXPOSE 80

# Default IIS startup command
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
