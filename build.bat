@echo off
cd BuildTools
curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
set /p Input=Enter the version: || set Input=latest
del spigot*.jar
del craftbukkit*.jar
java -jar BuildTools.jar --rev %Input%
copy /b .\spigot*.jar ..\spigot.jar
cd BuildData/CraftBukkit
mvn install
cd ../..
cd BuildData/Spigot/Spigot-Api
mvn install