@echo off
IF NOT EXIST BuildTools (
    mkdir BuildTools
)
cd BuildTools
curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
set /p Input=Enter the version: || set Input=latest
del spigot*.jar
del craftbukkit*.jar
java -jar BuildTools.jar --rev %Input% --compile craftbukkit
call mvn install:install-file ^
   -Dfile=./craftbukkit-%Input%.jar ^
   -DgroupId=org.bukkit ^
   -DartifactId=craftbukkit ^
   -Dversion=%Input% ^
   -Dpackaging=jar ^
   -DgeneratePom=true
java -jar BuildTools.jar --rev %Input%
call mvn install:install-file ^
   -Dfile=./spigot-1.16.3.jar ^
   -DgroupId=org.spigotmc ^
   -DartifactId=spigot-api ^
   -Dversion=1.16.3 ^
   -Dpackaging=jar ^
   -DgeneratePom=true
copy /b .\spigot*.jar ..\spigot.jar
pause