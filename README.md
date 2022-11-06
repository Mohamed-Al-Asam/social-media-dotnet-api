# social-media-dotnet6-api
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0

dotnet new webapi -o src
dotnet new sln
dotnet sln add src
docker build . -t social_media_dotnet_api
docker run --name social_media_dotnet_api -p 8081:80 -d social_media_dotnet_api
docker ps

docker kill $(docker ps -q)
docker system prune --all --force --volumes