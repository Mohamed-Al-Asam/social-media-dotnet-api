FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8010

EXPOSE 8010

# copy csproj and restore as distinct layers
COPY *.sln .
COPY X.Data/*.*.csproj ./X.Data/
COPY X.Model/*.*.csproj ./X.Model/
COPY X.Web/*.*.csproj ./X.Web/

# copy everything else and build app
COPY X.Data/. ./X.Data/
COPY X.Model/. ./X.Model/
COPY X.Web/. ./X.Web/

RUN dotnet restore

WORKDIR /app/X.Web
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
FROM base AS final
WORKDIR /app
COPY --from=build /app/X.Web/out ./
ENTRYPOINT ["dotnet", "X.Web.dll"]