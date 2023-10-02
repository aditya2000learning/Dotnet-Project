FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app
COPY ["DotNetApp.Web/DotNetApp.Web.csproj", "DotNetApp.Web/"]
RUN dotnet restore "DotNetApp.Web/DotNetApp.Web.csproj"
COPY . .
WORKDIR /app/DotNetApp.Web
RUN dotnet build "DotNetApp.Web.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "DotNetApp.Web.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotNetApp.Web.dll"]
