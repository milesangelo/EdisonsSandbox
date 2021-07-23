FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["EdisonsSandbox.csproj", "./"]
RUN dotnet restore "EdisonsSandbox.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "EdisonsSandbox.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "EdisonsSandbox.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "EdisonsSandbox.dll"]
