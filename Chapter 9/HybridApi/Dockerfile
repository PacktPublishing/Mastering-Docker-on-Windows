FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY ./publish .
ENTRYPOINT ["dotnet", "HybridApi.dll"]
